import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Features/Widgets/ScreenTemplateWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/FontManager.dart';
import '../../../../Core/constants/ImageManager.dart';
import '../../../../Core/constants/app_size.dart';
import '../../../../Core/constants/style_manager.dart';
import '../../../../Core/models/UnitModel.dart';
import '../../../../Features/Request Details/Widgets/ShowModelBottomSheet.dart';
import '../widget/codes_container.dart';
import '../widget/copon_button.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  bool isContinue = false;
  UnitModel? _selectedUnit;

  TextEditingController codeController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController usageController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    final cubit = BlocProvider.of<AppBloc>(context);
    cubit.getAllCoupons();
    cubit.getAllProviderUnitsInOneLevel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      backgroundColor: ColorManager.grey3,
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SizedBox(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).viewPadding.top + 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  ImageManager.backIcon,
                                  width: 10,
                                ),
                              )),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          ImageManager.logoWithTitleHColored,
                          width: 150,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                // left: 15.0,
                                // right: 15.0,
                                top: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.discount_codes.tr(),
                                    style: TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.h10,
                                  ),
                                  Text(
                                    LocaleKeys.share_with_guests.tr(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeightManager.medium,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppSize.h10,
                                  ),
                                  BuildCoponButton(
                                    onTap: () {
                                      showModel(context);
                                    },
                                  ),
                                  SizedBox(
                                    height: AppSize.h20,
                                  ),
                                  Text(
                                    LocaleKeys.created_discount_codes.tr(),
                                    style: StyleManager.getBoldStyle(
                                        fontSize: AppSize.sp25,
                                        color: ColorManager.black),
                                  ),
                                  SizedBox(
                                    height: AppSize.h10,
                                  ),
                                  Text(
                                    LocaleKeys.tap_to_copy.tr(),
                                    textAlign: TextAlign.right,
                                    style: StyleManager.getBoldStyle(
                                        fontSize: AppSize.sp16,
                                        color: ColorManager.black),
                                  ),
                                  SizedBox(
                                    height: AppSize.h10,
                                  ),
                                  ListView.builder(
                                      itemCount: cubit.allCoupons.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CodesContainer(
                                              coupon: cubit.allCoupons[index],
                                            ),
                                            SizedBox(
                                              height: AppSize.h15,
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  showModel(BuildContext context) {
    setState(() {
      isContinue = false;
      _selectedUnit = null;
      codeController.clear();
      dateController.clear();
      percentageController.clear();
      usageController.clear();
      expireDate = DateTime.now();
    });

    customBottomSheet(context, '',
        StatefulBuilder(builder: (context, innerSetState) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          if (!isContinue)
            Expanded(child: _buildSelectUnitWidget(context, innerSetState)),
          if (isContinue) Expanded(child: _buildCreateCouponWidget(context)),
        ],
      );
    }), true, 600);
  }

  _buildSelectUnitWidget(BuildContext context, Function innerSetState) =>
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              LocaleKeys.select_kashta_or_units.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeightManager.medium,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 45,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.0)),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: 10,
                      ),
                      isDense: true,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      hintText: LocaleKeys.select_kashta.tr(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.grey.shade300,
                            style: BorderStyle.solid,
                          )),
                    ),
                    isEmpty: _selectedUnit == null,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<UnitModel>(
                        value: _selectedUnit,
                        isDense: true,
                        onChanged: (newValue) {
                          innerSetState(() {
                            _selectedUnit = newValue;
                            state.didChange(newValue?.name);
                          });
                        },
                        iconEnabledColor: ColorManager.orangeColor,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 25,
                        ),
                        items: (BlocProvider.of<AppBloc>(context)
                                    .allProviderUnits
                                    .isEmpty
                                ? [UnitModel()]
                                : BlocProvider.of<AppBloc>(context)
                                    .allProviderUnits)
                            .map((UnitModel? value) {
                          return DropdownMenuItem<UnitModel>(
                            value: value ?? UnitModel(),
                            child: Text(value?.name ?? ''),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            KButton(
              onTap: () {
                if (_selectedUnit == null) {
                  return;
                }
                innerSetState(() {
                  isContinue = true;
                });
              },
              title: 'التالي',
              width: MediaQuery.of(context).size.width,
              paddingV: 20,
            ),
            // SizedBox(height: 15,),
          ],
        ),
      );

  _buildCreateCouponWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const Text(
              "اكتب اسم كود الخصم",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffDDDDDD), width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: codeController,
                    style: TextStyle(
                        fontWeight: FontWeightManager.bold, fontSize: 14),
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 14),
                        fillColor: Colors.white30,
                        hintText: 'مثال : كشتات'),
                  ),
                ),
              ),
            ),

            Text(
              "حدد نسبة كود الخصم",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffDDDDDD), width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: percentageController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontWeight: FontWeightManager.bold, fontSize: 14),
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 14),
                              fillColor: Colors.white30,
                              hintText: '10 %'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "نسبة مئوية",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "حدد تاريخ انتهاء صلاحية كود الخصم",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffDDDDDD), width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    style: TextStyle(
                        fontWeight: FontWeightManager.bold, fontSize: 14),
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 14),
                        fillColor: Colors.white30,
                        hintText: '1/1/2024'),
                  ),
                ),
              ),
            ),
            Text(
              "حدد عدد مرات استخدام كود الخصم",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffDDDDDD), width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: usageController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontWeight: FontWeightManager.bold, fontSize: 14),
                    decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 14),
                        fillColor: Colors.white30,
                        hintText: '7'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            BlocConsumer<AppBloc, AppState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return KButton(
                  onTap: () async {
                    // print(_selectedUnit!.id);
                    //
                    // return;
                    bool isValid = codeController.text.isNotEmpty &&
                        percentageController.text.isNotEmpty &&
                        usageController.text.isNotEmpty &&
                        dateController.text.isNotEmpty;
                    if (!isValid) {
                      return;
                    }

                    print({
                      "code": codeController.text,
                      "expires_at": dateController.text,
                      "discount": percentageController.text,
                      "[]units_ids": [_selectedUnit!.id],
                      "usage_limit": usageController.text,
                    });
                    final formData = FormData.fromMap({
                      "code": codeController.text,
                      "expires_at": dateController.text,
                      "discount": double.parse(percentageController.text) / 100,
                      "units_ids[0]": _selectedUnit!.id,
                      "usage_limit": usageController.text,
                    });

                    await BlocProvider.of<AppBloc>(context)
                        .createCoupon(body: formData)
                        .then((value) {
                      if (value) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "تم اضافة كود الخصم بنجاح",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: "لم يتم انشاء كود الخصم",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  title: 'أنشئ كود الخصم',
                  width: MediaQuery.of(context).size.width,
                  paddingV: 20,
                  isLoading: state is CreateCouponLoadingState,
                );
              },
            ),
            // SizedBox(height: 15,),
          ],
        ),
      );

  DateTime expireDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final cubit = BlocProvider.of<AppBloc>(context);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: expireDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != expireDate) {
      setState(() {
        dateController.text = DateFormat("yyyy-MM-dd 00:00").format(expireDate);
        expireDate = picked;
      });
    }
  }
}
