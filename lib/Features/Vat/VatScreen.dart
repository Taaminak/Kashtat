import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/models/CategoryModel.dart';
import 'package:kashtat/Core/models/ProviderCategorysWithUnits.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Features/Request%20Details/Widgets/ShowModelBottomSheet.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/DropDownMenuWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../Widgets/ItemScreenTitle.dart';

class VatScreen extends StatefulWidget {
  const VatScreen({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;

  @override
  State<VatScreen> createState() => _VatScreenState();
}

class _VatScreenState extends State<VatScreen> {
  TextEditingController controller = TextEditingController();
  int selectedOption = 0;
  @override
  void initState() {
    setState(() {
      controller.text = widget.category.tin ?? '';
      selectedOption = widget.category.isApplicableForVat! ? 1 : 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text(
          LocaleKeys.vat_title.tr(),
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
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
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              if (controller.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    LocaleKeys.tax_number.tr(),
                    style: TextStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.bold,
                    ),
                  ),
              ),
              SizedBox(
                height: 10,
              ),
              if (controller.text.isNotEmpty)
                ContainerDecorated(
                  content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.text,
                          style: TextStyle(
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.bold,
                          ),
                        ),
                    ),
                  ],
                  ),
                  addPadding: false,
                ),
              if (controller.text.isNotEmpty)
                SizedBox(
                  height: 10,
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: KButton(
                  onTap: () {
                    customBottomSheet(
                        context,
                        '',
                        SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                            child: StatefulBuilder(
                                builder: (context, innerSetState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    LocaleKeys.are_you_vat_applicable.tr(),
                                    style: TextStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                              ListTile(
                                    title: Text(
                                      LocaleKeys.exempt_from_vat.tr(),
                                      style: TextStyle(
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                leading: Radio(
                                  value: 0,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    innerSetState(() {
                                      selectedOption = value!;
                                    });
                                  },
                                  activeColor: ColorManager.mainlyBlueColor,
                                ),
                              ),
                              ListTile(
                                    title: Text(
                                      LocaleKeys.subject_to_vat.tr(),
                                      style: TextStyle(
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                leading: Radio(
                                  value: 1,
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    innerSetState(() {
                                      selectedOption = value!;
                                    });
                                  },
                                  activeColor: ColorManager.mainlyBlueColor,
                                ),
                              ),
                                  if (selectedOption == 1)
                                    SizedBox(
                                      height: 20,
                                    ),
                                  if (selectedOption == 1)
                                    Text(
                                      LocaleKeys.tax_number.tr(),
                                      style: TextStyle(
                                fontSize: FontSize.s20,
                                fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                  if (selectedOption == 1)
                                    SizedBox(
                                      height: 10,
                                    ),
                                  if (selectedOption == 1)
                              Card(
                                elevation: 5,
                                child: TextField(
                                  controller: controller,
                                        inputFormatters: [
                                    // LengthLimitingTextInputFormatter(10),
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                            fontSize: FontSize.s14),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.grey[500]),
                                    fillColor: Colors.white70,
                                          hintText: LocaleKeys.tax_number.tr(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                  ),
                                ),
                              ),
                              Padding(
                                    padding: const EdgeInsets.only(
                                        right: 33.0, left: 15, top: 20),
                                    child: Text(
                                      LocaleKeys.vat_verification_note.tr(),
                                      style: TextStyle(
                                  fontSize: FontSize.s16,
                                  fontWeight: FontWeightManager.bold,
                                          color: ColorManager.mainlyBlueColor),
                                    ),
                              ),
                              Spacer(),
                              BlocConsumer<AppBloc, AppState>(
                                listener: (context, state) {
                                      if (state is UpdateCategorySuccessState) {
                                      Navigator.pop(context);
                                        if (selectedOption != 1) {
                                        setState(() {
                                          controller.clear();
                                        });
                                      }
                                    Fluttertoast.showToast(
                                            msg: LocaleKeys.tax_number_updated
                                                .tr(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                            fontSize: 16.0);
                                  }
                                },
                                builder: (context, state) {
                                      return KButton(
                                        onTap: () {
                                          Map<String, dynamic> body = {
                                            "is_applicable_for_vat":
                                                selectedOption,
                                            "_method": "PUT",
                                            "vat": "15",
                                            "tin": selectedOption == 1
                                                ? controller.text
                                                : ''
                                    };
                                          cubit.updateCategory(
                                              categoryId:
                                                  widget.category.id ?? -1,
                                              body: body);
                                        },
                                        title: LocaleKeys.save.tr(),
                                        width: size.width,
                                        paddingV: 15,
                                        isLoading:
                                            state is UpdateCategoryLoadingState,
                                      );
                                },
                              ),
                            ],
                          );
                            }),
                    ),
                        ),
                        true,
                        size.height - 200);
                  },
                  title: controller.text.isEmpty
                      ? LocaleKeys.add_tax_number.tr()
                      : LocaleKeys.edit_tax_number.tr(),
                  width: size.width,
                  paddingV: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration _decoration = BoxDecoration(
  color: ColorManager.whiteColor,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 7,
      offset: Offset(0, 0), // changes position of shadow
    ),
  ],
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    color: Colors.grey.withOpacity(0.2),
    width: 1,
  ),
);
