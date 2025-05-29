import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import 'dart:ui' as ui;

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Core/Cubit/AuthCubit.dart';
import '../../Core/Cubit/AuthState.dart';
import '../../Core/constants/APIsManager.dart';
import '../../Core/constants/RoutesManager.dart';
import '../Login Screen/LoginScreen.dart';
import '../Widgets/kButton.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, this.isMainScreen = true}) : super(key: key);
  final bool isMainScreen;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool checked = false;
  String phone = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    checkGuestUser();
    super.initState();
  }

  checkGuestUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone') ?? '';
    if (phone.contains('123456789')) {
      String code = prefs.getString('guest_otp') ?? '';
      controller.text = code;
    }
    setState(() {});
  }

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
              const SizedBox(height: 30),

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
              // const SizedBox(height: 20),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 35),
                      Text(
                        LocaleKeys.enter_otp.tr(),
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s36,
                        ),
                      ),
                      Text(
                        LocaleKeys.the_code_has_been_sent_to_your_phone.tr(),
                        style: TextStyle(
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: SizedBox(
                          width: size.width / 1.2,
                          child: PinCodeTextField(
                            controller: controller,
                            length: 6,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              activeColor: Colors.grey.withOpacity(0.2),
                              selectedColor:
                                  const Color(0xffE8470A).withOpacity(0.2),
                              selectedFillColor: Colors.white,
                              disabledColor: Colors.white,
                              activeFillColor: Colors.white,
                              inactiveColor: Colors.grey.withOpacity(0.2),
                              inactiveFillColor: Colors.white,
                              shape: PinCodeFieldShape.box,
                              fieldWidth: 40,
                              fieldHeight: 40,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enableActiveFill: true,
                            animationDuration: Duration(milliseconds: 300),
                            onChanged: (value) {
                              print(controller.text);
                              setState(() {
                                // currentText = value;
                              });
                            },
                            appContext: context,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) async {
                          if (state is OtpSuccess) {
                            Navigator.pop(context, [true]);
                          }
                          if (state is OtpFailed) {
                            final snackBar = SnackBar(
                              content: Text(state.msg.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        builder: (context, state) {
                          return KButton(
                            onTap: () async {
                              if (controller.text.length < 6) {
                                return;
                              }

                              final authCubit =
                                  BlocProvider.of<AuthBloc>(context);
                              authCubit.otpLogin(
                                  phone: phone, otpCode: controller.text);
                            },
                            title: LocaleKeys.login.tr().capitalize(),
                            width: size.width,
                            paddingV: 13,
                            isLoading: state is OtpLoadingState,
                          );
                        },
                      ),
                      const SizedBox(height: 15),
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
