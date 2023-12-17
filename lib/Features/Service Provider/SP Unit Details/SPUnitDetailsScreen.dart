
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Kashta%20Details%20Screen/KashtaDetailsScreen.dart';
import 'package:kashtat/Features/Map%20Screen/MapScreen.dart';
import 'package:kashtat/Features/More%20Screen/Widgets/ItemWidget.dart';
import 'package:kashtat/Features/Pricing%20Screen/PricingScreen.dart';
import 'package:kashtat/Features/Service%20Provider/Add%20New%20Unit/AddNewUnitScreen.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import '../../../Core/Cubit/AppCubit.dart';
import '../../../Core/Cubit/AppState.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/RoutesManager.dart';
import '../../Add Address Screen/AddAddressScreen.dart';
import '../../Add Name And DescriptionScreen/screen_51.dart';
import '../../Add New Unit Photos Screen/AddNewUnitPhotosScreen.dart';
import '../../Popup Image Slider/PopupSliderImage.dart';
import '../../Widgets/Loader.dart';

class SPUnitDetailsScreen extends StatelessWidget {
  const SPUnitDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(cubit.selectedUnit.name??''),
        backgroundColor: ColorManager.mainlyBlueColor,
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            ContainerDecorated(content: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>KashtaDetailsScreen(trip: cubit.selectedUnit,showButton: false,)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.lightGreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.eye,color: ColorManager.darkGreyColor,size: 15,),
                            SizedBox(width: 5,),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text('معاينة صفحتي',style: TextStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s14,
                                color: ColorManager.darkerGreyColor
                              ),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.lightGreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.shareAlt,color: ColorManager.darkGreyColor,size: 15,),
                          SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text('مشاركة صفحتي',style: TextStyle(
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s14,
                              color: ColorManager.darkerGreyColor
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
            ContainerDecorated(content: Column(children: [
              MoreItemWidget(title: 'الاسعار', img: ImageManager.pricing, onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PricingScreen(isCreateUnit: false,)));
              }),
              MoreItemWidget(title: 'الاعدادات',hint: isNotCompleted(context)? null:'غير مكتمل', img: ImageManager.settings, onTap: (){
                context.push(ScreenName.serviceProviderSettings);
              }),
            ],)),
            Item(title: 'حالة عرض الكشتة', content:  Row(
              children: [
                Text('الحالة',style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.bold,
                ),),
                Spacer(),
                FaIcon(!cubit.selectedUnit.isActive!?FontAwesomeIcons.solidEyeSlash:FontAwesomeIcons.solidEye,size: 15,color: !cubit.selectedUnit.isActive!?ColorManager.redColor:ColorManager.mintGreenColor,),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(cubit.selectedUnit.isActive!?'معروض':'غير معروض',style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.medium,
                      color: cubit.selectedUnit.isActive!?ColorManager.mintGreenColor:ColorManager.redColor,
                  ),),
                ),
              ],
            ), buttonTxt: 'تغيير الحالة إلى ${!cubit.selectedUnit.isActive!?'معروض':'غير معروض'}',onTap: (){
              cubit.updateUnitStatus(status: !cubit.selectedUnit.isActive!,unitId: cubit.selectedUnit.id!);
            },isLoading: state is UpdateUnitStatusLoadingState),
            Item(title: 'معلومات الكشتة', content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [

                    Text('الاسم',style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                    ),),
                    Spacer(),
                    Text(cubit.selectedUnit.name??'',style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.darkerGreyColor
                    ),),
                  ],
                ),
                const SizedBox(height: 10),
                Text('الوصف',style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.bold,
                ),),
                const SizedBox(height: 5),
                Text(cubit.selectedUnit.description??'',style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.darkerGreyColor
                ),),
              ],
            ), buttonTxt: 'تعديل',onTap: (
                ){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNameAndDescriptionScreen(isUpdate: true,serviceName: cubit.getCategoryServiceName(cubit.selectedUnit.category?.id??-1, cubit.selectedUnit.subCategory!.id))));
            },),
            // Item(title: 'تصنيف الكشتة', content: Column(
            //   children: [
            //     Row(
            //       children: [
            //
            //         Text('التصنيف',style: TextStyle(
            //           fontSize: FontSize.s14,
            //           fontWeight: FontWeightManager.bold,
            //         ),),
            //         Spacer(),
            //         Text(cubit.selectedUnit.category?.name??'',style: TextStyle(
            //             fontSize: FontSize.s14,
            //             fontWeight: FontWeightManager.medium,
            //             color: ColorManager.darkerGreyColor
            //         ),),
            //       ],
            //     ),
            //     // if(cubit.selectedUnit.subCategory!=null)
            //     // const SizedBox(height: 10),
            //     // if(cubit.selectedUnit.subCategory!=null)
            //     // Row(
            //     //   children: [
            //     //     Text('التصنيف الفرعي',style: TextStyle(
            //     //       fontSize: FontSize.s14,
            //     //       fontWeight: FontWeightManager.bold,
            //     //     ),),
            //     //     Spacer(),
            //     //     Text(cubit.selectedUnit.subCategory?.name??'',style: TextStyle(
            //     //         fontSize: FontSize.s14,
            //     //         fontWeight: FontWeightManager.medium,
            //     //         color: ColorManager.darkerGreyColor
            //     //     ),),
            //     //   ],
            //     // ),
            //   ],
            // ), buttonTxt: 'تعديل',onTap: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewUnitScreen(isUpdate: true,)));
            // },),
            Item(title: 'عنوان الكشتة', content: Column(
              children: [
                Row(
                  children: [

                    Text('المدينة',style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                    ),),
                    Spacer(),
                    Text(cubit.selectedUnit.city?.name??'',style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.darkerGreyColor
                    ),),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [

                    Text('الحي',style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                    ),),
                    Spacer(),
                    Text(cubit.selectedUnit.state?.name??'',style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.darkerGreyColor
                    ),),
                  ],
                ),
              ],
            ), buttonTxt: 'تعديل',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddAddressScreen(isUpdate:true)));
            },),
            Item(title: 'الموقع على الخريطة', content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('اشبيلية, 6416 , الرياض 4007 السعودية',style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.darkerGreyColor
                ),),
                SizedBox(height: 10),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(ImageManager.map,width: double.infinity,fit: BoxFit.contain,),
                )
              ],
            ), buttonTxt: 'تعديل',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen(isUpdate: true,lat: cubit.selectedUnit.latitude??0.0,long: cubit.selectedUnit.longitude??0.0)));
            },
            )
            ,
            Item(title: 'الصور', content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6 صور',style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.darkerGreyColor
                ),),
                SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                    ),
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: ListView.builder(
                          itemCount: cubit.selectedUnit.pics?.length??0,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                      transitionsBuilder: (context, animation, __, child) {
                                        return Align(
                                          child: SizeTransition(
                                            sizeFactor: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                      pageBuilder: (context, _, __) => ShowImages(index: index,imagesUrl: cubit.selectedUnit.pics??[]),
                                      opaque: false,
                                      barrierColor: Colors.black.withOpacity(0.3)
                                  ),
                                );

                              },
                              child: SizedBox(
                                width: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: cubit.selectedUnit.pics![index],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Loader(),
                                    errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined,color: Colors.grey,),

                                  ),
                                ),
                              ),
                            ),
                          )),
                    )),
                // SizedBox(
                //   height: 80,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 6,
                //       itemBuilder: (context,index){
                //     return  Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: SizedBox(
                //         height: 80,
                //         width: 90,
                //         child: ClipRRect(
                //             borderRadius: BorderRadius.circular(10),
                //             child: Image.asset(ImageManager.person,fit: BoxFit.fill,)),
                //       ),
                //     );
                //   }),
                // )
              ],
            ), buttonTxt: 'تعديل',onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNewUnitPhotosScreen(isUpdate: true,)));
            },),
            Item(title: 'تصنيف الكشتة', content: Column(
              children: [
                Row(
                  children: [

                    Text('التصنيف',style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                    ),),
                    Spacer(),
                    Text(cubit.selectedUnit.category?.name??'',style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.darkerGreyColor
                    ),),
                  ],
                ),
                // if(cubit.selectedUnit.subCategory!=null)
                // const SizedBox(height: 10),
                // if(cubit.selectedUnit.subCategory!=null)
                // Row(
                //   children: [
                //     Text('التصنيف الفرعي',style: TextStyle(
                //       fontSize: FontSize.s14,
                //       fontWeight: FontWeightManager.bold,
                //     ),),
                //     Spacer(),
                //     Text(cubit.selectedUnit.subCategory?.name??'',style: TextStyle(
                //         fontSize: FontSize.s14,
                //         fontWeight: FontWeightManager.medium,
                //         color: ColorManager.darkerGreyColor
                //     ),),
                //   ],
                // ),
              ],
            ), buttonTxt: 'تعديل',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewUnitScreen(isUpdate: true,)));
            },),
            // Item(title: 'وصف الكشتة', content: Text('مخيم العارض في الثمامة يحتوي على ثالث مخيمات ومجلس ومشب ومطبخ للإيجار اليومي',style: TextStyle(
            //     fontSize: FontSize.s14,
            //     fontWeight: FontWeightManager.medium,
            //     color: ColorManager.darkerGreyColor
            // ),), buttonTxt: 'تعديل',onTap: (){},),
          ],),
        ),
      ),
    );
  },
);
  }

  bool isNotCompleted(BuildContext context){
    final cubit = BlocProvider.of<AppBloc>(context);
    if(cubit.selectedUnit.instruction1!.isEmpty||cubit.selectedUnit.instruction2!.isEmpty){
      return false;
    }else if(cubit.selectedUnit.cancellationPolicy!.isEmpty){
      return false;
    }else if(cubit.selectedUnit.reservationRoles!.isEmpty){
      return false;
    }else{
      return true;
    }
  }

}

class Item extends StatelessWidget {
  const Item({Key? key,required this.title, required this.content, required this.buttonTxt, required this.onTap, this.isLoading = false}) : super(key: key);
  final String title;
  final String buttonTxt;
  final Widget content;
  final Function() onTap;
  final bool isLoading;


  @override
  Widget build(BuildContext context) {
    return
      ContainerDecorated(
          content: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.mainlyBlueColor
                ),),
                const SizedBox(height: 10),
                content,
                const SizedBox(height: 40),
                KButton(onTap: onTap , title: buttonTxt,width: double.infinity,paddingV: 15,isLoading: isLoading,)

              ],
            ),
          ));
  }

}

