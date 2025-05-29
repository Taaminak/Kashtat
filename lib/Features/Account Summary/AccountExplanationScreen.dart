import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
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

class AccountExplanationScreen extends StatefulWidget {
  const AccountExplanationScreen({Key? key}) : super(key: key);

  @override
  State<AccountExplanationScreen> createState() =>
      _AccountExplanationScreenState();
}

class _AccountExplanationScreenState extends State<AccountExplanationScreen> {
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
    cubit.getRatingSummary();

    setState(() {
      if (cubit.providerCategoriesWithUnits.isNotEmpty) {
        selectedCategory = cubit.providerCategoriesWithUnits.first;
        if (selectedCategory != null && selectedCategory!.units.isNotEmpty) {
          selectedUnit = selectedCategory!.units.first;
        }
      }
    });

    cubit.getFinancialSummary(
        to: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text(
          LocaleKeys.account_statements.tr(),
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
                // height: size.height-115,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is FinancialSummaryLoadingState ||
                            state is RatingSummaryLoadingState)
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
                                            'من',
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
                                            'الي',
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
                                  onChanged: (String? newValue) async {
                                    setState(() {
                                      selectedCategory = cubit
                                          .providerCategoriesWithUnits
                                          .firstWhere((element) =>
                                              element.name == newValue!);
                                      selectedUnit =
                                          selectedCategory?.units.first;
                                    });

                                    await cubit.getRatingSummary(
                                        unitId: selectedUnit?.id);
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
                                  onChanged: (String? newValue) async {
                                    print('=========================');
                                    print(newValue);
                                    print('=========================');
                                    setState(() {
                                      selectedUnit = selectedCategory!.units
                                          .firstWhere((element) =>
                                              element.name == newValue);
                                    });

                                    await cubit.getRatingSummary(
                                        unitId: selectedUnit?.id);
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: _decoration,
                              width: size.width / 2.4,
                              height: size.width / 2.4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      LocaleKeys.sales.tr(),
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    Text(
                                      "${(cubit.financialData.sales ?? 0.0).toStringAsFixed(2)} ر.س",
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: _decoration,
                              width: size.width / 2.4,
                              height: size.width / 2.4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      LocaleKeys.commission.tr(),
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    Text(
                                      "${(cubit.financialData.commissions ?? 0.0).toStringAsFixed(2)} ر.س",
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: _decoration,
                              width: size.width / 2.4,
                              height: size.width / 2.4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      LocaleKeys.net_sales.tr(),
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    Text(
                                      "${(cubit.financialData.netProfit ?? 0.0).toStringAsFixed(2)} ر.س",
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: _decoration,
                              width: size.width / 2.4,
                              height: size.width / 2.4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      LocaleKeys.transfers.tr(),
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    Text(
                                      "${(cubit.financialData.netProfit ?? 0.0).toStringAsFixed(2)} ر.س",
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: _decoration,
                              width: size.width / 2.4,
                              height: size.width / 2.4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      LocaleKeys.number_of_reservations.tr(),
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    Text(
                                      (cubit.financialData.reservationsCount ??
                                              '')
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: _decoration,
                              width: size.width / 2.4,
                              height: size.width / 2.4,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      LocaleKeys.ratings.tr(),
                                      style: TextStyle(
                                        fontSize: FontSize.s18,
                                        fontWeight: FontWeightManager.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        for (int i = 0; i < 5; i++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Icon(
                                              Icons.star,
                                              color: ((i + 1) > cubit.totalRate)
                                                  ? Colors.grey
                                                  : ColorManager.yellowColor,
                                              size: 20,
                                            ),
                                          ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${cubit.totalRate}/5',
                                          style: TextStyle(
                                            fontSize: FontSize.s14,
                                            fontWeight: FontWeightManager.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          LocaleKeys.transfers.tr(),
                          style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        ContainerDecorated(
                          content: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                cubit.financialData.reservations?.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.1))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        LocaleKeys.total.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeightManager.bold,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'ريال${cubit.financialData.reservations?[index].total}',
                                        style: TextStyle(
                                            fontWeight: FontWeightManager.bold,
                                            fontSize: 14),
                                      ),
                                      Spacer(),
                                      Text(
                                        LocaleKeys.arrival_date.tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeightManager.bold,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${cubit.financialData.reservations?[index].arrivalDateTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeightManager.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        Text(
                          LocaleKeys.reservation_list.tr(),
                          style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ContainerDecorated(
                          content: cubit.financialData.reservations == null
                              ? Row(
                                  children: [],
                                )
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
                                  children: cubit.financialData.reservations!
                                      .map((e) => ToggleListItem(
                                            itemDecoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.1)),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        e.arrivalDateTime,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        e.unit.category?.name ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        LocaleKeys
                                                            .reservation_number
                                                            .tr(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .bold,
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        '${e.id}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .bold,
                                                            fontSize: 14),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        LocaleKeys.total.tr(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .bold,
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        '${e.total} ريال',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .bold,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      LocaleKeys
                                                          .reservation_number
                                                          .tr(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .bold,
                                                        color: ColorManager
                                                            .orangeColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      e.id.toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .medium,
                                                        fontSize: FontSize.s12,
                                                      ),
                                                    ),
                                                    const Divider(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      LocaleKeys.unit_name.tr(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .bold,
                                                        color: ColorManager
                                                            .orangeColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      e.unit.name ?? '',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .medium,
                                                        fontSize: FontSize.s12,
                                                      ),
                                                    ),
                                                    const Divider(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      LocaleKeys
                                                          .reservation_summary
                                                          .tr(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .bold,
                                                        color: ColorManager
                                                            .orangeColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RecordItem(
                                                            requestKey:
                                                                LocaleKeys
                                                                    .arrival_date
                                                                    .tr(),
                                                            value: e
                                                                .arrivalDateTime),
                                                        RecordItem(
                                                            requestKey: LocaleKeys
                                                                .departure_date
                                                                .tr(),
                                                            value: e
                                                                .leavingDateTime),
                                                        RecordItem(
                                                          requestKey: LocaleKeys
                                                              .arrival_time
                                                              .tr(),
                                                          value: '10 صباحا',
                                                        ),
                                                        RecordItem(
                                                          requestKey: LocaleKeys
                                                              .departure_time
                                                              .tr(),
                                                          value: '10 مساءا',
                                                        ),
                                                        RecordItem(
                                                            requestKey:
                                                                '${e.unit.price?.others == null ? '' : (double.parse(e.subtotal) / int.parse(e.unit.price?.others ?? '1')).round()} ${LocaleKeys.nights.tr()} ${e.subtotal}xر.س',
                                                            value:
                                                                '${e.subtotal} ر.س'),
                                                        RecordItem(
                                                            requestKey:
                                                                '${LocaleKeys.vat.tr()} 15%',
                                                            value:
                                                                '${e.vat} ر.س'),
                                                        RecordItem(
                                                          requestKey: LocaleKeys
                                                              .total
                                                              .tr(),
                                                          value:
                                                              '${e.total} ر.س',
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      LocaleKeys.guest_data
                                                          .tr(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .bold,
                                                          color: ColorManager
                                                              .orangeColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          e.user.name ?? '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .medium,
                                                              fontSize:
                                                                  FontSize.s14),
                                                        ),
                                                        Text(
                                                          (e.user.phone ?? '')
                                                              .replaceAll(
                                                                  '+', ""),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .medium,
                                                            fontSize:
                                                                FontSize.s14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      LocaleKeys.payment_data
                                                          .tr(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .bold,
                                                          color: ColorManager
                                                              .orangeColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys
                                                              .payment_method
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .bold,
                                                              fontSize:
                                                                  FontSize.s14),
                                                        ),
                                                        const Spacer(),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children:
                                                                e.paymentMethods
                                                                    .map(
                                                                      (method) =>
                                                                          Text(
                                                                        "$method ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeightManager.medium,
                                                                          fontSize:
                                                                              FontSize.s14,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                    )
                                                                    .toList()),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys.paid_amount
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .bold,
                                                              color: ColorManager
                                                                  .blackColor,
                                                              fontSize: 14),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          '${e.total} ر.س',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .medium,
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys
                                                              .commission_amount
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .bold,
                                                              color: ColorManager
                                                                  .blackColor,
                                                              fontSize: 14),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          '${(double.parse(e.total) * 0.2).toStringAsFixed(2)} ر.س',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .medium,
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      LocaleKeys.commission_note
                                                          .tr(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys.net_amount
                                                              .tr(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .bold,
                                                              color: ColorManager
                                                                  .blackColor,
                                                              fontSize: 14),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          '${(double.parse(e.total) - (double.parse(e.total) * 0.2)).toStringAsFixed(2)} ر.س',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeightManager
                                                                      .medium,
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      LocaleKeys.transfer_note
                                                          .tr(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          LocaleKeys.ratings.tr(),
                          style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        if (cubit.rates.isEmpty)
                          Center(
                            child: Text(
                              'لا يوجد لديك تقييمات حاليا',
                              style: TextStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.darkGreyColor,
                              ),
                            ),
                          ),

                        if (cubit.rates.isNotEmpty)
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cubit.rates.length,
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  cubit.rates[index].user
                                                          ?.name ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeightManager.bold,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  cubit.rates[index].createdAt!
                                                      .split('T')
                                                      .first,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  for (int i = 0; i < 5; i++)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: Icon(
                                                        Icons.star,
                                                        color: ((i + 1) >
                                                                cubit
                                                                    .rates[
                                                                        index]
                                                                    .rating!)
                                                            ? Colors.grey
                                                            : ColorManager
                                                                .yellowColor,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                      "${cubit.rates[index].rating!}/5",
                                                      style: TextStyle(
                                                        fontSize: FontSize.s20,
                                                        fontWeight:
                                                            FontWeightManager
                                                                .bold,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
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
