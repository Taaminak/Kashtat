import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'package:intl/intl.dart';

import '../../Widgets/Loader.dart';
import 'CalendersScreen.dart';

class SPCalenderScreen extends StatefulWidget {
  const SPCalenderScreen({Key? key}) : super(key: key);

  @override
  State<SPCalenderScreen> createState() => _SPCalenderScreenState();
}

class _SPCalenderScreenState extends State<SPCalenderScreen> {
  @override
  void initState() {
    final cubit = BlocProvider.of<AppBloc>(context);
    cubit.getAllProviderUnits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.calendar.tr()),
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
          return state is ProviderCategoriesWithUnitsLoadingState
              ? Center(
                  child: Loader(),
                )
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 30.0, right: 30.0),
                    child: Column(
                      children: [
                        Text(
                          DateFormat.yMMMM('en_US').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: FontSize.s24,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.mainlyBlueColor),
                        ),
                        SizedBox(height: 15),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  cubit.providerCategoriesWithUnits.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          cubit
                                              .providerCategoriesWithUnits[
                                                  index]
                                              .name,
                                          style: TextStyle(
                                              fontSize: FontSize.s26,
                                              fontWeight:
                                                  FontWeightManager.bold,
                                              color:
                                                  ColorManager.mainlyBlueColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing: 40,
                                                  childAspectRatio: 0.9),
                                          itemCount: cubit
                                              .providerCategoriesWithUnits[
                                                  index]
                                              .units
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int innerIndex) {
                                            return GestureDetector(
                                              onTap: () {
                                                cubit.setSelectedUnit(cubit
                                                    .providerCategoriesWithUnits[
                                                        index]
                                                    .units[innerIndex]);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CalendersScreens(),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(19),
                                                          color: ColorManager
                                                              .mainlyBlueColorLight,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child: Image.asset(
                                                            ImageManager
                                                                .calenderSP,
                                                            color: ColorManager
                                                                .mainlyBlueColor,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      cubit
                                                              .providerCategoriesWithUnits[
                                                                  index]
                                                              .units[innerIndex]
                                                              .name ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize:
                                                              FontSize.s18,
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .bold,
                                                          color: ColorManager
                                                              .mainlyBlueColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      if (index !=
                                          cubit.providerCategoriesWithUnits
                                                  .length -
                                              1)
                                        Divider(
                                          thickness: 2.0,
                                          color: ColorManager.greyColor,
                                        )
                                    ],
                                  ),
                                );
                              }),
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
