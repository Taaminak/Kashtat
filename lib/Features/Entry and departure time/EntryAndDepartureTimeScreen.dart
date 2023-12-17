import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';

import '../Widgets/ItemScreenTitle.dart';
import 'dart:ui'as ui;

class EntryAndDepartureTimeScreen extends StatefulWidget {
  const EntryAndDepartureTimeScreen({Key? key}) : super(key: key);

  @override
  State<EntryAndDepartureTimeScreen> createState() => _EntryAndDepartureTimeScreenState();
}

class _EntryAndDepartureTimeScreenState extends State<EntryAndDepartureTimeScreen> {
  String arrivalTime = '';
  String leavingTime = '';
  @override
  void initState() {
    final cubit = BlocProvider.of<AppBloc>(context);
    setState(() {
      arrivalTime = cubit.selectedUnit.arrivalTime??'';
      leavingTime = cubit.selectedUnit.leavingTime??'';

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text('وقت الدخول والمغادرة',style: TextStyle(fontWeight: FontWeight.normal),),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: (){
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const FaIcon(FontAwesomeIcons.chevronLeft,size:20,color: Colors.white,),
            ),
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                TitleWidget(txt: 'وقت الدخول'),
                SizedBox(height: 10,),
            InkWell(
                onTap: ()async{
                  String? time= await getTime(context);
                  if(time!=null){
                    arrivalTime = time;
                    setState(() {});
                  }
                },
                  child: Container(decoration: _decoration,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(arrivalTime,style: TextStyle(
                            fontWeight: FontWeightManager.medium
                          ),),
                          FaIcon(FontAwesomeIcons.chevronDown,color: ColorManager.orangeColor,size: 14,)
                        ],
                      ),
                    )
                  ),
                ),
                SizedBox(height: 30,),
                TitleWidget(txt: 'وقت المغادرة'),
                SizedBox(height: 10,),
                InkWell(
                  onTap: ()async{
                    String? time= await getTime(context);
                    if(time!=null){
                      leavingTime = time;
                      setState(() {});
                    }
                  },
                  child: Container(decoration: _decoration,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(leavingTime,style: TextStyle(
                                fontWeight: FontWeightManager.medium
                            ),),
                            FaIcon(FontAwesomeIcons.chevronDown,color: ColorManager.orangeColor,size: 14,)
                          ],
                        ),
                      )
                  ),
                ),
                SizedBox(height: 50,),
                Text('حدد أوقات دخول ومغادرة الضيوف واترك اكثر من ساعتين على الأقل بين وقت الدخول والمغادرة حتى يتسنى لك تنظيف المكان وتجهيزة',
                style: TextStyle(
                  color: ColorManager.darkerGreyColor,
                  fontWeight: FontWeightManager.medium,
                ),),
                const SizedBox(height: 100,),
                BlocConsumer<AppBloc, AppState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return KButton(onTap: (){
                      final cubit = BlocProvider.of<AppBloc>(context);
                      cubit.updateNewUnitTime(arrival: arrivalTime, leaving: leavingTime);
                      cubit.updateUnitTimes();
                    }, title: 'حفظ',width: size.width,paddingV: 15,isLoading: state is UpdateUnitLoadingState,);
                  },
                ),
                SizedBox(height: 40,),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<String?> getTime(BuildContext context)async{
    final time =  await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: child!,
        );
      },
    );
    DateTime datetime = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,time!.hour,time.minute);
    return DateFormat('kk:mm').format(datetime);
  }
}


BoxDecoration _decoration = BoxDecoration(
  color: ColorManager.whiteColor,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 7,
      offset: const Offset(0, 0), // changes position of shadow
    ),
  ],
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    color: Colors.grey.withOpacity(0.2),
    width: 1,
  ),
);
