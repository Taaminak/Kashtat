import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Cubit/AuthCubit.dart';
import 'package:kashtat/Core/Cubit/AuthState.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/constants/APIsManager.dart';
import '../../Core/constants/RoutesManager.dart';
import '../../Core/models/AuthModels/LoginSuccess.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.isMainScreen = true}) : super(key: key);
  final bool isMainScreen;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).viewPadding.top, horizontal: 17),
        child: SingleChildScrollView(
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
              // const SizedBox(height: 30),
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
                      offset: Offset(0, 0), // changes position of shadow
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
                            LocaleKeys.login.tr().capitalize(),
                            style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s36,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () {
                                context.pop(['register']);
                              },
                              child: Text(
                                LocaleKeys.new_registration.tr().capitalize(),
                                style: TextStyle(
                                  color: const Color(0xffE8470A),
                                  fontSize: FontSize.s14,
                                ),
                              ))
                        ],
                      ),
                      Text(
                        LocaleKeys.welcome_back_enter_your_mobile_number
                            .tr()
                            .capitalize(),
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
                                      fontWeight: FontWeightManager.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontWeight: FontWeightManager.bold,
                                        fontFamily:
                                            GoogleFonts.lato().fontFamily,
                                        fontSize: FontSize.s14),
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
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).viewInsets.bottom != 0.0
                                  ? 50
                                  : 100),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) async {
                          if (state is LoginSuccess) {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString('phone', controller.text);
                            Navigator.pop(context, ["otp"]);
                          }
                          if (state is LoginFailed) {
                            final snackBar = SnackBar(
                              content: Text(state.msg.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        builder: (context, state) {
                          return KButton(
                            onTap: () {
                              if (controller.text.length < 8) {
                                return;
                              }
                              final authCubit =
                                  BlocProvider.of<AuthBloc>(context);
                              authCubit.login(phone: controller.text);
                            },
                            title: LocaleKeys.continue_.tr().capitalize(),
                            width: size.width,
                            paddingV: 13,
                            isLoading: state is LoginLoadingState,
                          );
                        },
                      ),
                      SizedBox(
                          height:
                              MediaQuery.of(context).viewInsets.bottom != 0.0
                                  ? 50
                                  : 0),
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
