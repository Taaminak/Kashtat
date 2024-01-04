import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';
import '../../../Core/Cubit/AppCubit.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/FontManager.dart';
import '../../../Core/constants/ImageManager.dart';
import '../../../Core/constants/app_size.dart';
import '../../../Core/constants/style_manager.dart';
import '../../../Features/Widgets/custom_container.dart';
import '../../../Features/Widgets/kButton.dart';
import '../Add Address Screen/AddAddressScreen.dart';

class AddNameAndDescriptionScreen extends StatefulWidget {
  const AddNameAndDescriptionScreen({super.key, required this.serviceName, this.isUpdate = false});
  final String serviceName;
  final bool isUpdate;


  @override
  State<AddNameAndDescriptionScreen> createState() => _AddNameAndDescriptionScreenState();
}

class _AddNameAndDescriptionScreenState extends State<AddNameAndDescriptionScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllerName = TextEditingController();

  @override
  void initState() {
    if(widget.isUpdate){
      setState(() {
        final cubit = BlocProvider.of<AppBloc>(context);
        controllerName.text = cubit.selectedUnit.name??'';
        controller.text = cubit.selectedUnit.description??'';
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      backgroundColor: ColorManager.grey3,
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
                                height: AppSize.h20,
                              ),
                              // const Divider(
                              //   height: 50,
                              //   thickness: 2,
                              // ),
                              Text(
                                'اسم ${widget.serviceName} ( اسم الخدمة )',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: const Offset(0,
                                          0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        controller: controllerName,
                                        decoration: InputDecoration(
                                          hintText: 'الاسم',
                                          hintStyle: TextStyle(
                                              color: Color(0xffA6A6A6)),
                                          border: InputBorder.none,
                                        ),
                                        cursorColor:Color(0xff482383),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: AppSize.h20,
                              ),
                              Text(
                                cubit.unitBody.subCategoryId == 8? "وصف الطباخ ":
                                "وصف العقار / الكشتة ",
                                textAlign: TextAlign.right,
                                style: StyleManager.getBoldStyle(
                                    fontSize: AppSize.sp30, color: ColorManager.black),
                              ),
                              SizedBox(
                                height: AppSize.h10,
                              ),
                              Text(cubit.unitBody.subCategoryId == 8?" اكتب وصف مميز للخدمة المقدمة ":
                                " اكتب وصف مميز للكشتة / للعقار ",
                                textAlign: TextAlign.right,
                                style: StyleManager.getBoldStyle(
                                    fontSize: AppSize.sp20, color: ColorManager.black),
                              ),
                              SizedBox(
                                height: AppSize.h15,
                              ),
                              CustomConatiner(
                                  height: AppSize.h420,
                                  width: context.width,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                                        .r,
                                    child: Column(
                                      children: [
                                        Container(
                                          // height: AppSize.h250,
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorManager.grey, width: 1.r),
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: TextFormField(
                                              controller: controller,
                                              maxLines: 15,
                                              onTapOutside: (event){
                                                FocusManager.instance.primaryFocus?.unfocus();
                                              },
                                              decoration: const InputDecoration(
                                                hintText: "اكتب رسالتك هنا",
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                      final cubit = BlocProvider.of<AppBloc>(context);
                      if(state is UpdateUnitNameAndDescSuccessState){
                        cubit.setSelectedUnit(cubit.selectedUnit.copyWith(
                          name: controllerName.text,
                          description: controller.text,
                        ));
                      }
                    },
                    builder: (context, state) {
                      return KButton(
                      onTap: () async{
                        final cubit = BlocProvider.of<AppBloc>(context);
                        if(controller.text.isEmpty&&controllerName.text.isEmpty){

                          const snackBar = SnackBar(
                            content: Center(child: Text('من فضلك ادخل الوصف والاسم',textAlign: TextAlign.center,)),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        cubit.updateNewUnitDescription(desc: controller.text,name: controllerName.text);
                        if(widget.isUpdate){
                          await cubit.updateUnitNameAndDetails(unitId: cubit.selectedUnit.id??-1).then((value) => Navigator.pop(context));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressScreen()));
                        }

                      },
                      title: widget.isUpdate?'تحديث':'التالي',
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
