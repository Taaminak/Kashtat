import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Core/constants/RoutesManager.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int selectedWidgetIndex = 0;

  List<Widget> onBoardingWidget = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.mainlyBlueColor,
      body: AnimationLimiter(
        child: AnimationConfiguration.staggeredList(
          position: selectedWidgetIndex,
          duration: const Duration(milliseconds: 800),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: viewWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Widget viewWidget() => SizedBox(
        key: ValueKey(selectedWidgetIndex),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              getIntroData()[selectedWidgetIndex].img,
              fit: BoxFit.cover,
            )),
            Positioned.fill(
                child: Image.asset(
              "assets/images/shadow.png",
              fit: BoxFit.cover,
            )),
            Positioned(
                left: -10,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image.asset(
                    "assets/images/iconHalf.png",
                    fit: BoxFit.contain,
                    width: 10,
                    height: 50,
                  ),
                )),
            Positioned.fill(
                child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            )),
            Positioned.fill(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 100,
                ),
                AnimationLimiter(
                  child: AnimationConfiguration.staggeredList(
                    duration: const Duration(milliseconds: 800),
                    position: 0,
                    child: SlideAnimation(
                      verticalOffset: -50.0,
                      horizontalOffset: 200.0,
                      child: SlideAnimation(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 150),
                                child: Text(
                                  getIntroData()[selectedWidgetIndex].text,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSize.s26,
                                      fontWeight: FontWeightManager.bold,
                                      height: 1.5),
                                      maxLines: 5,
                                          
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    KButton(
                      onTap: () {
                        if (selectedWidgetIndex < 2) {
                          setState(() {
                            selectedWidgetIndex++;
                          });
                        } else {
                          context.go(ScreenName.dashboard);
                        }
                      },
                      title: LocaleKeys.next.tr(),
                      clr: Colors.transparent,
                      txtClr: ColorManager.whiteColor,
                      hasBorder: true,
                      paddingV: 15,
                    ),
                    KButton(
                      onTap: () {
                        context.go(ScreenName.dashboard);
                      },
                      title: LocaleKeys.skip.tr(),
                      clr: Colors.white,
                      txtClr: ColorManager.mainlyBlueColor,
                      paddingV: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: selectedWidgetIndex == 2
                                ? ColorManager.whiteColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: selectedWidgetIndex == 1
                                ? ColorManager.whiteColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: selectedWidgetIndex == 0
                                ? ColorManager.whiteColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            )),
          ],
        ),
      );
}

List<IntroModel> getIntroData() => [
      IntroModel(
          text: LocaleKeys.onboarding_security.tr(),
          img: ImageManager.onBoarding1),
      IntroModel(
          text: LocaleKeys.onboarding_experience.tr(),
          img: ImageManager.onBoarding2),
      IntroModel(
          text: LocaleKeys.onboarding_explore.tr(),
          img: ImageManager.onBoarding3),
    ];

class IntroModel {
  final String img;
  final String text;
  IntroModel({
    required this.text,
    required this.img,
  });
}
