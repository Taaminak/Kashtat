import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Notification%20Screen/NotificationScreen.dart';
import 'package:kashtat/Features/Widgets/ItemScreenTitle.dart';

import '../../../Core/Cubit/AppState.dart';
import '../../../Core/constants/RoutesManager.dart';
class SPHome extends StatefulWidget {
  const SPHome({Key? key}) : super(key: key);

  @override
  State<SPHome> createState() => _SPHomeState();
}

class _SPHomeState extends State<SPHome> {
  @override
  void initState() {
    final cubit = BlocProvider.of<AppBloc>(context);
    cubit.getAllProviderUnits();
    cubit.getProviderTrips();
    cubit.getAllBanks();
    cubit.getFinancialSummary();
    cubit.getRatingSummary();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Image.asset(ImageManager.logoWithTitleHWhite,height: 40,),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationsScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.notifications,size: 20,),
            ),
          )
        ],
      ),

      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<AppBloc>(context);
          return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(

                    children: [
                      // SizedBox(height: 20),
                      SizedBox(
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  context.push(ScreenName.financialTransactions);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorManager.orangeColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        children: [
                                          Image.asset(ImageManager.moneyTransactions,width: 20,),
                                          SizedBox(height: 10),
                                          Text('المعاملات المالية',style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeightManager.medium,
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  context.push(ScreenName.accountSummary);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorManager.orangeColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        children: [
                                          Image.asset(ImageManager.accountSummary,width: 20,),
                                          SizedBox(height: 10),
                                          Text('ملخص الحسابات',style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeightManager.medium,
                                          ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SPMomeItem(title: 'آخر الحجوزات', content:(cubit.providerTrips == null || cubit.providerTrips!.upcoming.isEmpty)? Center(
                        child: InkWell(
                          onTap: (){
                            print(cubit.providerTrips!.upcoming);
                          },
                          child: Text('لا يوجد لديك حجوزات قادمة',style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w500,
                          ),),
                        ),
                      ):  Column(
                        children: [
                          for(int index = 0;index <cubit.providerTrips!.upcoming.length;index++)
                          Padding(
                            padding:  EdgeInsets.only(bottom: cubit.providerTrips!.upcoming.length-1 == index?0.0: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.withOpacity(0.2))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('رقم الحجز',style: TextStyle(
                                              fontWeight: FontWeightManager.medium,
                                            ),),
                                            SizedBox(width: 10,),
                                            Text('#${cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].id}',style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                                fontSize: 16
                                            ),),
                                            Spacer(),
                                            Text('الوحدة',style: TextStyle(
                                              fontWeight: FontWeightManager.medium,
                                            ),),
                                            SizedBox(width: 10,),
                                            Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.name.toString()??'',style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              fontSize: 16
                                            ),),
                                          ],
                                        ),
                                        const SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(DateFormat('hh:mm a').format(DateTime(2023,1,1,int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.arrivalTime!.split(':').first),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.arrivalTime!.split(':').last))),style: TextStyle(
                                                  // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.arrivalTime??'',style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeightManager.medium,
                                                    color: Colors.grey,
                                                  ),),
                                                  SizedBox(height: 10,),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(DateFormat("EE, MMM d, yyyy").format(DateTime.parse(DateTime(int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime.split('-')[2]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime.split('-')[1]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime.split('-')[0]),).toString())),style: TextStyle(
                                                      // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime??'',style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeightManager.medium,
                                                        color: Colors.grey,
                                                      ),maxLines: 1,),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(DateFormat('hh:mm a').format(DateTime(2023,1,1,int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.leavingTime!.split(':').first),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.leavingTime!.split(':').last))),style: TextStyle(
                                                  // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.leavingTime??'',style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeightManager.medium,
                                                    color: Colors.grey,
                                                  ),),
                                                  SizedBox(height: 10,),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(DateFormat("EE, MMM d, yyyy").format(DateTime.parse(DateTime(int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime.split('-')[2]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime.split('-')[1]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime.split('-')[0]),).toString())),style: TextStyle(

                                                      // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime??'',style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeightManager.medium,
                                                        color: Colors.grey,

                                                      ),maxLines: 1,),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      SPMomeItem(title: 'الضيوف القادمين', content:(cubit.providerTrips == null || cubit.providerTrips!.upcoming.isEmpty)? Center(
                        child: Text('لا يوجد ضيوف قادمين',
                            style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ):  Column(
                        children: [
                          for(int index = 0;index <cubit.providerTrips!.upcoming.length;index++)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('رقم الحجز',style: TextStyle(
                                            fontWeight: FontWeightManager.medium,
                                          ),),
                                          SizedBox(width: 10,),
                                          Text('#${cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].id}',style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              fontSize: 16
                                          ),),
                                          Spacer(),
                                          Text('الوحدة',style: TextStyle(
                                            fontWeight: FontWeightManager.medium,
                                          ),),
                                          SizedBox(width: 10,),
                                          Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.name.toString()??'',style: TextStyle(
                                              fontWeight: FontWeightManager.bold,
                                              fontSize: 16
                                          ),),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey.withOpacity(0.2))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text('اسم الضيف',style: TextStyle(
                                                fontWeight: FontWeightManager.medium,
                                              ),),
                                              SizedBox(width: 10,),
                                              Text('${cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].user.name}',style: TextStyle(
                                                  fontWeight: FontWeightManager.bold,
                                                  fontSize: 16
                                              ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey.withOpacity(0.2))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text('عدد الليالي',style: TextStyle(
                                                fontWeight: FontWeightManager.medium,
                                              ),),
                                              SizedBox(width: 10,),
                                              Text('${(double.parse(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].subtotal??"0.0")/double.parse(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.price!.others??"0.0")).toStringAsFixed(0)}',style: TextStyle(
                                                  fontWeight: FontWeightManager.bold,
                                                  fontSize: 16
                                              ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(DateFormat('hh:mm a').format(DateTime(2023,1,1,int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.arrivalTime!.split(':').first),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.arrivalTime!.split(':').last))),style: TextStyle(
                                                  // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.arrivalTime??'',style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeightManager.medium,
                                                  color: Colors.grey,
                                                ),),
                                                SizedBox(height: 10,),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Center(
                                                    child: Text(DateFormat("EE, MMM d, yyyy").format(DateTime.parse(DateTime(int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime.split('-')[2]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime.split('-')[1]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime.split('-')[0]),).toString())),style: TextStyle(
                                                      // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].arrivalDateTime??'',style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeightManager.medium,
                                                      color: Colors.grey,
                                                    ),maxLines: 1,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(height: 50,width: 2,color: Colors.grey.withOpacity(0.2),),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(DateFormat('hh:mm a').format(DateTime(2023,1,1,int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.leavingTime!.split(':').first),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.leavingTime!.split(':').last))),style: TextStyle(
                                                  // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].unit.leavingTime??'',style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeightManager.medium,
                                                  color: Colors.grey,
                                                ),),
                                                SizedBox(height: 10,),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Center(
                                                    child: Text(DateFormat("EE, MMM d, yyyy").format(DateTime.parse(DateTime(int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime.split('-')[2]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime.split('-')[1]),int.parse(cubit.providerTrips!.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime.split('-')[0]),).toString())),style: TextStyle(

                                                      // Text(cubit.providerTrips?.upcoming[cubit.providerTrips!.upcoming.length-index-1].leavingDateTime??'',style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeightManager.medium,
                                                      color: Colors.grey,

                                                    ),maxLines: 1,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Divider(thickness: 1.5,),
                                SizedBox(height: 10,),
                              ],
                            ),
                        ],
                      ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SPMomeItem(title: 'آخر الحوالات', content:(cubit.providerTrips == null || cubit.providerTrips!.upcoming.isEmpty)? Center(
                        child: Text('لا يوجد لديك حوالات',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ):
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.2),),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('المبلغ',style: TextStyle(
                                fontWeight: FontWeightManager.bold,
                              ),),
                              SizedBox(width: 10,),
                              Text('ريال${cubit.providerTrips?.upcoming.first.total}',style: TextStyle(
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: 16
                              ),),
                              Spacer(),
                              Text('${cubit.providerTrips?.upcoming.first.unit.arrivalTime } ${cubit.providerTrips?.upcoming.first.arrivalDateTime}',style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ),
                      ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SPMomeItem(title: 'المبيعات', content: Center(child: Text('${(cubit.financialData.sales??0.0).toStringAsFixed(2)} ر.س',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),))),
                      SizedBox(
                        height: 20,
                      ),
                      SPMomeItem(title: 'استلام المبالغ المالية', content: Center(child: Text('${(cubit.financialData.netProfit??0.0).toStringAsFixed(2)} ر.س',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),),),
                      SizedBox(
                        height: 20,
                      ),
                      SPMomeItem(title: 'آخر التقييمات', content:
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.rates.length,
                          itemBuilder: (context,index)=>Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.withOpacity(0.2),),
                            borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text('رقم الوحدة',style: TextStyle(
                                      fontWeight: FontWeightManager.bold,
                                    ),),
                                    SizedBox(width: 10,),
                                    Text('#${cubit.rates[index].unitId}',style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        fontSize: 16
                                    ),),
                                    Spacer(),
                                    Text(cubit.rates[index].createdAt!.split(' ').first,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  ],
                                ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                for (int i = 0; i < 5; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.star,
                                        color: ((i+1)>cubit.rates[index].rating!)?Colors.grey:ColorManager.yellowColor,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
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
                                  ]
                                ),
                            ),




                          ],
                        ),
                      ),
                          ))
                      ),

                    ],
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}

class SPMomeItem extends StatelessWidget {
  const SPMomeItem({Key? key,required this.title, required this.content}) : super(key: key);
  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: _decoration,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(txt: title),

              SizedBox(
                height: 20,
              ),
              content,
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
  }
}



BoxDecoration _decoration = BoxDecoration(
  color: ColorManager.whiteColor,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.1),
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
