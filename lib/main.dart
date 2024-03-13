import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/Cubit/observer.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/RoutesManager.dart';
import 'package:kashtat/translations/codegen_loader.g.dart';

import 'Core/Cubit/AppState.dart';
import 'Core/Cubit/AuthCubit.dart';
import 'Core/Cubit/LanguageCubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterNativeSplash.remove();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        startLocale: const Locale('ar'),
        assetLoader: const CodegenLoader(),
        // supportedLocales: const [Locale('en'), Locale('ar')],
        // path: 'assets/translations',
        // fallbackLocale: const Locale('ar'),
        child: const MyApp()
    ),
  );

}

/// The main app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (BuildContext context, child) =>
          MultiBlocProvider(
            providers: [
              BlocProvider<LanguageBloc>(
                create: (BuildContext context) => LanguageBloc(),
              ),
              BlocProvider<AuthBloc>(
                create: (BuildContext context) => AuthBloc(),
              ),
              BlocProvider<AppBloc>(
                create: (BuildContext context) => AppBloc(),
              ),
            ],
            child: MaterialApp.router(
              title: 'KASHTAT',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: Locale('ar'),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.light(primary: ColorManager.mainlyBlueColor),
                  fontFamily: FontConstants.fontFamilyAR,
              ),
              routerConfig: RoutesManager.router,
            ),
          ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider<LanguageBloc>(
    //       create: (BuildContext context) => LanguageBloc(),
    //     ),
    //     BlocProvider<AuthBloc>(
    //       create: (BuildContext context) => AuthBloc(),
    //     ),
    //     BlocProvider<AppBloc>(
    //       create: (BuildContext context) => AppBloc(),
    //     ),
    //   ],
    //   child: MaterialApp.router(
    //     title: 'KASHTAT',
    //     localizationsDelegates: context.localizationDelegates,
    //     supportedLocales: context.supportedLocales,
    //     locale: context.locale,
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //       fontFamily: FontConstants.fontFamilyAR
    //     ),
    //     routerConfig: RoutesManager.router,
    //   ),
    // );
  }
}

