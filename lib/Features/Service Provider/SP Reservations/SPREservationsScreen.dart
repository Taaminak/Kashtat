import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/models/ReservationModel.dart';
import 'package:kashtat/Core/models/UnitModel.dart';
import 'package:kashtat/Core/models/UnitsModel.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Core/Cubit/AppCubit.dart';
import '../../../Core/Extentions/extention.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/FontManager.dart';
import '../../../Core/constants/ImageManager.dart';
import '../../Login Screen/LoginScreen.dart';
import '../../My Requests/MyRequestsScreen.dart';
import '../../My Requests/Widgets/RequestItemWidget.dart';
import 'package:intl/intl.dart';

import '../../OTP Screen/OTPScreen.dart';
import '../../Register Screen/RegisterScreen.dart';
import '../../Widgets/Loader.dart';

class SPReservations extends StatefulWidget {
  const SPReservations({Key? key}) : super(key: key);

  @override
  State<SPReservations> createState() => _SPReservationsState();
}

class _SPReservationsState extends State<SPReservations> {
  bool isNewRequests = true;

  @override
  void initState() {
    isLogged();
    super.initState();
  }

  bool isLoggedIn = false;


  Future<void> isLogged()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false ;
    });
    if(isLoggedIn){
      final cubit = BlocProvider.of<AppBloc>(context);
      cubit.getProviderTrips();
    }
  }
  userLogin(BuildContext context){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())).then((value){

      if(value == null){

      }
      else if(value[0] == 'otp'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen())).then((value){
          if(value == null){
            userLogin(context);
          }else{
            isLogged();
          }
        });
      }else if(value[0] == 'register'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen())).then((value){
          // registerActions(context, value );
          print('-----------------------------register--------------------');
          print(value);
          print('-------------------------------------------------');

          if(value == null){
            userLogin(context);
          }else if(value[0] == 'otp'){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen())).then((value){

              if(value == null){
                userLogin(context);
              }else{
                isLogged();
              }
            });
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text('الحجوزات',style: TextStyle(fontWeight: FontWeight.normal),),
        centerTitle: true,
        leading: SizedBox(),
        // actions: [
        //   InkWell(
        //     onTap: (){
        //       context.pop();
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: const FaIcon(FontAwesomeIcons.chevronLeft,size:20,color: Colors.white,),
        //     ),
        //   )
        // ],
      ),
      body: BlocConsumer<AppBloc, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return !isLoggedIn? Align(
      alignment: Alignment.center,
      child: KButton(onTap: (){
        userLogin(context);
      }, title: 'تسجيل الدخول',width: 200,paddingV: 15,),
    ):  state is LoadingProviderTripsState? Center(child: Loader(),):  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color: ColorManager.darkGreyColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        MyRequestTab(
                            title: 'الضيوف القادمين',
                            isActive: isNewRequests,
                            onTap: () {
                              setState(() {
                                isNewRequests = true;
                              });
                            }),
                        MyRequestTab(
                            title: 'آخر الحجوزات',
                            isActive: !isNewRequests,
                            onTap: () {
                              setState(() {
                                isNewRequests = false;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                if(cubit.providerTrips !=null)
                for(int i=0; i<(!isNewRequests?cubit.providerTrips!.past.length:cubit.providerTrips!.upcoming.length); i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: ContainerDecorated(
                    content: Column(
                      children: [

                        Row(
                          children: [
                            Text(
                              'رقم الوحدة',
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '#${!isNewRequests?cubit.providerTrips!.past[i].unit.id:cubit.providerTrips!.upcoming[i].unit.id}',
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'الوحدة',
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${!isNewRequests?cubit.providerTrips!.past[i].unit.name:cubit.providerTrips!.upcoming[i].unit.name}',
                              style: TextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            InternalAndExternalWidget(
                                title: "تفاصيل الدخول", img: ImageManager.logIn,reserved: !isNewRequests?cubit.providerTrips!.past[i]:cubit.providerTrips!.upcoming[i],),
                            Container(
                              color: Colors.grey,
                              height: 100,
                              width: 1,
                            ),
                            InternalAndExternalWidget(
                                title: "تفاصيل الخروج", img: ImageManager.logOut,reserved: !isNewRequests?cubit.providerTrips!.past[i]:cubit.providerTrips!.upcoming[i],isArrival: false),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withOpacity(0.2),
                            ),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text('اسم الضيف',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(!isNewRequests?cubit.providerTrips!.past[i].unit.provider?.name??'':cubit.providerTrips!.upcoming[i].unit.provider?.name??'',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withOpacity(0.2),
                            ),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text('عدد الليالي',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(getNumber(!isNewRequests?cubit.providerTrips!.past[i]:cubit.providerTrips!.upcoming[i]),
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withOpacity(0.2),
                            ),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text('القيمة المدفوعة',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text('${!isNewRequests?cubit.providerTrips!.past[i].total : cubit.providerTrips!.upcoming[i].total}',
                                  style: TextStyle(
                                    fontSize: FontSize.s16,
                                    fontWeight: FontWeightManager.medium,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            KButton(onTap: (){
                              String phone = !isNewRequests?cubit.providerTrips!.past[i].user.phone??'' : cubit.providerTrips!.upcoming[i].user.phone??'';
                              String url = "tel://${phone.substring(1)}";
                              launchURL(url);
                            }, title: 'التواصل',paddingV: 20,clr:ColorManager.greenColor,icon: Icons.phone),
                            KButton(onTap: (){}, title: 'الغاء الحجز',paddingV: 20,),
                          ],
                        ),
                      ],
                    ),
                  ),
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

String getNumber(ReservationModel trip){
  try{
    return true? ((num.parse(trip.leavingDateTime.substring(0,2))-num.parse(trip.arrivalDateTime.substring(0,2)))+1).toString(): DateTime.parse(trip.leavingDateTime).difference(DateTime.parse(trip.arrivalDateTime)).inDays.toString();

  }catch(e){
    return '';
  }
  return DateTime.parse(trip.leavingDateTime).difference(DateTime.parse(trip.arrivalDateTime)).inDays.toString();
  return '${num.parse(DateFormat('dd').format(DateTime.parse(trip.leavingDateTime)))-num.parse(DateFormat('dd').format(DateTime.parse(trip.arrivalDateTime)))}';
}