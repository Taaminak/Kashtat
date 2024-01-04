import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Features/Pricing%20Screen/PricingScreen.dart';
import '../../../Core/Cubit/AppCubit.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/FontManager.dart';
import '../../../Core/constants/ImageManager.dart';
import '../../../Core/constants/app_size.dart';
import '../../../Features/Wallet Logs Screen/Widgets/WalletItemWidget.dart';
import '../../../Features/Widgets/kButton.dart';

class AddNewUnitPhotosScreen extends StatefulWidget {
  const AddNewUnitPhotosScreen({super.key, this.isUpdate = false});
  final bool isUpdate;
  
  @override
  State<AddNewUnitPhotosScreen> createState() => _AddNewUnitPhotosScreenState();
}

class _AddNewUnitPhotosScreenState extends State<AddNewUnitPhotosScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body:SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Image.asset(
                  ImageManager.logoHalfGrey,
                  height: size.height / 2.5,
                ),
              ),
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            top: MediaQuery.of(context).viewPadding.top,
                          ),
                          child: Container(
                            // color: Colors.red,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () {
                                      context.pop();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.chevronLeft,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(cubit.unitBody.subCategoryId == 8?"صور الطباخ":
                                  "صور العقار / الكشتة",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: FontSize.s34, color: Colors.black,fontWeight: FontWeightManager.bold),
                                ),
                                SizedBox(
                                  height: AppSize.h10,
                                ),
                                Text(
                                  "إضافة صور العرض",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: AppSize.sp20, color: Colors.black,fontWeight: FontWeightManager.bold),
                                ),
                                SizedBox(
                                  height: AppSize.h15,
                                ),
                                ContainerDecorated(content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(cubit.unitBody.subCategoryId == 8?

                                    'حتى تعرض مهارات الطباخ بنجاح اضف مالا يقل عن 6 صور واضحة وجذابة لأعمال الطباخ يمنع وضع شعار او كلمات على الصورة'
                                    :
                                      'حتى تعرض الكشتة / العقار بنجاح اضف مالا يقل عن 6 صور واضحة وجذابة للكشتة يمنع وضع شعار او كلمات على الصورة',
                                      style: TextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.mainlyBlueColor
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      'صورة العرض الرئيسية',
                                      style: TextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorManager.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0, 0), // changes position of shadow
                                          ),

                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                                        child: Column(
                                          children:  [
                                            InkWell(
                                              onTap: ()async{
                                                final pics = await cubit.pickImage(ImagePickerType.singleImage);
                                                cubit.updateNewUnitMainPhotos(pics.first);
                                              },
                                              child: BlocConsumer<AppBloc, AppState>(
                                                listener: (context, state) {
                                                  // TODO: implement listener
                                                },
                                                builder: (context, state) {
                                                  return Column(
                                                    children: [
                                                      if(cubit.mainPic != null)
                                                        Image.file(
                                                          File(cubit.mainPic!.path), // You can access it with . operator and path property
                                                          fit: BoxFit.cover,
                                                          width: 100,
                                                          height: 100,
                                                        ),

                                                      if(cubit.mainPic == null)
                                                        Icon(Icons.camera_alt,size: 80,color: ColorManager.darkGreyColor,),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Text(
                                              'اضف صورة العرض',
                                              style: TextStyle(
                                                fontSize: FontSize.s16,
                                                fontWeight: FontWeightManager.bold,
                                                color: ColorManager.darkGreyColor,
                                              ),
                                            ),
                                          ],

                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    Text(cubit.unitBody.subCategoryId == 8?
                                        'صور لاعمال الطباخ'
                                        :
                                      'صور الكشتة / العقار',
                                      style: TextStyle(
                                        fontSize: FontSize.s16,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'مطلوب 6 صور',
                                      style: TextStyle(
                                        fontSize: FontSize.s16,
                                        // fontWeight: FontWeightManager.bold,
                                        color: ColorManager.blackColor.withOpacity(0.5),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorManager.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0, 0), // changes position of shadow
                                          ),

                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: ()async{
                                                final pics = await cubit.pickImage(ImagePickerType.multiImages);
                                                cubit.updateNewUnitPhotos(pics);
                                              },
                                              child: BlocConsumer<AppBloc, AppState>(
                                                listener: (context, state) {
                                                  // TODO: implement listener
                                                },
                                                builder: (context, state) {
                                                  return Column(
                                                    children: [
                                                      if(cubit.otherPics.isNotEmpty)
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: Wrap(
                                                            alignment: WrapAlignment.center,
                                                            children: [
                                                              for(int i = 0; i<cubit.otherPics.length; i++)
                                                                Padding(
                                                                  padding: const EdgeInsets.all(5.0),
                                                                  child: Image.file(
                                                                    File(cubit.otherPics[i].path), // You can access it with . operator and path property
                                                                    fit: BoxFit.cover,
                                                                    width: 70,
                                                                    height: 70,
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),

                                                      if(cubit.otherPics.isEmpty)
                                                        Icon(Icons.camera_alt,size: 80,color: ColorManager.darkGreyColor,),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Text(
                                              'اضف صور العرض',
                                              style: TextStyle(
                                                fontSize: FontSize.s16,
                                                fontWeight: FontWeightManager.bold,
                                                color: ColorManager.darkGreyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BlocConsumer<AppBloc, AppState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return KButton(
                        isLoading: state is UpdateUnitLoadingState,
                        onTap: () async{
                          if((cubit.unitBody.pics!.isEmpty || cubit.unitBody.mainPic ==null)){

                            const snackBar = SnackBar(
                              content: Center(child: Text('من فضلك اختر الصور',textAlign: TextAlign.center,)),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                          }
                          
                          if(widget.isUpdate){
                            await cubit.updateUnitPhotos(unitId: cubit.selectedUnit.id??-1);
                            Navigator.pop(context);
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PricingScreen()));
                          }
                          
                        },
                        title:  widget.isUpdate?'تحديث':'التالي',
                        width: size.width,
                        paddingV: 18,
                      );
  },
),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
