import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';
import 'package:kashtat/Core/models/StateModel.dart';
import 'package:kashtat/Features/Map%20Screen/MapScreen.dart';
import '../../../Core/Cubit/AppState.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/ImageManager.dart';
import '../../../Core/constants/app_size.dart';
import '../../../Core/constants/style_manager.dart';
import '../../../Core/models/CityModel.dart';
import '../../../Features/Widgets/image_widget.dart';
import '../../../Features/Widgets/kButton.dart';
import '../Add New Unit Photos Screen/AddNewUnitPhotosScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../translations/locale_keys.g.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key, this.isUpdate = false});
  final bool isUpdate;

  @override
  State<AddAddressScreen> createState() => _Screen63State();
}

class _Screen63State extends State<AddAddressScreen> {
  TextEditingController cityController = TextEditingController();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AddAddressWidget(isUpdate: widget.isUpdate);
  }
}

class AddAddressWidget extends StatefulWidget {
  const AddAddressWidget({super.key, required this.isUpdate});
  final bool isUpdate;

  @override
  State<AddAddressWidget> createState() => _AddAddressWidgetState();
}

class _AddAddressWidgetState extends State<AddAddressWidget> {
  TextEditingController cityController = TextEditingController();
  TextEditingController controller = TextEditingController();
  int count = 5;
  City? selectedCity;
  StateModel? selectedState;
  @override
  void initState() {
    setState(() {
      if (BlocProvider.of<AppBloc>(context).allCities.isNotEmpty) {
        selectedCity = BlocProvider.of<AppBloc>(context).allCities.first;
      }
      if (selectedCity != null) {
        if (selectedCity!.states.isNotEmpty) {
          selectedState = selectedCity!.states.first;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      backgroundColor: ColorManager.grey3,
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
                          top: MediaQuery.of(context).viewPadding.top,
                        ),
                        child: Container(
                          // color: Colors.red,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60,
                              ),

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
                              Text(
                                LocaleKeys.address.tr(),
                                textAlign: TextAlign.right,
                                style: StyleManager.getBoldStyle(
                                    fontSize: AppSize.sp30,
                                    color: ColorManager.black),
                              ),
                              SizedBox(
                                height: AppSize.h10,
                              ),
                              Text(
                                LocaleKeys.add_your_address.tr(),
                                textAlign: TextAlign.right,
                                style: StyleManager.getBoldStyle(
                                    fontSize: AppSize.sp20,
                                    color: ColorManager.black),
                              ),
                              SizedBox(
                                height: AppSize.h10,
                              ),
                              Text(
                                LocaleKeys.city.tr(),
                                textAlign: TextAlign.right,
                                style: StyleManager.getBoldStyle(
                                    fontSize: AppSize.sp16,
                                    color: ColorManager.black),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1),
                                ),
                                child: (cubit.allCities.isEmpty ||
                                        selectedCity == null)
                                    ? SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child:
                                              Text(LocaleKeys.no_cities.tr()),
                                        ))
                                    : DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              value: selectedCity!.name,
                                              isExpanded: true,
                                              iconDisabledColor:
                                                  ColorManager.orangeColor,
                                              iconEnabledColor:
                                                  ColorManager.orangeColor,
                                              items: cubit.allCities.map<
                                                      DropdownMenuItem<String>>(
                                                  (value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.name,
                                                  child: Text(
                                                    value.name,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                City selected = cubit.allCities
                                                    .firstWhere((element) =>
                                                        element.name ==
                                                        newValue);
                                                setState(() {
                                                  selectedCity = selected;
                                                  selectedState = selectedCity!
                                                      .states.first;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                              ),

                              // CustomTxtFlied(
                              //   hintText: 'اسم المدينة',
                              //   controller: widget.cityController,
                              // ),
                              SizedBox(
                                height: AppSize.h10,
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 1),
                                ),
                                child: (selectedCity!.states.isEmpty ||
                                        selectedCity == null)
                                    ? SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                              LocaleKeys.no_districts.tr()),
                                        ))
                                    : DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              value: selectedState!.name,
                                              isExpanded: true,
                                              iconDisabledColor:
                                                  ColorManager.orangeColor,
                                              iconEnabledColor:
                                                  ColorManager.orangeColor,
                                              items: selectedCity!.states.map<
                                                      DropdownMenuItem<String>>(
                                                  (value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.name,
                                                  child: Text(
                                                    value.name,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                StateModel selected =
                                                    selectedCity!.states
                                                        .firstWhere((element) =>
                                                            element.name ==
                                                            newValue);
                                                setState(() {
                                                  selectedState = selected;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                              ),

                              // CustomTxtFlied(
                              //   hintText: 'اسم الحى',
                              //   controller: widget.controller,
                              // ),

                              if (!widget.isUpdate &&
                                  cubit.unitBody.subCategoryId != 8)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: AppSize.h15,
                                    ),
                                    Text(
                                      LocaleKeys.select_location_on_map.tr(),
                                      textAlign: TextAlign.right,
                                      style: StyleManager.getBoldStyle(
                                          fontSize: AppSize.sp16,
                                          color: ColorManager.black),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MapScreen()));
                                      },
                                      child: AssetImageWidget(
                                        imgPath: ImageManager.location,
                                        width: context.width,
                                        height: 138.h,
                                      ),
                                    ),
                                    SizedBox(
                                      height: AppSize.h15,
                                    ),
                                    Text(
                                      LocaleKeys.how_many_people.tr(),
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.visible,
                                      style: StyleManager.getBoldStyle(
                                          fontSize: AppSize.sp14,
                                          color: ColorManager.black),
                                    ),
                                    SizedBox(
                                      height: AppSize.h10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (count < 10) {
                                                setState(() {
                                                  count += 1;
                                                });
                                              }
                                            },
                                            child: const Icon(Icons.add,
                                                size: 25,
                                                color: ColorManager.black)),
                                        Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Container(
                                              // padding: EdgeInsets.symmetric(horizontal: 10.r),
                                              height: 50.h,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorManager.grey,
                                                    width: 0.5.r),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                count.toString(),
                                                textAlign: TextAlign.center,
                                                style:
                                                    StyleManager.getBoldStyle(
                                                        fontSize: AppSize.sp25,
                                                        color:
                                                            ColorManager.black),
                                              )),
                                            )),
                                        InkWell(
                                            onTap: () {
                                              if (count > 1) {
                                                setState(() {
                                                  count -= 1;
                                                });
                                              }
                                            },
                                            child: const Icon(Icons.remove,
                                                size: 25,
                                                color: ColorManager.black)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: AppSize.h10,
                                    ),
                                  ],
                                )
                              // CustomConatiner(
                              //     height: AppSize.h450,
                              //     width: context.width,
                              //     child: Padding(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 15, vertical: 16),
                              //       child: AddAddressWidget(
                              //           cityController: cityController, controller: controller),
                              //     )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BlocConsumer<AppBloc, AppState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return KButton(
                          isLoading: state is UpdateUnitLoadingState,
                          onTap: () async {
                            final cubit = BlocProvider.of<AppBloc>(context);
                            if (selectedState == null || selectedCity == null) {
                              final snackBar = SnackBar(
                                content: Center(
                                    child: Text(
                                  LocaleKeys.please_select_city_and_district
                                      .tr(),
                                  textAlign: TextAlign.center,
                                )),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if ((cubit.unitBody.longitude == null ||
                                    cubit.unitBody.longitude == null) &&
                                !widget.isUpdate &&
                                cubit.unitBody.subCategoryId != 8) {
                              final snackBar = SnackBar(
                                content: Center(
                                    child: Text(
                                  LocaleKeys.please_select_location.tr(),
                                  textAlign: TextAlign.center,
                                )),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }
                            if (cubit.unitBody.subCategoryId == 8) {
                              cubit.updateNewUnitLocation(
                                  latitude: 0.0, longitude: 0.0);
                            }

                            cubit.updateNewUnitStateAndCapacity(
                                stateId: selectedState!.id, capacity: count);
                            if (widget.isUpdate) {
                              await cubit.updateUnitCityAndState(
                                  unitId: cubit.selectedUnit.id ?? -1);
                              Navigator.pop(context);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddNewUnitPhotosScreen()));
                            }
                            // if (_controller.text.isEmpty || selected == -1) {
                            //   final snackBar = SnackBar(
                            //     content: Center(
                            //         child: Text(
                            //           'ادخل اسم الكشتة',
                            //           textAlign: TextAlign.center,
                            //         )),
                            //   );
                            //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            //   return;
                            // }
                            //
                            // final cubit = BlocProvider.of<AppBloc>(context);
                            // cubit.updateNewUnitCategoryAndTitle(
                            //   catId: cubit.allCreateUnitCategory[selected].categoryId,
                            //   subCatId: cubit.allCreateUnitCategory[selected].subCategoryId??-1,
                            //   title: _controller.text,
                            // );
                            //
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const Screen50()));
                          },
                          title: widget.isUpdate
                              ? LocaleKeys.update.tr()
                              : LocaleKeys.next.tr(),
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
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //     ],
  //   );
  // }
}
