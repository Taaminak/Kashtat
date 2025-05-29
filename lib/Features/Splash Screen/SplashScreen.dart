import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Core/constants/RoutesManager.dart';
import 'package:kashtat/Core/notification%20manager/NotificationManager.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/Cubit/LanguageCubit.dart';
import '../../Core/constants/FontManager.dart';
import '../Widgets/waves.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    NotificationsManager.setupNotifications(context);
    isLogged();
    super.initState();
  }

  bool isLoading = true;

  bool isLoggedIn = false;

  Future<void> isLogged() async {
    isLoading = true;
    final cubit = BlocProvider.of<AppBloc>(context, listen: false);
    await cubit.initAppData();
    setState(() {
      isLoggedIn = cubit.userProfile != null;
      isLoading = false;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (isLoggedIn) {
        context.go(ScreenName.dashboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            ImageManager.logoWithTitleV,
            width: size.width / 2.1,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 65,
          ),
          if (!isLoggedIn && !isLoading)
            Text(
              "اختر اللغة".capitalize(),
              style: TextStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.mainlyBlueColor,
              ),
            ),
          if (!isLoggedIn && !isLoading)
            // const SizedBox(height: 10),
            if (!isLoggedIn && !isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KButton(
                    onTap: () {
                      selectAndNavigate('ar');
                    },
                    title: 'عربي',
                    width: size.width / 2.5,
                    paddingV: 15,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  KButton(
                    onTap: () {
                      selectAndNavigate('en');
                    },
                    title: 'English',
                    width: size.width / 2.5,
                    paddingV: 15,
                  ),
                ],
              ),
          const WaveDemoHomePage(),
        ],
      ),
    );
  }

  selectAndNavigate(String lang) async {
    final cubit = BlocProvider.of<LanguageBloc>(context);
    // final bloc = BlocProvider.of<AppBloc>(context);
    // bloc.getAllCategories();
    await cubit.setLanguage(context, Locale(lang));
    if (isLoggedIn) {
      context.go(ScreenName.dashboard);
    } else {
      context.go(ScreenName.onBoarding);
    }
  }
}
