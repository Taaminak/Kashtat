import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/models/ProviderCategorysWithUnits.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/DropDownMenuWidget.dart';
import 'package:toggle_list/toggle_list.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../../translations/locale_keys.g.dart';
import '../Request Details/Widgets/RequestDetailsWidget.dart';
import '../Widgets/ItemScreenTitle.dart';

class ReportssScreen extends StatefulWidget {
  const ReportssScreen({Key? key}) : super(key: key);

  @override
  State<ReportssScreen> createState() => _ReportssScreenState();
}

class _ReportssScreenState extends State<ReportssScreen> {
  String dropdownValue = 'الرياض';
  DateTime startDate = DateTime(2022);
  DateTime endDate = DateTime.now();
  ProviderCategoriesWithUnits? selectedCategory;
  UnitModel? selectedUnit;
  List<ProviderCategoriesWithUnits> allCategories = [];
  List<UnitModel> allUnits = [];

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final cubit = BlocProvider.of<AppBloc>(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      if (isStart) {
        setState(() {
          startDate = picked;
        });
        cubit.getFinancialSummary(
            from: DateFormat('yyyy-MM-dd').format(startDate),
            to: DateFormat('yyyy-MM-dd').format(endDate));
      } else {
        setState(() {
          endDate = picked;
        });
        cubit.getFinancialSummary(
            from: DateFormat('yyyy-MM-dd').format(startDate),
            to: DateFormat('yyyy-MM-dd').format(endDate));
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final cubit = BlocProvider.of<AppBloc>(context);
    cubit.getFinancialSummary(
        to: DateFormat('yyyy-MM-dd').format(DateTime.now()));

    setState(() {
      if (cubit.providerCategoriesWithUnits.isNotEmpty) {
        selectedCategory = cubit.providerCategoriesWithUnits.first;
        if (selectedCategory != null && selectedCategory!.units.isNotEmpty) {
          selectedUnit = selectedCategory!.units.first;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text(
          LocaleKeys.invoices.tr(),
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
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                // width: size.width,
                // height: size.height-200,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is FinancialSummaryLoadingState)
                          LinearProgressIndicator(
                              color: ColorManager.mainlyBlueColor,
                              backgroundColor:
                                  ColorManager.mainlyBlueColorLight),
                        SizedBox(
                            height: state is FinancialSummaryLoadingState
                                ? 16
                                : 20),
                        Row(
                          children: [
                            Text(
                              LocaleKeys.select_period.tr(),
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _selectDate(context, true);
                                },
                                child: Container(
                                  decoration: _decoration,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            LocaleKeys.from.tr(),
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight:
                                                  FontWeightManager.medium,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.calendarAlt,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            DateFormat()
                                                .add_yMMM()
                                                .format(startDate),
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight:
                                                  FontWeightManager.medium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _selectDate(context, false);
                                },
                                child: Container(
                                  decoration: _decoration,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            LocaleKeys.to.tr(),
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight:
                                                  FontWeightManager.medium,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.calendarAlt,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            DateFormat()
                                                .add_yMMM()
                                                .format(endDate),
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight:
                                                  FontWeightManager.medium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        TitleWidget(
                            txt: LocaleKeys.select_kashta_location.tr()),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2), width: 1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  value: selectedCategory?.name ?? '',
                                  isExpanded: true,
                                  iconDisabledColor: ColorManager.orangeColor,
                                  iconEnabledColor: ColorManager.orangeColor,
                                  items: cubit
                                          .providerCategoriesWithUnits.isEmpty
                                      ? []
                                      : cubit.providerCategoriesWithUnits
                                          .map((e) => cubit
                                                  .providerCategoriesWithUnits
                                                  .isEmpty
                                              ? ""
                                              : e.name)
                                          .toList()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                          return DropdownMenuItem<String>(
                                            value: cubit
                                                    .providerCategoriesWithUnits
                                                    .isEmpty
                                                ? ''
                                                : value,
                                            child: Text(
                                              value,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          );
                                        }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCategory = cubit
                                          .providerCategoriesWithUnits
                                          .firstWhere((element) =>
                                              element.name == newValue!);
                                      selectedUnit =
                                          selectedCategory?.units.first;
                                    });

                                    cubit.getFinancialSummary(
                                        from: DateFormat('yyyy-MM-dd')
                                            .format(startDate),
                                        to: DateFormat('yyyy-MM-dd')
                                            .format(endDate),
                                        unitId: selectedUnit?.id);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // DropDownWidget(values: cubit.providerCategoriesWithUnits.map((e) => e.name).toList(),onSelect: (){},),
                        SizedBox(height: 30),
                        TitleWidget(txt: LocaleKeys.select_unit.tr()),

                        Container(
                          decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2), width: 1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  value:
                                      cubit.providerCategoriesWithUnits.isEmpty
                                          ? ''
                                          : selectedUnit!.name,
                                  isExpanded: true,
                                  iconDisabledColor: ColorManager.orangeColor,
                                  iconEnabledColor: ColorManager.orangeColor,
                                  items: cubit
                                          .providerCategoriesWithUnits.isEmpty
                                      ? []
                                      : selectedCategory!.units
                                          .map((e) => e.name ?? '')
                                          .toList()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                          return DropdownMenuItem<String>(
                                            value: cubit
                                                    .providerCategoriesWithUnits
                                                    .isEmpty
                                                ? ''
                                                : value,
                                            child: Text(
                                              value,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          );
                                        }).toList(),
                                  onChanged: (String? newValue) {
                                    print('=========================');
                                    print(newValue);
                                    print('=========================');
                                    setState(() {
                                      selectedUnit = selectedCategory!.units
                                          .firstWhere((element) =>
                                              element.name == newValue);
                                    });

                                    cubit.getFinancialSummary(
                                        from: DateFormat('yyyy-MM-dd')
                                            .format(startDate),
                                        to: DateFormat('yyyy-MM-dd')
                                            .format(endDate),
                                        unitId: selectedUnit!.id);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // DropDownWidget(values: ['وحدة 2', 'وحدة 1']),
                        SizedBox(height: 30),
                        ContainerDecorated(
                          content: cubit.financialData.reservations == null
                              ? Text('')
                              : ToggleList(
                                  shrinkWrap: true,
                                  scrollPhysics:
                                      const NeverScrollableScrollPhysics(),
                                  trailing: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      size: 15,
                                      color: ColorManager.orangeColor,
                                    ),
                                  ),
                                  trailingExpanded: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.chevronDown,
                                      size: 15,
                                      color: ColorManager.orangeColor,
                                    ),
                                  ),
                                  children: cubit.providerCategoriesWithUnits
                                      .map((e) => ToggleListItem(
                                            title: Text(e.name),
                                            content: Column(
                                              children: e.units
                                                  .map((unit) => ToggleListItem(
                                                        title: Text(
                                                            unit.name ?? ''),
                                                        content: SizedBox(),
                                                      ))
                                                  .toList(),
                                            ),
                                          ))
                                      .toList(),
                                ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
