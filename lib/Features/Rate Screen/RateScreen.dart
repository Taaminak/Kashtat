import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';
import '../../Core/models/ProviderCategorysWithUnits.dart';
import '../../Core/models/UnitModel.dart';
import '../Service Provider/Home/SPHomeScreen.dart';
import '../Wallet Logs Screen/Widgets/WalletItemWidget.dart';
import '../Widgets/ItemScreenTitle.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  String dropdownValue = 'الرياض';
  DateTime startDate = DateTime(2022);
  DateTime endDate = DateTime.now();
  ProviderCategoriesWithUnits selectedCategory = ProviderCategoriesWithUnits(
      name: 'جميع التصنيفات', categoryId: -1, units: []);
  UnitModel selectedUnit = UnitModel(name: 'كل الوحدات', id: -1);
  List<ProviderCategoriesWithUnits> allCategories = [];
  List<UnitModel> allUnits = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData()async{

    final cubit = BlocProvider.of<AppBloc>(context);
    // await cubit.getAllProviderUnits();
    cubit.getRatingSummary();

    setState(() {
      if (cubit.providerCategoriesWithUnits.isNotEmpty) {
        selectedCategory = cubit.providerCategoriesWithUnits.first;
        if (selectedCategory.units.isNotEmpty) {
          selectedUnit = selectedCategory.units.first;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
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
                        const SizedBox(height: 20),
                        Image.asset(
                          ImageManager.logoWithTitleHColored,
                          width: 150,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'التقييمات',
                          style: TextStyle(
                            fontSize: FontSize.s34,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ContainerDecorated(
                                    content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if(state is RatingSummaryLoadingState)
                                    LinearProgressIndicator(color: ColorManager.mainlyBlueColor,backgroundColor: ColorManager.mainlyBlueColorLight),
                                    SizedBox(height: state is RatingSummaryLoadingState?16:20),
                                    TitleWidget(txt: 'اختر لوكيشن الكشتة'),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorManager.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.2),
                                            width: 1),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              value:cubit
                                                  .providerCategoriesWithUnits.isEmpty?'': selectedCategory.name,
                                              isExpanded: true,
                                              iconDisabledColor:
                                                  ColorManager.orangeColor,
                                              iconEnabledColor:
                                                  ColorManager.orangeColor,
                                              items:cubit
                                                  .providerCategoriesWithUnits.isEmpty?[]: cubit
                                                  .providerCategoriesWithUnits
                                                  .map((e) => e.name)
                                                  .toList()
                                                  .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedCategory = cubit
                                                      .providerCategoriesWithUnits
                                                      .firstWhere((element) =>
                                                          element.name ==
                                                          newValue!);
                                                  selectedUnit =
                                                      selectedCategory
                                                          .units.first;
                                                });

                                                cubit.getRatingSummary(unitId: selectedUnit.id);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // DropDownWidget(values: cubit.providerCategoriesWithUnits.map((e) => e.name).toList(),onSelect: (){},),
                                    const SizedBox(height: 20),
                                    const TitleWidget(txt: 'اختر الوحدة'),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorManager.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.2),
                                            width: 1),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              value: selectedUnit.name,
                                              isExpanded: true,
                                              iconDisabledColor:
                                                  ColorManager.orangeColor,
                                              iconEnabledColor:
                                                  ColorManager.orangeColor,
                                              items: selectedCategory.units
                                                  .map((e) => e.name ?? '')
                                                  .toList()
                                                  .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                print(
                                                    '=========================');
                                                print(newValue);
                                                print(
                                                    '=========================');
                                                setState(() {
                                                  selectedUnit =
                                                      selectedCategory.units
                                                          .firstWhere(
                                                              (element) =>
                                                                  element
                                                                      .name ==
                                                                  newValue);
                                                });

                                                cubit.getRatingSummary(
                                                    unitId: selectedUnit.id);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),

                                    if (cubit.rates.isEmpty)
                                      Center(
                                        child: Text(
                                          'لا يوجد لديك تقييمات حاليا',
                                          style: TextStyle(
                                            fontSize: FontSize.s12,
                                            fontWeight:
                                                FontWeightManager.medium,
                                            color: ColorManager.darkGreyColor,
                                          ),
                                        ),
                                      ),

                                    if (cubit.rates.isNotEmpty)
                                      ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: cubit.rates.length,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              cubit.rates[index].user?.name??'',
                                                              style: const TextStyle(
                                                                fontWeight: FontWeightManager.bold,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              cubit.rates[index]
                                                                  .createdAt!
                                                                  .split('T')
                                                                  .first,
                                                              style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              for (int i = 0;
                                                                  i < 5;
                                                                  i++)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: ((i +
                                                                                1) >
                                                                            cubit
                                                                                .rates[
                                                                                    index]
                                                                                .rating!)
                                                                        ? Colors
                                                                            .grey
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
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child: Text(
                                                                  "${cubit.rates[index].rating!}/5",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        FontSize
                                                                            .s20,
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
                                    // SizedBox(height: 100,),
                                  ],
                                )),
                                SizedBox(
                                  height: 20,
                                )
                              ],
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
}
