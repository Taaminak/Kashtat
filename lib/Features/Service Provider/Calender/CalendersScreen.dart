import 'dart:io';

import 'package:calendar_builder/calendar_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';

class CalendersScreens extends StatefulWidget {
  const CalendersScreens({Key? key}) : super(key: key);


  @override
  State<CalendersScreens> createState() => _CalendersScreensState();
}

class _CalendersScreensState extends State<CalendersScreens> {
  List<DateTime> selectedDates = [];
  List<DateTime> disableDates = [];
  List<DateTime> selectedDisabledDates = [];

  setDisabledDates(){
    final cubit = BlocProvider.of<AppBloc>(context);
    setState(() {
      disableDates = cubit.selectedUnit.reservedDates!.map((e) => DateTime(DateTime.parse(e).year,DateTime.parse(e).month,DateTime.parse(e).day)).toList();
      print('------------------------------------------------');
      print(disableDates);
      print('------------------------------------------------');
    });
  }

  @override
  void initState() {
    setDisabledDates();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text(
          selectedDates.isEmpty?
          cubit.selectedUnit.name??'': "${selectedDates.length} ليالي",
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
      body: SafeArea(
        child:Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: PagedVerticalCalendar(
                  dayBuilder: (context, day)=>Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: (disableDates.contains(day) )?Colors.grey.withOpacity(0.5):selectedDates.contains(day)?ColorManager.mainlyBlueColor: Colors.transparent,
                          border: Border.all(color: selectedDisabledDates.contains(day)?ColorManager.mainlyBlueColor:Colors.transparent)
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(day.day.toString(),style: TextStyle(
                            color: (disableDates.contains(day)|| calculateDifference(day)<0)?selectedDisabledDates.contains(day)?ColorManager.mainlyBlueColor:Colors.grey: selectedDates.contains(day)?Colors.white: Colors.black,
                            decoration: disableDates.contains(day)?TextDecoration.lineThrough:null,
                            fontWeight: FontWeight.w500
                        ),),
                      )),
                    ),
                  ),
                  initialDate: DateTime.now(),
                  invisibleMonthsThreshold: 1,
                  startWeekWithSunday: true,
                  onMonthLoaded: (year, month) {
                    // on month widget load
                  },
                  onDayPressed: (selectedDateTime) {
                    DateTime clicked = DateTime(selectedDateTime.year,selectedDateTime.month,selectedDateTime.day);

                    if(calculateDifference(clicked)<0){
                      return;
                    }

                    if(disableDates.contains(clicked)) {
                      if(selectedDisabledDates.contains(clicked)){
                        selectedDisabledDates.remove(clicked);
                      }else{
                        selectedDisabledDates.add(clicked);
                      }
                      setState(() {});
                      return;
                    }

                    else if(selectedDates.contains(clicked)){
                      selectedDates.remove(clicked);
                    }else{
                      selectedDates.add(clicked);
                    }
                    setState(() {});
                    // on day widget pressed
                  },
                  onPaginationCompleted: (direction) {
                    // on pagination completion
                  },
                ),
              )
            ),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                  color: ColorManager.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.greyColor.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, -10), // changes position of shadow
                    ),
                  ],

                ),
                child: BlocConsumer<AppBloc, AppState>(
                  listener: (context, state) {
                    if(state is UpdateUnitSuccessAddDatesState){
                      setDisabledDates();
                      setState(() {
                        selectedDates.clear();
                      });
                    } else if(state is UpdateUnitSuccessRemoveDatesState){
                      setDisabledDates();
                      setState(() {
                        selectedDisabledDates.clear();
                      });
                    } else if(state is UpdateUnitFailureAddDatesState){
                      Fluttertoast.showToast(
                          msg: 'Failed To Reserve This Days.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorManager.darkGreyColor,
                          textColor: ColorManager.whiteColor,
                          fontSize: 16.0,

                      );

                    }else if(state is UpdateUnitFailureRemoveDatesState){

                      Fluttertoast.showToast(
                          msg: 'Failed To Free This Days.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorManager.darkGreyColor,
                          textColor: ColorManager.whiteColor,
                          fontSize: 16.0
                      );
                    }
                  },
                  builder: (context, state) {
                    return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      KButton(onTap:selectedDates.isEmpty?(){}: ()async{
                        List<String> dates = selectedDates.map((e) => e.toString()).toList();
                        cubit.updateUnitReservedDates(unitId: cubit.selectedUnit.id??-1,isAdd: true,dates: dates);
                      }, title: 'إشغال',clr: selectedDates.isEmpty? ColorManager.darkGreyColor :ColorManager.mainlyBlueColor,isLoading: state is UpdateUnitLoadingAddDatesState,),
                      KButton(onTap: selectedDisabledDates.isEmpty?(){}: (){
                        List<String> dates = selectedDisabledDates.map((e) => e.toString()).toList();
                        cubit.updateUnitReservedDates(unitId: cubit.selectedUnit.id??-1,isAdd: false,dates: dates);
                      }, title: 'إتاحة',clr:  selectedDisabledDates.isEmpty? ColorManager.darkGreyColor :ColorManager.mainlyBlueColor,isLoading: state is UpdateUnitLoadingRemoveDatesState,),
                  ],
                );
  },
),
              )
          ],
        ),
      ),
    );
  }
}
int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  int days = DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;

  return days;
}