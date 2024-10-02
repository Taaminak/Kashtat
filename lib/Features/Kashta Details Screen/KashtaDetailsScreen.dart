// import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Core/constants/RoutesManager.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Features/Map%20Screen/MapScreen.dart';
import 'package:kashtat/Features/Popup%20Image%20Slider/PopupSliderImage.dart';
import 'package:kashtat/Features/Request%20Details/RequestDetailsScreen.dart';
import 'package:kashtat/Features/Widgets/HeaderWidget.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kashtat/Core/Edited%20Packages/customDateRangePicker.dart';
import '../../Core/Extentions/extention.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../Home Screen/Widgets/TypeWidget.dart';
import '../Login Screen/LoginScreen.dart';
import '../OTP Screen/OTPScreen.dart';
import '../Register Screen/RegisterScreen.dart';
import '../Wallet Logs Screen/Widgets/WalletItemWidget.dart';
import '../Widgets/Loader.dart';

class KashtaDetailsScreen extends StatefulWidget {
  const KashtaDetailsScreen({Key? key, required this.trip, this.showButton=true}) : super(key: key);
  final UnitModel trip;
  final bool showButton;

  @override
  State<KashtaDetailsScreen> createState() => _KashtaDetailsScreenState();
}

class _KashtaDetailsScreenState extends State<KashtaDetailsScreen> {
  bool enablePickDateTime = false;
  DateTime? selectedDate = DateTime.now();


  List<String> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<String> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      Intl.withLocale("en_US", () {
        days.add(DateFormat('y-MM-dd').format(startDate.add(Duration(days: i))));
      });
    }
    return days;
  }


  late UnitModel trip;

  bool isLoggedIn = false;

  @override
  void initState() {
    trip = widget.trip;

    final cubit = BlocProvider.of<AppBloc>(context);
    setState(() {
      selectedDates = cubit.selectedDates;
      _dates = cubit.selectedDates.map((e) => DateTime.parse(e)).toList();
    });
    isLogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const Material(elevation: 5, child: HeaderWidget(allowToBack: true)),
            Expanded(
              child: ExpandableBottomSheet(
                persistentContentHeight: 85,
                background: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 130.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 80,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Image.asset(
                                  ImageManager.rectangleBgWithMixedColor,
                                  height: 40,
                                  width: size.width,
                                ),
                              ),
                              Positioned(
                                  child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.white,
                                        child: CachedNetworkImage(
                                          imageUrl: trip.provider?.avatar??'',
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Loader(),
                                          errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                                        ))),
                              ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(ImageManager.verified, width: 20),
                            const SizedBox(width: 5),
                            Text(
                              trip.name??'',
                              style: TextStyle(
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: FontSize.s18),
                            ),
                          ],
                        ),
                        Text(
                          '${LocaleKeys.evaluation_request.tr()} ${trip.rate}',
                          style: TextStyle(
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s12),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 5; i++)
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.star,
                                  color: (i+1)>trip.rate!.round()?Colors.grey:ColorManager.yellowColor,
                                  size: 15,
                                ),
                              )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(ImageManager.marker,
                                color: ColorManager.lightBlueColor, width: 12),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(showSelectLocation: false,lat: widget.trip.latitude??0.0,long: widget.trip.longitude??0.0,)));
                              },
                              child: Text(
                                widget.trip.city?.name??'',
                                style: TextStyle(
                                    color: ColorManager.lightBlueColor,
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.medium),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'كود الوحدة (${trip.id})',
                              style: TextStyle(
                                  color: ColorManager.blackColor,
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeightManager.medium),
                            ),
                            const SizedBox(width: 20),
                            Icon(
                              Icons.ios_share_outlined,
                              size: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'مشاركة',
                              style: TextStyle(
                                  color: ColorManager.blackColor,
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeightManager.medium),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                            decoration: BoxDecoration(
                              color: ColorManager.whiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset:
                                      Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            height: 180,
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: ListView.builder(
                                  itemCount: trip.pics?.length??0,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black12),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowImages(index: index,imagesUrl: trip.pics??[]))
                                                  // PageRouteBuilder(
                                                  //     transitionsBuilder: (context, animation, __, child) {
                                                  //       return Align(
                                                  //         child: SizeTransition(
                                                  //           sizeFactor: animation,
                                                  //           child: child,
                                                  //         ),
                                                  //       );
                                                  //     },
                                                  //     pageBuilder: (context, _, __) => ShowImages(index: index,imagesUrl: trip.pics??[]),
                                                  //     opaque: false,
                                                  // barrierColor: Colors.black.withOpacity(0.3)
                                                  // ),
                                                );

                                              },
                                              child: CachedNetworkImage(
                                                  imageUrl: trip.pics![index],
                                                  fit: BoxFit.cover,
                                                  width: 133,
                                                  height: 150,
                                                  placeholder: (context, url) => const Loader(),
                                                  errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                                                ),
                                            ),
                                          ),
                                        ),
                                      )),
                            )),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.orangeColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12),
                                  child: Text(
                                    "${trip.subtotal} ${LocaleKeys.riyal.tr()}",
                                    style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: FontSize.s14,
                                      color: ColorManager.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text(
                                'الوصف',
                                style: TextStyle(
                                  fontSize: FontSize.s20,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.trip.description??'',
                                    style: TextStyle(
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: FontSize.s16,
                                      color: ColorManager.blackColor.withOpacity(0.7),
                                    ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ContainerDecorated(
                              content: Column(
                            children: [
                              if(widget.showButton)
                              Row(
                                children: [
                                  Text(
                                    'تفاصيل الحجز',
                                    style: TextStyle(
                                      fontSize: FontSize.s18,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                  Text(
                                    '  ( ${cubit.selectedDates.length} ليالي)',
                                    style: TextStyle(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeightManager.medium,
                                    ),
                                  ),
                                  Spacer(),
                                  FaIcon(
                                    FontAwesomeIcons.pencilAlt,
                                    size: 12,
                                    color: ColorManager.darkerGreyColor,
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: (){
                                      _selectDate(context);
                                      // setState(() {
                                      //   enablePickDateTime = !enablePickDateTime;
                                      // });
                                    },
                                    child: Text(
                                      'تعديل التاريخ',
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        color: ColorManager.darkerGreyColor,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if(widget.showButton)
                              SizedBox(height: 20),
                              if(widget.showButton)
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'تاريخ الوصول',
                                              style: TextStyle(
                                                fontSize: FontSize.s16,
                                                fontWeight: FontWeightManager.bold,
                                              ),
                                            ),
                                            // SizedBox(width: 10,),
                                            // InkWell(
                                            //   onTap: !enablePickDateTime? null:(){
                                            //     _selectDate(context);
                                            //   },
                                            //   child: FaIcon(FontAwesomeIcons.pencil,size: 15,color:enablePickDateTime? ColorManager.orangeColor :ColorManager.darkerGreyColor,),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          cubit.selectedDates.isEmpty? 'لا يوجد تاريخ':DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(cubit.selectedDates.first)),
                                          // DateFormat.yMMMMd().format(DateTime.parse(trip.arrivalDateTime)),
                                          style: TextStyle(
                                            fontSize: FontSize.s14,
                                            color: ColorManager.darkerGreyColor,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'تاريخ المغادرة',
                                              style: TextStyle(
                                                fontSize: FontSize.s16,
                                                fontWeight: FontWeightManager.bold,
                                              ),
                                            ),
                                            // SizedBox(width: 10,),
                                            // InkWell(
                                            //   onTap: !enablePickDateTime? null:(){
                                            //     _selectDate(context);
                                            //   },
                                            //   child: FaIcon(FontAwesomeIcons.pencil,size: 15,color:enablePickDateTime? ColorManager.orangeColor :ColorManager.darkerGreyColor,),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          cubit.selectedDates.isEmpty? 'لا يوجد تاريخ':DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(cubit.selectedDates.last)),
                                          // DateFormat.yMMMMd().format(DateTime.parse(trip.leavingDateTime)),
                                          style: TextStyle(
                                            fontSize: FontSize.s14,
                                            color: ColorManager.darkerGreyColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(widget.showButton)
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'وقت الوصول',
                                          style: TextStyle(
                                            fontSize: FontSize.s16,
                                            fontWeight: FontWeightManager.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          '10 صباحا',
                                          // DateFormat('kk:mm').format(DateTime.parse(trip.arrivalDateTime)),
                                          style: TextStyle(
                                            fontSize: FontSize.s14,
                                            color: ColorManager.darkerGreyColor,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'وقت المغادرة',
                                          style: TextStyle(
                                            fontSize: FontSize.s16,
                                            fontWeight: FontWeightManager.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          '10 مساءا',
                                          // DateFormat('kk:mm').format(DateTime.parse(trip.leavingDateTime)),
                                          style: TextStyle(
                                            fontSize: FontSize.s14,
                                            color: ColorManager.darkerGreyColor,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )),
                        ),
                        if(cubit.unitBody.subCategoryId != 8)
                        SizedBox(height: 20),
                        if(cubit.unitBody.subCategoryId != 8)
                        SizedBox(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'عدد الاشخاص الذين تسعهم الكشتة',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    widget.trip.capacity.toString(),
                                    // DateFormat('kk:mm').format(DateTime.parse(trip.arrivalDateTime)),
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.blackColor.withOpacity(0.7)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'شروط الحجز',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                      widget.trip.instruction1.toString(),style: TextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.blackColor.withOpacity(0.7)
                                    ),
                                  ),
                                ),Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                      widget.trip.instruction2.toString(),style: TextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.blackColor.withOpacity(0.7)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'سياسة الإلغاء والتأجيل',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                      widget.trip.cancellationPolicy.toString(),
                                    style: TextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.blackColor.withOpacity(0.7)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                persistentHeader: !widget.showButton? SizedBox():Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    color: ColorManager.whiteColor,
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorManager.greyColor,
                      ),
                    ),
                  ),
                ),
                expandableContent: !widget.showButton? SizedBox():Container(
                  // height: 500,
                  color: ColorManager.whiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0,bottom: 15.0,left: 30.0,),
                        child: SizedBox(
                            width: size.width,
                            child: ElevatedButton(
                              style:ButtonStyle(
                                backgroundColor:MaterialStateProperty.all<Color>(ColorManager.mainlyBlueColor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                ),
                              ),
                              onPressed:isAvailableDates(trip.reservedDates??[],cubit.selectedDates)? () {
                                if(!isLoggedIn){
                                  userLogin(context);
                                }else{

                                  if(cubit.selectedDates.isEmpty){

                                    final snackBar = SnackBar(
                                      content: Center(child: Text('من فضلك اختر الايام',textAlign: TextAlign.center,)),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    return;
                                  }

                                  BlocProvider.of<AppBloc>(context).setReserveTripData(unit: trip);
                                  Navigator.push(context, MaterialPageRoute( builder: (context) => RequestDetailsScreen(trip: trip)) );
                                }
                              }:(){},
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${calculatePrice(cubit.selectedDates, trip.price??Price()).average} ر.س / ليلة',
                                            style: TextStyle(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeightManager.bold,
                                                color: Colors.white
                                            ),
                                          ),
                                          Text(
                                            'إجمالي ${cubit.selectedDates.length} ليالي ${calculatePrice(selectedDates, trip.price??Price()).total + (calculatePrice(selectedDates, trip.price??Price()).total*0.15)} ر.س',
                                            style: TextStyle(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeightManager.bold,color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Center(
                                      child: Text(isAvailableDates(trip.reservedDates??[],cubit.selectedDates)?'أححز الآن':'غير متاح',
                                        style: TextStyle(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.bold,
                                          color: isAvailableDates(trip.reservedDates??[],cubit.selectedDates)? Colors.white: ColorManager.redColor,
                                        ),),
                                    )),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> isLogged()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false ;
    });
  }
  userLogin(BuildContext context){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())).then((value){

      if(value == null){

      }
      else if(value[0] == 'otp'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen())).then((value){
          if(value == null){
            userLogin(context);
          }else{
            isLogged();
          }
        });
      }else if(value[0] == 'register'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen())).then((value){
          // registerActions(context, value );
          print('-----------------------------register--------------------');
          print(value);
          print('-------------------------------------------------');

          if(value == null){
            userLogin(context);
          }else if(value[0] == 'otp'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen())).then((value){

              if(value == null){
                userLogin(context);
              }else{
                isLogged();
              }
            });
          }
        });
      }
    });
  }


  DateTime? startDate;
  DateTime? endDate;
  List<String> selectedDates = [];
  List<DateTime?> _dates = [];

  _selectDate(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: CalendarDatePicker2WithActionButtons(
              config: CalendarDatePicker2WithActionButtonsConfig(
                // firstDayOfWeek: 1,

                calendarType: CalendarDatePicker2Type.range,
                selectedDayTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                selectedDayHighlightColor: Colors.purple[800],
                centerAlignModePicker: true,
                dayBuilder: ({
                  required date,
                  textStyle,
                  decoration,
                  isSelected,
                  isDisabled,
                  isToday,
                }) {
                  Widget? dayWidget;
                  if (calculateDifference(date)<0) {
                    dayWidget = Container(
                      decoration: decoration,
                      child: Center(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Text(
                              MaterialLocalizations.of(context).formatDecimal(date.day),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 27.5),
                            //   child: Container(
                            //     height: 4,
                            //     width: 4,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       color: isSelected == true
                            //           ? Colors.white
                            //           : Colors.grey[500],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  }
                  return dayWidget;
                },
              ),
              value: _dates,
              onValueChanged: (dates) async {
                setState(() {
                  _dates = dates;
                });

                print(_dates);
                if (_dates.isNotEmpty) {
                  if(calculateDifference(_dates.first??DateTime.now())<0){
                    return;
                  }
                  setState(() {
                    endDate = _dates.last;
                    startDate = _dates.first;
                  });
                  if (_dates.length == 1) {
                    setState(() {
                      selectedDates = formatSelectedDays(_dates);
                    });
                  } else {
                    setState(() {
                      selectedDates = getDaysInBetween(_dates.first??DateTime.now(), _dates.last??DateTime.now());
                    });
                  }

                  Navigator.pop(context);
                  final cubit = BlocProvider.of<AppBloc>(context);
                  cubit.setSelectedDates(selectedDates);
                }
              },
              onCancelTapped: () {
                Navigator.pop(context);
                if (selectedDates.isEmpty) {
                  return;
                }

                setState(() {
                  endDate = null;
                  startDate = null;
                  selectedDates = [];
                  _dates = [];
                });
                final cubit = BlocProvider.of<AppBloc>(context);
                // cubit.shuffleHomeUnites();
                // images.shuffle();
                // cubit.getHomeTrips(dates:selectedDates.isEmpty?null: selectedDates,cityId: selectedCity==-1?null :cubit.allCities[selectedCity].id);
                cubit.setSelectedDates(selectedDates);
              },
            ),
          ),
        );
      },
    );
  }


  List<String> formatSelectedDays(List<DateTime?> dates) {
    List<String> days = [];
    for (int i = 0; i < dates.length; i++) {
      Intl.withLocale("en_US", () {
        days.add(DateFormat('y-MM-dd').format(dates[i]!));
      });
    }
    return days;
  }
}


bool isAvailableDates<T>(List<String> first, List<String> second) {
  if(second.isEmpty){
    return true;
  }
  List<String> output = [];
  for (String element in first) {
    if(second.contains(element.split(' ').first)){
      output.add(element);
      break;
    }
  }
  // print('---------------------------------------------------------------------------');
  // print(first);
  // print(second);
  // print(output);
  // print('---------------------------------------------------------------------------');
  return output.isEmpty;
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  int days = DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  return days;
}