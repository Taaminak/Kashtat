import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Core/constants/RoutesManager.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Features/Kashta%20Details%20Screen/KashtaDetailsScreen.dart';
import 'package:kashtat/Features/Widgets/Loader.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    Key? key,
    required this.trip,
    required this.isAvailable,
    required this.city,
  }) : super(key: key);
  final UnitModel trip;
  final bool isAvailable;
  final String city;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>KashtaDetailsScreen(trip: trip)));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: trip.mainPic??'',
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Loader(),
                    errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
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
                    const SizedBox(width: 10),
                    Text(
                      trip.rate!.toString(),
                      style: TextStyle(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.darkerGreyColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'عدد الحجوزات: ${trip.reservationsCount}',
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.blackColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${trip.name}',
                      style: TextStyle(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    Spacer(),
                    if(cubit.selectedDates.isNotEmpty)
                    Text(
                      isAvailable?"متاح":"غير متاح",
                      style: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                        color: isAvailable? ColorManager.greenColor: ColorManager.redColor,
                      ),
                    ),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        color: ColorManager.orangeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                        child: Text(
                          '${calculatePrice(cubit.selectedDates, trip.price??Price()).max} ر.س/ليلة',
                          style: TextStyle(
                            color: ColorManager.whiteColor,
                            fontSize: FontSize.s14,

                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width,
                            child: Text("اجمالي (ليلة واحدة) ${calculatePrice(cubit.selectedDates, trip.price??Price()).average} ر.س", style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeightManager.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if(cubit.selectedDates.isNotEmpty)
                          SizedBox(
                            width: size.width,
                            child: Text("إجمالي ${cubit.selectedDates.length} ليالي ${calculatePrice(cubit.selectedDates, trip.price??Price()).total} ر.س", style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeightManager.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text(
                      'كود الوحدة (${trip.id})',
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.blackColor,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.place_outlined,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:   5.0),
                      child: Text(
                        (trip.city?.name??'').capitalize()
                        ,
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    width: size.width,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor:  const Color(0xff482383) ,
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>KashtaDetailsScreen(trip: trip)));
                        // context.push(ScreenName.kashtaDetails);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(LocaleKeys.more.tr().capitalize()),
                      ),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String getNumber(UnitModel trip){
  return "0";
  // return DateTime.parse(trip.leavingDateTime).difference(DateTime.parse(trip.arrivalDateTime)).inDays.toString();
  // return '${num.parse(DateFormat('dd').format(DateTime.parse(trip.leavingDateTime)))-num.parse(DateFormat('dd').format(DateTime.parse(trip.arrivalDateTime)))}';
}