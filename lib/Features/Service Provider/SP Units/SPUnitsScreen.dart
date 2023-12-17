import 'dart:developer';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/models/CategoryModel.dart';
import 'package:kashtat/Features/Service%20Provider/Add%20New%20Unit/AddNewUnitScreen.dart';
import 'package:kashtat/Features/Service%20Provider/SP%20Unit%20Details/SPUnitDetailsScreen.dart';
import 'package:kashtat/Features/Vat/VatScreen.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';

import '../../../Core/Cubit/AppCubit.dart';
import '../../../Core/Cubit/AppState.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/ImageManager.dart';
import '../../Add Name And DescriptionScreen/screen_51.dart';
import '../../Widgets/Loader.dart';

class SPUnitsScreen extends StatefulWidget {
  const SPUnitsScreen({Key? key}) : super(key: key);

  @override
  State<SPUnitsScreen> createState() => _SPUnitsScreenState();
}

class _SPUnitsScreenState extends State<SPUnitsScreen> {
  @override
  void initState() {
    final cubit = BlocProvider.of<AppBloc>(context);
    cubit.getAllProviderUnits();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        title: Text('الوحدات'),
        backgroundColor: ColorManager.mainlyBlueColor,
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<AppBloc>(context);
          return state is ProviderCategoriesWithUnitsLoadingState? const Center(child: Loader(),):ExpandableBottomSheet(
        persistentContentHeight: 85,
        background: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: cubit.providerCategoriesWithUnits.length ,
                padding: EdgeInsets.only(bottom: 120),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index){
              return ContainerDecorated(
                  content: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text('التصنيف',style: TextStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.mainlyBlueColor,
                              fontWeight: FontWeightManager.medium,
                            ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ImageManager.cat3,color: ColorManager.mainlyBlueColor,width: 24,),
                          SizedBox(width: 5,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(cubit.providerCategoriesWithUnits[index].name,style: TextStyle(
                              fontSize: FontSize.s18,
                              color: ColorManager.mainlyBlueColor,
                              fontWeight: FontWeightManager.bold,
                            ),),
                          ),
                          const Spacer(),
                          InkWell(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>VatScreen(category:cubit.getCategoryById(cubit.providerCategoriesWithUnits[index].categoryId),)));
                          }, child: Text('الرقم الضريبي',style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),))
                          // FaIcon(Icons.edit_location,color: ColorManager.mainlyBlueColor,size: 20,),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: Text('الرياض',style: TextStyle(
                          //     fontSize: FontSize.s16,
                          //     fontWeight: FontWeightManager.medium,
                          //   ),),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ListView.builder(
                        itemCount: cubit.providerCategoriesWithUnits[index].units.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,innerIndex){
                          return innerIndex == 0 ? InkWell(
                            onTap: (){
                              log(cubit.providerCategoriesWithUnits[index].units[innerIndex].toJson().toString());
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SPUnitDetailsScreen()));
                              cubit.setSelectedUnit(cubit.providerCategoriesWithUnits[index].units[innerIndex].copyWith(
                                category: CategoryModel(id: cubit.providerCategoriesWithUnits[index].categoryId,name: cubit.providerCategoriesWithUnits[index].name)
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.withOpacity(0.2),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(cubit.providerCategoriesWithUnits[index].units[innerIndex].name??'',
                                                  style: TextStyle(
                                                    fontSize: FontSize.s22,
                                                    color: ColorManager.mainlyBlueColor,
                                                    fontWeight: FontWeightManager.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                child: Image.asset(ImageManager.marker,width: 18,color: ColorManager.mainlyBlueColor),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5.0),
                                                child: Text(cubit.providerCategoriesWithUnits[index].units[innerIndex].city?.name??'الرياض',style: TextStyle(
                                                  fontSize: FontSize.s18,
                                                  fontWeight: FontWeightManager.bold,
                                                  color: ColorManager.mainlyBlueColor,
                                                ),),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              FaIcon(cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?FontAwesomeIcons.solidEye:FontAwesomeIcons.solidEyeSlash,
                                                color: cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?ColorManager.mintGreenColor:ColorManager.redColor,
                                                size: 15,),
                                              SizedBox(width: 5),
                                              Text(cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?'معروض':'غير معروض',
                                                style: TextStyle(
                                                  fontSize: FontSize.s16,
                                                  fontWeight: FontWeight.bold,
                                                  color: cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?ColorManager.mintGreenColor:ColorManager.redColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                            Text('${cubit.providerCategoriesWithUnits[index].units[innerIndex].city?.name??'الرياض'} - ${cubit.providerCategoriesWithUnits[index].units[innerIndex].state?.name??'اشبيلية'}',
                                                style: TextStyle(
                                                  fontSize: FontSize.s16,
                                                  fontWeight: FontWeightManager.bold,
                                                ),
                                              ),
                                              SizedBox(width: 30,),
                                              Text('عدد الوحدات ${cubit.providerCategoriesWithUnits[index].units.length}',
                                                style: TextStyle(
                                                  fontSize: FontSize.s18,
                                                  fontWeight: FontWeightManager.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          KButton(onTap: (){
                                            log(cubit.providerCategoriesWithUnits[index].units[innerIndex].toJson().toString());
                                            cubit.setSelectedUnit(cubit.providerCategoriesWithUnits[index].units[innerIndex].copyWith(
                                                category: CategoryModel(id: cubit.providerCategoriesWithUnits[index].categoryId,name: cubit.providerCategoriesWithUnits[index].name)
                                            ));
                                            cubit.updateNewUnitCategoryAndTitle(catId: cubit.providerCategoriesWithUnits[index].categoryId, subCatId: cubit.selectedUnit.subCategory!.id);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNameAndDescriptionScreen(serviceName: cubit.getCategoryServiceName(cubit.selectedUnit.category?.id??-1, cubit.selectedUnit.subCategory!.id),)));
                                          }, title: 'إضافة وحدة تابعة للتصنيف الحالي',width: MediaQuery.of(context).size.width,paddingV: 15,),

                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text('ملاحظة: إضافة وحدة بنفس اللوكيشن',
                                              style: TextStyle(
                                                fontSize: FontSize.s14,
                                                color: ColorManager.darkerGreyColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    FaIcon(FontAwesomeIcons.chevronLeft,color: ColorManager.orangeColor,size: 16,)
                                  ],
                                ),
                              ),
                        ),
                            ),
                          ):Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: InkWell(
                              onTap: (){
                                log(cubit.providerCategoriesWithUnits[index].units[innerIndex].toJson().toString());
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SPUnitDetailsScreen()));
                                cubit.setSelectedUnit(cubit.providerCategoriesWithUnits[index].units[innerIndex].copyWith(
                                    category: CategoryModel(id: cubit.providerCategoriesWithUnits[index].categoryId,name: cubit.providerCategoriesWithUnits[index].name)
                                ));
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(cubit.providerCategoriesWithUnits[index].units[innerIndex].name??'',
                                                    style: TextStyle(
                                                      fontSize: FontSize.s22,
                                                      // color: ColorManager.mainlyBlueColor,
                                                      fontWeight: FontWeightManager.bold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                  child: Image.asset(ImageManager.marker,width: 18,color: ColorManager.blackColor),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(cubit.providerCategoriesWithUnits[index].units[innerIndex].city?.name??'الرياض',style: TextStyle(
                                                    fontSize: FontSize.s18,
                                                    fontWeight: FontWeightManager.bold,
                                                    // color: ColorManager.mainlyBlueColor,
                                                  ),),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                FaIcon(cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?FontAwesomeIcons.solidEye:FontAwesomeIcons.solidEyeSlash,
                                                  color: cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?ColorManager.mintGreenColor:ColorManager.redColor,
                                                  size: 15,),
                                                const SizedBox(width: 5),
                                                Text(cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?'معروض':'غير معروض',
                                                  style: TextStyle(
                                                    fontSize: FontSize.s16,
                                                    fontWeight: FontWeight.bold,
                                                    color: cubit.providerCategoriesWithUnits[index].units[innerIndex].isActive!?ColorManager.mintGreenColor:ColorManager.redColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 30),
                                                Text('كود الوحدة ${cubit.providerCategoriesWithUnits[index].units[innerIndex].id}',
                                                  style: TextStyle(
                                                    fontSize: FontSize.s18,
                                                    fontWeight: FontWeightManager.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      FaIcon(FontAwesomeIcons.chevronLeft,color: ColorManager.orangeColor,size: 16,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ));
            }),
          ),
        ),
        persistentHeader: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
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
        expandableContent: Container(
          // height: 500,
          color: ColorManager.whiteColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30.0,bottom: 20.0,left: 30.0,),
                child: SizedBox(
                    width: size.width,
                    child: KButton(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewUnitScreen()));
                    }, title: 'اضافة تصنيف / لوكيشن جديد',paddingV: 20,)),
              ),
            ],
          ),
        ),
      );
  },
),
    );
  }
}
