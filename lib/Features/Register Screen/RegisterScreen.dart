import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import '../../Core/constants/APIsManager.dart';
import '../../Core/constants/RoutesManager.dart';
import '../../Core/models/AuthModels/LoginSuccess.dart';
import '../../Core/models/AuthModels/RegistrationSuccess.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, this.isMainScreen = true}) : super(key: key);
  final bool isMainScreen;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool checked = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<void> login()async{
    try{
      print('${APIsManager.baseURL}/api/register');
      print({
        "phone": "+966${phoneController.text}",
        "name": nameController.text,
      });

      final response = await Dio().post('${APIsManager.baseURL}/api/register', data: {
        "phone": "+966${phoneController.text}",
        "name": nameController.text,
        "role":'normal',
      });
      print(response);
      if(response.statusCode ==200){
        final decodedData = json.decode(response.toString());
        RegistrationModel data = RegistrationModel.fromJson(decodedData);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('phone', phoneController.text);
        // final snackBar = SnackBar(
        //   content: Text(data.data.toString()),
        //   duration: const Duration(seconds: 10),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        context.pop(["otp"]);
      }
    }catch(e){
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).viewPadding.top, horizontal: 17),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // if(!widget.isMainScreen)
              const SizedBox(height: 30),

              // if(!widget.isMainScreen)
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: 20,
                      // color: Colors.white,
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 10),
              Image.asset(
                ImageManager.logoWithTitleHColored,
                width: size.width / 2.2,
              ),
              const SizedBox(height: 45),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            LocaleKeys.register.tr().capitalize(),
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s36,

                            ),
                          ),
                          const Spacer(),
                          // TextButton(
                          //     onPressed: () {
                          //       context.go(ScreenName.login);
                          //     },
                          //     child: Text(
                          //       LocaleKeys.login.tr().capitalize(),
                          //       style: TextStyle(
                          //         color: const Color(0xffE8470A),
                          //         fontSize: FontSize.s14,
                          //       ),
                          //     ))
                        ],
                      ),
                      Text(
                        LocaleKeys.create_your_account_to_benefit_from_Kashtat_services.tr().capitalize(),
                        style: TextStyle(
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xffDDDDDD), width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageManager.ksaLogo,
                                  width: 20,
                                ),
                                const Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 5, right: 5),
                                  child: Text(
                                    '+966',
                                    style: TextStyle(
                                        fontWeight: FontWeightManager.bold),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                    style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        fontFamily: GoogleFonts.lato().fontFamily,
                                        fontSize: FontSize.s14
                                    ),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        fillColor: Colors.white70,
                                        contentPadding: EdgeInsets.zero),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 17),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffDDDDDD), width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: nameController,
                            style: TextStyle(
                                fontWeight: FontWeightManager.bold,
                                fontFamily: GoogleFonts.lato().fontFamily,
                                fontSize: FontSize.s14
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: FontSize.s14),
                                fillColor: Colors.white70,
                                hintText: LocaleKeys.name.tr().capitalize(),
                                contentPadding: EdgeInsets.zero),
                          ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            activeColor: const Color(0xffE8470A),
                            value: checked,
                            onChanged: (value) {
                              setState(() {
                                checked = value ?? false;
                              });
                            },
                            side: const BorderSide(color: Color(0xffE8470A)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                LocaleKeys.i_have_read_and_agree_to_the_terms_and_conditions_of_Kashtat.tr(),
                                style: TextStyle(
                                    color: const Color(0xff482383),
                                    fontWeight: FontWeightManager.bold,
                                    fontSize: FontSize.s14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 17),
                      SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xff482383),
                            ),
                            onPressed: () {

                              if(checked){
                                login();
                              }else{
                                final snackBar = SnackBar(
                                  content: Text('يجب الموافقة علي الشروط اولا'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              // context.go(ScreenName.dashboard);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(LocaleKeys.register.tr().capitalize()),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
