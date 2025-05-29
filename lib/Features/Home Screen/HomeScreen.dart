import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Features/Home%20Screen/Widgets/EmptyWidget.dart';
import 'package:kashtat/Features/Home%20Screen/Widgets/FilterButtonWidget.dart';
import 'package:kashtat/Features/Home%20Screen/Widgets/TypeWidget.dart';
import 'package:kashtat/Features/Widgets/HeaderWidget.dart';
import 'package:kashtat/Features/Widgets/Loader.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';

import '../../translations/locale_keys.g.dart';
import '../Request Details/Widgets/ShowModelBottomSheet.dart';
import 'Widgets/HomeItemWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  int selectedSub = 0;
  int selectedCity = -1;

  List<String> cities = [];
  List<String> selectedDates = [];
  List<DateTime?> _dates = [];

  ScrollController controller = ScrollController();

  listenOnScrolling() {
    controller.addListener(() {
      // print(controller.position);
      // print(controller.position.pixels);

      if (controller.position.pixels > 40) {
        setState(() {
          isHorizontal = true;
        });
      } else {
        setState(() {
          isHorizontal = false;
        });
      }
    });
  }

  bool isHorizontal = false;
  @override
  void initState() {
    listenOnScrolling();
    final cubit = BlocProvider.of<AppBloc>(context);
    int rating = 1;
    cubit.initAppData().then((_) {
      setState(() {
        cities = [];
        for (int i = 0; i < cubit.allCities.length; i++) {
          cities.add(cubit.allCities[i].name);
        }
        selectedDates = cubit.selectedDates;
        _dates = cubit.selectedDates.map((e) => DateTime.parse(e)).toList();
      });

      if (cubit.selectedDates.isEmpty) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            selectCity().then((value) => _selectDate(context)).then((value) {
              cubit.getLastTrip().then((value) {
                if (cubit.lastTrip?.rating == -1) {
                  final date = cubit.lastTrip?.leavingDateTime.split('-');
                  final birthday = date == null
                      ? DateTime.now()
                      : DateTime(
                          int.parse(date[2]),
                          int.parse(date[1]),
                          int.parse(date[0]),
                        );
                  final date2 = DateTime.now();
                  final difference = birthday.difference(date2).inDays;
                  if (difference > 0) {
                    // print('cancel');
                    return;
                  }
                  customBottomSheet(context, '',
                      StatefulBuilder(builder: (context, innerSetState) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                  width: 130,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          cubit.lastTrip?.unit.mainPic ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Loader(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.image_not_supported_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'كيف كانت الكشتة مع',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  cubit.lastTrip?.unit.name ?? '',
                                  style: TextStyle(
                                      color: ColorManager.mainlyBlueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            innerSetState(() {
                                              rating = i + 1;
                                            });
                                            // print(rating);
                                          },
                                          child: FaIcon(
                                            FontAwesomeIcons.solidStar,
                                            color: i < rating
                                                ? Colors.amber
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    KButton(
                                        onTap: () {
                                          cubit.rateReservation(rating: 1);
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                              msg: "تم التقييم",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        },
                                        title: 'تخطي',
                                        width: 150,
                                        paddingV: 15),
                                    KButton(
                                      onTap: () {
                                        cubit.rateReservation(rating: rating);
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg: "تم التقييم",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      },
                                      title: 'التالي',
                                      width: 150,
                                      paddingV: 15,
                                      hasBorder: true,
                                      clr: Colors.white,
                                      txtClr: ColorManager.mainlyBlueColor,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }), true, 430);
                }
              });
            });
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<AppBloc>(context);
          return BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          LocaleKeys.select_city_and_date.tr(),
                          style: TextStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.blackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            FilterButton(
                              onTap: () {
                                selectCity();
                              },
                              title: selectedCity == -1
                                  ? LocaleKeys.select_city.tr()
                                  : cubit.allCities[selectedCity].name,
                            ),
                            const SizedBox(width: 15),
                            FilterButton(
                                onTap: () {
                                  _selectDate(context);
                                },
                                title: selectedDates.isEmpty
                                    ? LocaleKeys.select_date.tr()
                                    : "${selectedDates.first} - ${selectedDates.last} [ ${selectedDates.length} ليالي ] "),
                            // const Spacer(),
                            // Image.asset(ImageManager.gridList,width: 20),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          LocaleKeys.select_kashta_type.tr(),
                          style: TextStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.blackColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 350),
                          firstChild: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: SizedBox(
                              height: 40,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cubit.allCategories.length,
                                  padding: const EdgeInsets.all(0.0),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        cubit.filterHomeUnitsByCategory(
                                            catId:
                                                cubit.allCategories[index].id ??
                                                    0);
                                        setState(() {
                                          selected =
                                              cubit.allCategories[index].id ??
                                                  0;
                                          selectedSub = -1;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: selected ==
                                                      cubit.allCategories[index]
                                                          .id
                                                  ? ColorManager.orangeColor
                                                  : ColorManager
                                                      .mainlyBlueColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: Center(
                                              child: Text(
                                                cubit.allCategories[index]
                                                        .name ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: FontSize.s14,
                                                  fontWeight:
                                                      FontWeightManager.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      cubit.categoriesWithSubCategories.length,
                                  padding: const EdgeInsets.all(0.0),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          HomeTypeWidget(
                                            title: cubit
                                                    .categoriesWithSubCategories[
                                                        index]
                                                    .name ??
                                                '',
                                            img: cubit
                                                    .categoriesWithSubCategories[
                                                        index]
                                                    .img ??
                                                '',
                                            color: selected ==
                                                    cubit
                                                        .categoriesWithSubCategories[
                                                            index]
                                                        .id
                                                ? ColorManager.orangeColor
                                                : null,
                                            onTap: () {
                                              cubit.filterHomeUnitsByCategory(
                                                  catId: cubit
                                                          .categoriesWithSubCategories[
                                                              index]
                                                          .id ??
                                                      0);
                                              setState(() {
                                                selected = cubit
                                                        .categoriesWithSubCategories[
                                                            index]
                                                        .id ??
                                                    0;
                                                selectedSub = -1;
                                              });
                                            },
                                            count: cubit
                                                .categoriesWithSubCategories[
                                                    index]
                                                .unitsCount
                                                .toString(),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          if (selected ==
                                              cubit
                                                  .categoriesWithSubCategories[
                                                      index]
                                                  .id)
                                            const SizedBox(height: 10),
                                          if (selected ==
                                              cubit
                                                  .categoriesWithSubCategories[
                                                      index]
                                                  .id)
                                            GridView.custom(
                                              primary: false,
                                              padding: const EdgeInsets.all(0),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              childrenDelegate:
                                                  SliverChildBuilderDelegate(
                                                childCount: cubit
                                                    .categoriesWithSubCategories[
                                                        index]
                                                    .subCategories!
                                                    .length,
                                                (context, innerIndex) =>
                                                    InkWell(
                                                  onTap: () {
                                                    cubit
                                                        .filterHomeUnitsByCategory(
                                                      catId: cubit
                                                              .categoriesWithSubCategories[
                                                                  index]
                                                              .id ??
                                                          0,
                                                      subCatId: cubit
                                                              .categoriesWithSubCategories[
                                                                  index]
                                                              .subCategories![
                                                                  innerIndex]
                                                              .id ??
                                                          0,
                                                    );
                                                    setState(() {
                                                      selectedSub = cubit
                                                              .categoriesWithSubCategories[
                                                                  index]
                                                              .subCategories![
                                                                  innerIndex]
                                                              .id ??
                                                          0;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: selectedSub !=
                                                                  cubit
                                                                      .categoriesWithSubCategories[
                                                                          index]
                                                                      .subCategories![
                                                                          innerIndex]
                                                                      .id
                                                              ? ColorManager
                                                                  .orangeColor
                                                              : ColorManager
                                                                  .mainlyBlueColor),
                                                      color: selectedSub ==
                                                              cubit
                                                                  .categoriesWithSubCategories[
                                                                      index]
                                                                  .subCategories![
                                                                      innerIndex]
                                                                  .id
                                                          ? ColorManager
                                                              .mainlyBlueColor
                                                          : Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Text(
                                                          cubit
                                                                  .categoriesWithSubCategories[
                                                                      index]
                                                                  .subCategories![
                                                                      innerIndex]
                                                                  .name ??
                                                              '',
                                                          style: TextStyle(
                                                            color: selectedSub !=
                                                                    cubit
                                                                        .categoriesWithSubCategories[
                                                                            index]
                                                                        .subCategories![
                                                                            innerIndex]
                                                                        .id
                                                                ? ColorManager
                                                                    .mainlyBlueColor
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .bold,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              semanticChildCount: 1,
                                              gridDelegate:
                                                  SliverWovenGridDelegate.count(
                                                crossAxisCount: 4,
                                                mainAxisSpacing: 8,
                                                crossAxisSpacing: 8,
                                                pattern: [
                                                  const WovenGridTile(1.8),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  }),
                              GridView.custom(
                                primary: false,
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                childrenDelegate: SliverChildBuilderDelegate(
                                  childCount: cubit
                                      .categoriesWithoutSubCategories.length,
                                  (context, index) => HomeTypeWidgetGrid(
                                    title: cubit
                                            .categoriesWithoutSubCategories[
                                                index]
                                            .name ??
                                        '',
                                    img: cubit
                                            .categoriesWithoutSubCategories[
                                                index]
                                            .img ??
                                        '',
                                    bgIconColor: ColorManager.orangeColor,
                                    color: selected ==
                                            cubit
                                                .categoriesWithoutSubCategories[
                                                    index]
                                                .id
                                        ? ColorManager.orangeColor
                                        : null,
                                    onTap: () {
                                      cubit.filterHomeUnitsByCategory(
                                          catId: cubit
                                                  .categoriesWithoutSubCategories[
                                                      index]
                                                  .id ??
                                              0);
                                      setState(() {
                                        selected = cubit
                                                .categoriesWithoutSubCategories[
                                                    index]
                                                .id ??
                                            0;
                                      });
                                    },
                                    count: cubit
                                        .categoriesWithoutSubCategories[index]
                                        .unitsCount
                                        .toString(),
                                  ),
                                ),
                                semanticChildCount: 1,
                                gridDelegate: SliverWovenGridDelegate.count(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  pattern: [
                                    const WovenGridTile(1.7),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                          crossFadeState: isHorizontal
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          // crossFadeState: isHorizontal ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state is LoadingHomeTripsState
                            ? const Loader()
                            : (cubit.homeTrips == null ||
                                    cubit.homeTrips!.data!.isEmpty)
                                ? const HomeEmptyWidget()
                                : ListView.builder(
                                    itemBuilder: (context, index) => cubit
                                                .homeTrips !=
                                            null
                                        ? HomeItemWidget(
                                            trip: cubit.homeTrips!.data![index],
                                            isAvailable: selectedDates.isEmpty
                                                ? true
                                                : isAvailableDates(
                                                    cubit
                                                            .homeTrips!
                                                            .data![index]
                                                            .reservedDates ??
                                                        [],
                                                    selectedDates),
                                            city: selectedCity != -1
                                                ? cubit.allCities[selectedCity]
                                                    .name
                                                : cubit.homeTrips!.data![index]
                                                    .state!.name,
                                          )
                                        : const SizedBox(),
                                    itemCount: cubit.homeTrips != null
                                        ? cubit.homeTrips?.data?.length
                                        : 0,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(bottom: 10),
                                  ),
                      ],
                    ),
                  )),
                ],
              );
            },
          );
        },
      ),
    );
  }

  _selectDate(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: CalendarDatePicker2WithActionButtons(
              config: CalendarDatePicker2WithActionButtonsConfig(
                firstDayOfWeek: 1,
                calendarType: CalendarDatePicker2Type.range,
                selectedDayTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
                selectedDayHighlightColor: Colors.purple[800],
                centerAlignModePicker: true,
                customModePickerIcon: const SizedBox(),
                // dayBuilder: _yourDayBuilder,
                dayBuilder: ({
                  required date,
                  textStyle,
                  decoration,
                  isSelected,
                  isDisabled,
                  isToday,
                }) {
                  Widget? dayWidget;
                  if (calculateDifference(date) < 0) {
                    dayWidget = Container(
                      decoration: decoration,
                      child: Center(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Text(
                              MaterialLocalizations.of(context)
                                  .formatDecimal(date.day),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 27.5),
                            //   child: Container(
                            //     height: 4,
                            //     width: 4,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       color: isSelected == true
                            //           ? Colors.white
                            //           : Colors.grey[500],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  }
                  return dayWidget;
                },
                // yearBuilder: _yourYearBuilder,
              ),
              value: _dates,
              onValueChanged: (dates) async {
                setState(() {
                  _dates = dates;
                });
                // print(_dates);
                if (_dates.isNotEmpty) {
                  if (calculateDifference(_dates.first ?? DateTime.now()) < 0) {
                    return;
                  }
                  if (_dates.length == 1) {
                    setState(() {
                      selectedDates = formatSelectedDays(_dates);
                    });
                  } else {
                    setState(() {
                      selectedDates =
                          getDaysInBetween(_dates.first, _dates.last);
                    });
                  }

                  // print('----------------------dates-------------------');
                  // print(selectedDates);

                  Navigator.pop(context);
                  final cubit = BlocProvider.of<AppBloc>(context);
                  // cubit.shuffleHomeUnites();
                  // images.shuffle();
                  // await cubit.getHomeTrips(dates:selectedDates.isEmpty?null: selectedDates,cityId: selectedCity==-1?null :cubit.allCities[selectedCity].id);
                  cubit.setSelectedDates(selectedDates);
                }
              },
              onCancelTapped: () {
                Navigator.pop(context);
                if (selectedDates.isEmpty) {
                  return;
                }

                setState(() {
                  selectedDates = [];
                  _dates = [];
                });
                final cubit = BlocProvider.of<AppBloc>(context);
                // cubit.shuffleHomeUnites();
                // images.shuffle();
                // cubit.getHomeTrips(dates:selectedDates.isEmpty?null: selectedDates,cityId: selectedCity==-1?null :cubit.allCities[selectedCity].id);
                cubit.setSelectedDates(selectedDates);
              },
            ),
          ),
        );
      },
    );
  }

  List<String> formatSelectedDays(List<DateTime?> dates) {
    List<String> days = [];
    for (int i = 0; i < dates.length; i++) {
      Intl.withLocale("en_US", () {
        days.add(DateFormat('y-MM-dd').format(dates[i]!));
      });
    }
    return days;
  }

  List<String> getDaysInBetween(DateTime? startDate, DateTime? endDate) {
    List<String> days = [];
    for (int i = 0; i <= endDate!.difference(startDate!).inDays; i++) {
      Intl.withLocale("en_US", () {
        // days.add(DateTime.parse(startDate.add(Duration(days: i)).toString()).toString());
        days.add(
            DateFormat("yyyy-MM-dd").format(startDate.add(Duration(days: i))));
      });
    }

    return days;
  }

  Future<void> selectCity() async {
    final cubit = BlocProvider.of<AppBloc>(context);
    await customBottomSheet(
      context,
      'حدد المدينة',
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.allCities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.5),
                    child: InkWell(
                      onTap: () {
                        if (selectedCity == index) {
                          setState(() {
                            selectedCity = -1;
                          });
                        } else {
                          setState(() {
                            selectedCity = index;
                          });
                        }

                        cubit.filterUsingCityId(selectedCity == -1
                            ? null
                            : cubit.allCities[index].id);
                        cubit.getAllCategories(
                            cityId: selectedCity == -1
                                ? null
                                : cubit.allCities[index].id);
                        cubit.getHomeTrips(
                            cityId: selectedCity == -1
                                ? null
                                : cubit.allCities[index].id);
                        setState(() {
                          selected = 0;
                        });

                        context.pop();
                      },
                      child: Row(
                        children: [
                          Text(
                            cubit.allCities[index].name,
                            style: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.bold,
                              color: index == selectedCity
                                  ? ColorManager.orangeColor
                                  : ColorManager.mainlyBlueColor,
                            ),
                          ),
                          if (index == selectedCity) const SizedBox(width: 15),
                          if (index == selectedCity)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: FaIcon(
                                FontAwesomeIcons.check,
                                size: 18,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      true,
    );
  }

  bool isAvailableDates<T>(List<String> first, List<String> second) {
    if (second.isEmpty) {
      return true;
    }
    List<String> output = [];
    for (String element in first) {
      if (second.contains(element.split(' ').first)) {
        output.add(element);
        break;
      }
    }
    return output.isEmpty;
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    int days = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    // print('---------------------------------------');
    // print(date);
    // print(days);
    // print('---------------------------------------');
    return days;
  }
}
