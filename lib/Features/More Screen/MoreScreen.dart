import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AppState.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Core/constants/RoutesManager.dart';
import 'package:kashtat/Features/Login%20Screen/LoginScreen.dart';
import 'package:kashtat/Features/More%20Screen/Widgets/ItemWidget.dart';
import 'package:kashtat/Features/My%20Account%20Screen/MyAccountScreen.dart';
import 'package:kashtat/Features/OTP%20Screen/OTPScreen.dart';
import 'package:kashtat/Features/Register%20Screen/RegisterScreen.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/constants/APIsManager.dart';
import '../Coupon Screen/screen/CouponScreen.dart';
import '../Report Screen/SendReportScreen.dart';
import '../Service Provider/Add New Unit/AddNewUnitScreen.dart';

import 'package:url_launcher/url_launcher.dart';
class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key, this.fromDashboard = false}) : super(key: key);
  final bool fromDashboard;

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {


  Future<bool> deleteAccount()async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
      print(token);
      final response = await Dio().delete('${APIsManager.baseURL}/api/delete-account',options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      )).onError((error, stackTrace){
        debugPrint(error.toString());
        return Future.error(error!);
      });
      print(response);
      if(response.statusCode ==200||response.statusCode ==201){

      return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
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
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: MediaQuery.of(context).viewPadding.top + 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!widget.fromDashboard)
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
                    if (!isLoggedIn)
                      Text(
                        'الحساب',
                        style: TextStyle(
                          fontSize: FontSize.s34,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    if (isLoggedIn)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'مرحبا  $name',
                              style: TextStyle(
                                fontSize: FontSize.s26,
                                fontWeight: FontWeightManager.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              // if(cubit.userType == UserType.isNormal){
                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewUnitScreen()));
                              // }else{
                              //   cubit.getWalletLogs();
                                cubit.changeUserType(cubit.userType != UserType.isNormal?UserType.isNormal:UserType.isProvider);
                              // }



                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.mainlyBlueColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.refresh_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Text(
                                      cubit.userType == UserType.isNormal?'تحويل الي كشتات الاعمال':'تحويل الي كشتات',
                                      style: TextStyle(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeightManager.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    const SizedBox(height: 10),
                    if (isLoggedIn)
                      Container(
                        decoration: BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(15.0),
                          child:cubit.userType == UserType.isNormal? Row(
                            children: [
                              Expanded(child: Column(children: [
                                Text("عدد الحجوزات",style: TextStyle(
                                  fontWeight: FontWeightManager.medium
                                ),),
                                const SizedBox(height: 10),
                                Text('${cubit.userProfile?.reservationsCount??0}',style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                              ],),),
                              Expanded(child: Column(children: [
                                Text("رصيد المحفظة",style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                                const SizedBox(height: 10),
                                Text('${(cubit.userProfile?.wallet??0).toStringAsFixed(2)} ر.س',style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                              ],),),
                            ],
                          ):Row(
                            children: [
                              Expanded(child: Column(children: [
                                Text("الوحدات",style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                                const SizedBox(height: 10),
                                Text('${cubit.userProfile?.unitsCount??0}',style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                              ],),),
                              Expanded(child: Column(children: [
                                Text("الحجوزات",style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                                const SizedBox(height: 10),
                                Text('${cubit.userProfile?.reservationsCount??0}',style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                              ],),),
                              Expanded(child: Column(children: [
                                Text("المبيعات",style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                                const SizedBox(height: 10),
                                Text('${(cubit.userProfile?.totalSales??0).toStringAsFixed(2)}',style: TextStyle(
                                    fontWeight: FontWeightManager.medium
                                ),),
                              ],),),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    Expanded(child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorManager.whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    if (!isLoggedIn)
                                      MoreItemWidget(
                                          title: LocaleKeys.login.tr(),
                                          img: ImageManager.logIn,
                                          onTap: () {
                                            userLogin(context);
                                          }),
                                    if (isLoggedIn)
                                      MoreItemWidget(
                                          title:cubit.userType == UserType.isNormal? LocaleKeys.my_account.tr():"الملف الشخصي",
                                          img: ImageManager.user,
                                          onTap: () {
                                            // context.push(ScreenName.myAccount);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyAccountScreen(avatar: avatar,name: name,phone: phone,userType: type,))).then((value) => isLogged());
                                          }),
                                    if (isLoggedIn)
                                      if(cubit.userType == UserType.isProvider)
                                        MoreItemWidget(
                                            title: "القييمات",
                                            img: "assets/icons/UI icon-star-light@3x.png",
                                            onTap: () {
                                              context.push(ScreenName.rateScreen);
                                            }),
                                    if (isLoggedIn)
                                      if(cubit.userType == UserType.isProvider)
                                        MoreItemWidget(
                                            title: 'المعاملات المالية',
                                            img: "assets/icons/Group 6643@3x.png",
                                            onTap: () {
                                              context.push(ScreenName.financialTransactions);
                                            }),
                                    // if (isLoggedIn)
                                    //   if(cubit.userType == UserType.isProvider)
                                    //     MoreItemWidget(
                                    //         title: 'الاسعار',
                                    //         img: "assets/icons/UI icon-dollar-light@2x.png",
                                    //         onTap: () {
                                    //           // context.push(ScreenName.pricingScreen);
                                    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>PricingScreen(isCreateUnit: false,)));
                                    //         }),
                                    // if (isLoggedIn)
                                    //   if(cubit.userType == UserType.isProvider)
                                    //     MoreItemWidget(
                                    //         title: 'الاعدادات',
                                    //         img: "assets/icons/UI icon-settings-light@3x.png",
                                    //         onTap: () {
                                    //           context.push(ScreenName.serviceProviderSettings);
                                    //         }),
                                    // if (isLoggedIn)
                                    //   if(cubit.userType != UserType.isProvider)
                                    //   MoreItemWidget(
                                    //       title: "وسائل الدفع",
                                    //       img: ImageManager.pay,
                                    //       onTap: () {
                                    //         context.push(ScreenName.cards);
                                    //       }),
                                    if (isLoggedIn)
                                      if(cubit.userType != UserType.isProvider)
                                      MoreItemWidget(
                                          title: 'سجل المحفظة',
                                          img: ImageManager.credit,
                                          onTap: () {
                                            context.push(ScreenName.walletRecords);
                                          }),


                                    if (isLoggedIn)
                                      MoreItemWidget(
                                          title: 'البلاغات والشكاوي',
                                          img: "assets/icons/UI icon-clipboard-light@3x.png",
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SendReportScreen()));
                                            // context.push(ScreenName.reportsAndComplaints);
                                          }),

                                    if (isLoggedIn)
                                      if(cubit.userType == UserType.isProvider)
                                        MoreItemWidget(
                                            title: 'اكواد الخصم',
                                            img: "assets/icons/UI icon-ticket-light@3x.png",
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CouponScreen()));
                                            }),

                                    if (isLoggedIn)
                                      if(cubit.userType == UserType.isProvider)
                                        MoreItemWidget(
                                            title: "الفواتير وكشوف الحسابات",
                                            img: "assets/icons/UI icon-clipboard-light@3x.png",
                                            onTap: () {
                                              context.push(ScreenName.accountReports);
                                            }),

                                    if (isLoggedIn)
                                      if(cubit.userType == UserType.isProvider)
                                        MoreItemWidget(
                                            title: "اتفاقية الاستخدام",
                                            img: "assets/icons/Group 6642@3x.png",
                                            onTap: () {
                                              context.push(ScreenName.usageAgreement);
                                            }),

                                    if (isLoggedIn)
                                      if(cubit.userType != UserType.isProvider)
                                      MoreItemWidget(
                                          title: "قيمنا",
                                          img: ImageManager.finger,
                                          onTap: () {
                                            launchURL('https://apps.apple.com/us/app/kashtat/id6461691005');
                                          }),

                                    // if (isLoggedIn)
                                      if(cubit.userType != UserType.isProvider)
                                      MoreItemWidget(
                                        title: "سجل معنا ( مزود خدمة )",
                                        img: ImageManager.aboutUs,
                                        onTap: () {
                                          if(!isLoggedIn){
                                            userLogin(context);
                                            return;
                                          }

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewUnitScreen()));
                                        },
                                        textColor: ColorManager.orangeColor,
                                      ),
                                    // MoreItemWidget(title: LocaleKeys.about_us.tr(), img: ImageManager.aboutUs, onTap: (){}),

                                    MoreItemWidget(
                                        title: LocaleKeys.privacy_policy.tr(),
                                        img: ImageManager.privacy,
                                        onTap: () {

                                          context.push(ScreenName.privacyPolicy);
                                        }),

                                    MoreItemWidget(
                                        title: LocaleKeys.contact_us.tr(),
                                        img: ImageManager.messages,
                                        onTap: () {
                                          context.push(ScreenName.contactUs);
                                        }),
                                    if (isLoggedIn)
                                      if(cubit.userType != UserType.isProvider)
                                      MoreItemWidget(
                                          title: 'ادع اصدقائك',
                                          img: ImageManager.share,
                                          onTap: () {
                                            shareKashtatToAnyApp();
                                          }),
                                    MoreItemWidget(
                                        title: LocaleKeys.change_language.tr(),
                                        img: ImageManager.earth,
                                        onTap: () {
                                          // context.push(ScreenName.language);
                                        }),
                                    // if (isLoggedIn)
                                    //   MoreItemWidget(
                                    //     title: "حذف الحساب",
                                    //     img: ImageManager.logOut,
                                    //     textColor: ColorManager.orangeColor,
                                    //     onTap: () async{
                                    //       showAlertDialog(context);
                                    //     },
                                    //   ),

                                    if (isLoggedIn)
                                      MoreItemWidget(
                                        title: "تسجيل الخروج",
                                        textColor: ColorManager.orangeColor,
                                        img: ImageManager.logOut,
                                        onTap: () async {
                                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                                          await prefs.setBool('isLoggedIn', false);

                                          cubit.changeUserType(UserType.isNormal);
                                          isLogged();
                                          // context.go(ScreenName.splash);
                                          // setState(() {
                                          //   isLoggedIn = false;
                                          // });
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (isLoggedIn)
                            SizedBox(height: 20,),
                          if (isLoggedIn)
                            Align(
                              alignment: Alignment.center,
                              child: KButton(
                                onTap: (){
                                  showAlertDialog(context);
                                },
                                title: 'حذف الحساب',
                                width: MediaQuery.of(context).size.width-100,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: SizedBox(
                              width: size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _launchUrl("https://instagram.com/kashtat2030?igshid=MzRlODBiNWFlZA==");
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.instagram,
                                      color: ColorManager.darkGreyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  InkWell(
                                    onTap: (){
                                      _launchUrl("https://www.linkedin.com/company/kashtat/");
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.linkedinIn,
                                      color: ColorManager.darkGreyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 30),

                                  InkWell(
                                    onTap: (){
                                      _launchUrl("https://x.com/kashtat2030?s=21&t=JGR4v_bQJQPW__oHix8ExA");
                                    },
                                    child: Image.asset(ImageManager.x,width: 18,
                                      color: ColorManager.darkGreyColor,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
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
  bool isLoggedIn = false;

  @override
  void initState() {
    isLogged();
    BlocProvider.of<AppBloc>(context).getUserProfile();
    BlocProvider.of<AppBloc>(context).getAllProviderUnits();
    super.initState();
  }
  String name = '';
  String id = '';
  String phone = '';
  String avatar = '';
  String type = '';

  Future<void> isLogged()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false ;
      name = prefs.getString('name') ?? '' ;
      id = prefs.getString('id') ?? '' ;
      phone = prefs.getString('phone') ?? '' ;
      avatar = prefs.getString('avatar') ?? '' ;
      type = prefs.getString('role') ?? '' ;

    });
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

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء",style: TextStyle(
        color: ColorManager.mainlyBlueColor,
      ),),
      onPressed:  () {
        context.pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("موافق",style: TextStyle(
        color: ColorManager.redColor,
      ),),
      onPressed:  () async{
        deleteAccount().then((done)async{
          if(done){
            final snackBar = SnackBar(
              content: Text("تم حذف الحساب"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.pop();
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', false);
            context.go(ScreenName.splash);
          }else{
            final snackBar = SnackBar(
              content: Text("لم يتم حذف الحساب"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.pop();
          }
        });
        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("حذف الحساب",style: TextStyle(
        color: ColorManager.redColor,
        fontSize: FontSize.s20,
        fontWeight: FontWeightManager.bold,
      ),),
      content: Text("سوف يتم حذف حسابك. هل تريد تأكيد الحذف؟",style: TextStyle(
        color: ColorManager.darkerGreyColor,
      ),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}