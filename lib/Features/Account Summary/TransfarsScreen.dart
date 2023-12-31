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
import 'package:toggle_list/toggle_list.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../../translations/locale_keys.g.dart';
import '../Request Details/Widgets/RequestDetailsWidget.dart';
import '../Widgets/ItemScreenTitle.dart';

class TransfarsScreen extends StatefulWidget {
  const TransfarsScreen({Key? key}) : super(key: key);

  @override
  State<TransfarsScreen> createState() => _TransfarsScreenState();
}

class _TransfarsScreenState extends State<TransfarsScreen> {
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
      initialDate: isStart?startDate:endDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      if (isStart) {
        setState(() {
          startDate = picked;
        });
        cubit.getFinancialSummary(from: DateFormat('yyyy-MM-dd').format(startDate),to: DateFormat('yyyy-MM-dd').format(endDate));
      } else {
        setState(() {
          endDate = picked;
        });
        cubit.getFinancialSummary(from: DateFormat('yyyy-MM-dd').format(startDate),to: DateFormat('yyyy-MM-dd').format(endDate));
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData()async{

    final cubit = BlocProvider.of<AppBloc>(context);
    cubit.getFinancialSummary(to: DateFormat('yyyy-MM-dd').format(DateTime.now()));


    setState(() {
      if (cubit.providerCategoriesWithUnits.isNotEmpty) {
        selectedCategory = cubit.providerCategoriesWithUnits.first;
        if (selectedCategory !=null && selectedCategory!.units.isNotEmpty) {
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
          'الحوالات',
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
                // height: size.height-100,
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(state is FinancialSummaryLoadingState)
                          LinearProgressIndicator(color: ColorManager.mainlyBlueColor,backgroundColor: ColorManager.mainlyBlueColorLight),
                        SizedBox(height: state is FinancialSummaryLoadingState?16:20),
                        Row(
                          children: [
                            Text(
                              'حدد الفترة',
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
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            'من',
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeightManager.medium,
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
                                          padding: const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            DateFormat()
                                                .add_yMMM()
                                                .format(startDate),
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeightManager.medium,
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            'الي',
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeightManager.medium,
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
                                          padding: const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            DateFormat().add_yMMM().format(endDate),
                                            style: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeightManager.medium,
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
                        TitleWidget(txt: 'اختر لوكيشن الكشتة'),
                        Container(
                          decoration: BoxDecoration(
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
                                color: Colors.grey.withOpacity(0.2), width: 1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  value: selectedCategory?.name??'',
                                  isExpanded: true,
                                  iconDisabledColor: ColorManager.orangeColor,
                                  iconEnabledColor: ColorManager.orangeColor,
                                  items:cubit.providerCategoriesWithUnits.isEmpty?[]: cubit.providerCategoriesWithUnits
                                      .map((e) => cubit.providerCategoriesWithUnits.isEmpty?"": e.name)
                                      .toList()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value:cubit.providerCategoriesWithUnits.isEmpty?'': value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCategory = cubit
                                          .providerCategoriesWithUnits
                                          .firstWhere((element) =>
                                      element.name == newValue!);
                                      selectedUnit = selectedCategory?.units.first;
                                    });

                                    cubit.getFinancialSummary(from: DateFormat('yyyy-MM-dd').format(startDate),to: DateFormat('yyyy-MM-dd').format(endDate),unitId: selectedUnit?.id);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // DropDownWidget(values: cubit.providerCategoriesWithUnits.map((e) => e.name).toList(),onSelect: (){},),
                        SizedBox(height: 30),
                        TitleWidget(txt: 'اختر الوحدة'),

                        Container(
                          decoration: BoxDecoration(
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
                                color: Colors.grey.withOpacity(0.2), width: 1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  value: cubit.providerCategoriesWithUnits.isEmpty?'':selectedUnit!.name,
                                  isExpanded: true,
                                  iconDisabledColor: ColorManager.orangeColor,
                                  iconEnabledColor: ColorManager.orangeColor,
                                  items: cubit.providerCategoriesWithUnits.isEmpty?[]:selectedCategory!.units
                                      .map((e) => e.name ?? '')
                                      .toList()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: cubit.providerCategoriesWithUnits.isEmpty?'':value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(fontSize: 14),
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

                                    cubit.getFinancialSummary(from: DateFormat('yyyy-MM-dd').format(startDate),to: DateFormat('yyyy-MM-dd').format(endDate),unitId: selectedUnit!.id);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // DropDownWidget(values: ['وحدة 2', 'وحدة 1']),
                        SizedBox(height: 20),
                        Text(
                          'عمليات الحوالات للشاليهات تتم بترتيب دوري كل 15 يوما اعتباراً من بداية كل شهر ميلادي.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'مبلغ العمولة المستحقة لتطبيق كشتات 20%',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20),

                        Container(
                          decoration: _decoration,
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'المبيعات',
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      (cubit.financialData.sales??0.0).toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'العمولة',
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      (cubit.financialData.commissions??0.0).toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'صافي المبيعات المحولة',
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      (cubit.financialData.netProfit??0.0).toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'الحوالات',
                          style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        ContainerDecorated(content: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:cubit.financialData.reservations?.length??0,
                          itemBuilder: (context,index)=>
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.withOpacity(0.1))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text('المبلغ',style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                        fontSize: 14
                                    ),),
                                    SizedBox(width: 10,),
                                    Text('ريال${cubit.financialData.reservations?[index].total}',style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        fontSize: 14
                                    ),),
                                    Spacer(),

                                    Text('التاريخ',style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                        fontSize: 14
                                    ),),
                                    SizedBox(width: 10,),
                                    Text('${cubit.financialData.reservations?[index].arrivalDateTime}',style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                        fontSize: 14
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ,),),

                        SizedBox(height: 20),
                        Text(
                          'قائمة الحجوزات',
                          style: TextStyle(
                            fontSize: FontSize.s20,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ContainerDecorated(
                          content: cubit.financialData.reservations == null?Text(''):ToggleList(
                          shrinkWrap: true,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
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
                          children:  cubit.financialData.reservations!.map((e) =>  ToggleListItem(
                            itemDecoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(5)),
                            title: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(e.arrivalDateTime,style: const TextStyle(
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 12,
                                        color: Colors.grey,
                                      ),),
                                      Spacer(),
                                      Text(e.unit.category?.name??'',style: const TextStyle(
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: 12,
                                         color: Colors.grey,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      const  Text('رقم الحجز',style: TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                          fontSize: 14
                                      ),),
                                      const SizedBox(width: 10,),
                                      Text('${e.id}',style:const  TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                          fontSize: 14
                                      ),),
                                      const Spacer(),
                                      const Text('الاجمالي',style: TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                          fontSize: 14
                                      ),),
                                      const SizedBox(width: 5,),
                                      Text('${e.total} ريال',style: const TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                          fontSize: 14
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            content: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'رقم الحجز',
                                      style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.orangeColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      e.id.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),
                                    Divider(height: 20,),
                                    Text(
                                      'اسم الوحدة',
                                      style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.orangeColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      e.unit.name??'',
                                      style: TextStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: FontSize.s12,
                                      ),
                                    ),

                                    Divider(height: 20,),
                                    Text(
                                      'ملخص الحجز',
                                      style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.orangeColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RecordItem(
                                            requestKey: 'تاريخ الوصول',
                                            value: e.arrivalDateTime),
                                        // value: DateFormat.yMMMMd().format(DateTime.parse(widget.trip.arrivalDateTime))),
                                        RecordItem(
                                            requestKey: 'تاريخ المغادرة',
                                            value: e.leavingDateTime),
                                        // value: DateFormat.yMMMMd().format(DateTime.parse(widget.trip.leavingDateTime))),
                                        RecordItem(
                                          requestKey: 'وقت الوصول',
                                          value:
                                          '10 صباحا',),
                                        RecordItem(
                                          requestKey: 'وقت المغادرة',
                                          value:
                                          '10 مساءا',),
                                        // DateFormat('kk:mm a').format(DateTime.parse(widget.trip.leavingDateTime)),),
                                        RecordItem(
                                            requestKey: '${e.unit.price?.others == null? '':(double.parse(e.subtotal)/int.parse(e.unit.price?.others??'1')).round()} ليالي ${e.subtotal}xر.س',
                                            value: '${e.subtotal} ر.س'),
                                        RecordItem(
                                            requestKey: 'ضريبة القيمة المضافة 15%',
                                            value: '${e.vat} ر.س'),
                                        // Divider(
                                        //   thickness: 2,
                                        //   height: 40,
                                        // ),
                                        RecordItem(
                                          requestKey: 'الاجمالي',
                                          value: '${e.total} ر.س',
                                        ),
                                      ],
                                    ),
                                    Divider(height: 20,),
                                    Text(
                                      'بيانات الضيف',
                                      style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.orangeColor
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.user.name??'',
                                          style: TextStyle(
                                            fontWeight: FontWeightManager.medium,
                                            fontSize: FontSize.s14
                                          ),
                                        ),
                                        Text(
                                          (e.user.phone??'').replaceAll('+', ""),
                                          style: TextStyle(
                                            fontWeight: FontWeightManager.medium,
                                            fontSize: FontSize.s14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 20,),
                                    Text(
                                      'بيانات الدفع',
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.bold,
                                          color: ColorManager.orangeColor
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "طريقة الدفع",
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              fontSize: FontSize.s14
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: e.paymentMethods.map((method) => Text(
                                              "$method ",
                                              style: TextStyle(
                                                fontWeight: FontWeightManager.medium,
                                                fontSize: FontSize.s14,
                                                color: Colors.grey,
                                              ),
                                            ),).toList()
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'المدفوع ( كامل المبلغ )',
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              color: ColorManager.blackColor,
                                              fontSize: 14
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${e.total} ر.س',
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.medium,
                                              color: Colors.grey,
                                              fontSize: 14
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'العمولة',
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              color: ColorManager.blackColor,
                                              fontSize: 14
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${(double.parse(e.total)*0.2).toStringAsFixed(2)} ر.س',
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.medium,
                                              color: Colors.grey,
                                              fontSize: 14
                                          ),
                                        ),
                                      ],
                                    ),

                                    Text(
                                      'مبلغ العمولة المستحقة لتطبيق كشتات 20%',
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.medium,
                                          color: Colors.grey,
                                          fontSize: 12
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'المبلغ الصافي (خاضع للضريبة)',
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              color: ColorManager.blackColor,
                                              fontSize: 14
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          '${(double.parse(e.total)-(double.parse(e.total)*0.2)).toStringAsFixed(2)} ر.س',
                                          style: TextStyle(
                                              fontWeight: FontWeightManager.medium,
                                              color: Colors.grey,
                                              fontSize: 14
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'المبلغ الذي سيتم تحويله الي مزود الخدمة',
                                      style: TextStyle(
                                          fontWeight: FontWeightManager.medium,
                                          color: Colors.grey,
                                          fontSize: 12
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),).toList(),
                        ),),
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
