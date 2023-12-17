import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Features/Widgets/HeaderWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'dart:ui' as ui;


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, this.showSelectLocation = true, this.lat = 24.780952, this.long = 46.808738, this.isUpdate = false}) : super(key: key);
  final bool showSelectLocation;
  final double lat;
  final double long;
  final bool isUpdate;

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.780952, 46.808738),
    zoom: 8,
  );

   CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(24.780952, 46.808738),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.lat, widget.long),
        zoom: 8,);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
  listener: (context, state) {
    // final cubit = BlocProvider.of<AppBloc>(context);
    // if(state is UpdateUnitMapLocationSuccessState){
    //   // cubit.setSelectedUnit(cubit.selectedUnit.copyWith(
    //   //   latitude: _kLake.target.latitude,
    //   //   longitude: _kLake.target.longitude,
    //   // ));
    // }
  },
  builder: (context, state) {
    return Scaffold(
      body: Column(
        children: [

          const HeaderWidget(allowToBack: true),
          Expanded(
            child: GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) async{
                _controller.complete(controller);
                if(widget.showSelectLocation && !widget.isUpdate){
                  _moveToCurrentLocation();
                }else{
                  _moveMarker(widget.lat, widget.long);
                  _moveCamera(widget.lat, widget.long);
                }
              },
              onTap: (LatLng latLong){
                _moveCamera(latLong.latitude, latLong.longitude);
                print("${latLong.latitude} ---- ${latLong.longitude}");
              },
              markers: Set<Marker>.of(markers.values),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !widget.showSelectLocation?null: FloatingActionButton.extended(
        backgroundColor: ColorManager.mainlyBlueColor,
        onPressed: ()async{
          final cubit = BlocProvider.of<AppBloc>(context,listen: false);
          cubit.updateNewUnitLocation(latitude: _kLake.target.latitude, longitude: _kLake.target.longitude,);

          if(widget.isUpdate){
            await cubit.updateUnitMapLocation(unitId: cubit.selectedUnit.id??-1);
          }
          context.pop();
        },
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              if(state is UpdateUnitMapLocationLoadingState)
                const SizedBox(
                  height: 10,
                  width: 10,
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 10.0,
                  ),
                ),
              if(state is UpdateUnitMapLocationLoadingState)
                SizedBox(width: 10,),
               Text(widget.isUpdate?'تحديث المكان':'اختر المكان'),
            ],
          ),
        ),
      ),
    );
  },
);
  }


  void _moveToCurrentLocation()async{
    Position location = await _determinePosition();
    _moveCamera(location.latitude, location.longitude);
  }

  Future<void> _moveCamera(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _kLake = CameraPosition(
          // bearing: 192.8334901395799,
          target: LatLng(lat, long),
          tilt: 30,
          zoom: 16);
    });
    _moveMarker(lat, long);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void _moveMarker(double lat, double long)async {
    var markerIdVal = 'MapMarkerId';
    final MarkerId markerId = MarkerId(markerIdVal);
    final Uint8List markerIcon = await getBytesFromAsset("assets/icons/marker.png", 150);
    // final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat,long),
      // infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () async{
        final url ='https://www.google.com/maps/dir/?api=1&destination=$lat,$long&travelmode=driving&dir_action=navigate';
        launchURL(url);
      },
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }



}
