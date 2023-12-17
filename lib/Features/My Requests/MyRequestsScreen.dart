import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Features/My%20Requests/Widgets/RequestItemWidget.dart';
import 'package:kashtat/Features/Widgets/Loader.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';
import '../Login Screen/LoginScreen.dart';
import '../OTP Screen/OTPScreen.dart';
import '../Register Screen/RegisterScreen.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({Key? key, this.fromDashboard = false})
      : super(key: key);
  final bool fromDashboard;

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
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
      cubit.getUserTrips();
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AppBloc, AppState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return state is LoadingUserTripsState? Center(child: Loader(),): SizedBox(
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
            ),!isLoggedIn? Align(
              alignment: Alignment.center,
              child: KButton(onTap: (){
                userLogin(context);
              }, title: 'تسجيل الدخول',width: 200,paddingV: 15,),
            ):
            Positioned.fill(
              child:  Column(
                children: [

                  Padding(
                    padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: MediaQuery.of(context).viewPadding.top + 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!widget.fromDashboard)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                ImageManager.backIcon,
                                width: 10,
                              ),
                            ),
                          ),
                        const SizedBox(height: 40),
                        Text(
                          'حجوزاتي',
                          style: TextStyle(
                            fontSize: FontSize.s34,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        // const SizedBox(height: 20),
                        // Text(LocaleKeys.active_orders.tr(),style: TextStyle(
                        //   fontSize: FontSize.s17,
                        //   fontWeight: FontWeightManager.bold,
                        // ),),

                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorManager.darkGreyColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                MyRequestTab(
                                    title: 'القادمة',
                                    isActive: isNewRequests,
                                    onTap: () {
                                      setState(() {
                                        isNewRequests = true;
                                      });
                                    }),
                                MyRequestTab(
                                    title: 'السابقة',
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

                        if(isNewRequests)
                        const SizedBox(height: 20),
                        if(isNewRequests)
                        Text(
                          'حجزك المؤكد اليوم',
                          style: TextStyle(
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                ],
                    ),
                  ),
                  // if(isNewRequests)
                    const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 25.0,
                              right: 25.0,
                              top:  8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                if(cubit.userTrips!=null)
                                for(int i=0; i<(!isNewRequests?cubit.userTrips!.past.length:cubit.userTrips!.upcoming.length); i++)
                                RequestItemWidget(activeRequests: true,reservated:(!isNewRequests?cubit.userTrips!.past[i]:cubit.userTrips!.upcoming[i]) ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

class MyRequestTab extends StatelessWidget {
  const MyRequestTab({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color:
                isActive ? ColorManager.whiteColor : ColorManager.darkGreyColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: !isActive
                    ? ColorManager.whiteColor
                    : ColorManager.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
