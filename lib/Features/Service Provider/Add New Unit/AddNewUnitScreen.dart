import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/Loader.dart';

import '../../../Core/Cubit/AppCubit.dart';
import '../../Add Name And DescriptionScreen/screen_51.dart';
import '../../Widgets/kButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddNewUnitScreen extends StatefulWidget {
  const AddNewUnitScreen({Key? key, this.isUpdate = false}) : super(key: key);
  final bool isUpdate;

  @override
  State<AddNewUnitScreen> createState() => _AddNewUnitScreenState();
}

class _AddNewUnitScreenState extends State<AddNewUnitScreen> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: SizedBox(
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
                          top: MediaQuery.of(context).viewPadding.top + 15,
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
                              Text(
                                'التسجيل',
                                style: TextStyle(
                                  fontSize: FontSize.s34,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'معلومات الكشتة - الخدمة',
                                style: TextStyle(
                                  fontSize: FontSize.s20,
                                  fontWeight: FontWeightManager.bold,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ContainerDecorated(
                                  content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'حدد التصنيف المناسب',
                                        style: TextStyle(
                                          fontSize: FontSize.s16,
                                          fontWeight: FontWeightManager.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 15,
                                                crossAxisSpacing: 15),
                                        itemCount:
                                            cubit.allCreateUnitCategory.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) => InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selected = i;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: ColorManager
                                                            .mainlyBlueColor,
                                                        width: 2),
                                                    color: selected != i
                                                        ? Colors.white
                                                        : ColorManager
                                                            .mainlyBlueColor,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: cubit.allCreateUnitCategory[i].img,
                                                        height: 30,
                                                        width: 30,
                                                        fit: BoxFit.contain,
                                                        color: selected == i ? Colors.white : ColorManager.mainlyBlueColor,
                                                        placeholder: (context, url) => const Loader(),
                                                        errorWidget: (context, url, error) => Icon(
                                                          Icons.image_not_supported_outlined,
                                                          color: selected == i ? Colors.white : ColorManager.greyColor,
                                                        ),
                                                      ),
                                                      // Image.asset(icons[0],height: 30,color: selected ==i? Colors.white:ColorManager.mainlyBlueColor,),
                                                      Text(
                                                        cubit
                                                            .allCreateUnitCategory[
                                                                i]
                                                            .name,
                                                        style: TextStyle(
                                                          fontSize:
                                                              FontSize.s12,
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .bold,
                                                          color: selected == i
                                                              ? Colors.white
                                                              : ColorManager
                                                                  .mainlyBlueColor,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                ],
                              )),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: KButton(
                      onTap: () async{
                        if (/*_controller.text.isEmpty || */selected == -1) {
                          final snackBar = SnackBar(
                            content: Center(
                                child: Text(
                              'ادخل اسم الكشتة',
                              textAlign: TextAlign.center,
                            )),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }

                        final cubit = BlocProvider.of<AppBloc>(context);
                        cubit.updateNewUnitCategoryAndTitle(
                          catId: cubit.allCreateUnitCategory[selected].categoryId,
                          subCatId: cubit.allCreateUnitCategory[selected].subCategoryId??-1,
                        );

                        if(widget.isUpdate){
                          await cubit.updateUnitCategories(unitId: cubit.selectedUnit.id??-1);
                          Navigator.pop(context);
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddNameAndDescriptionScreen(serviceName: cubit.allCreateUnitCategory[selected].serviceText,)));
                        }

                      },
                      title: widget.isUpdate?'تحديث':'التالي',
                      width: size.width,
                      paddingV: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
