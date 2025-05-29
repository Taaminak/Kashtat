import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Core/Extentions/extention.dart';
import '../../Core/Cubit/LanguageCubit.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';
import '../../translations/locale_keys.g.dart';
import 'dart:ui' as ui;

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LanguageBloc>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              right: context.locale.languageCode == 'en' ? 0 : null,
              left: context.locale.languageCode == 'ar' ? 0 : null,
              top: 0,
              child: Image.asset(
                ImageManager.logoHalfGrey,
                height: size.height / 2.5,
              ).transformWidget(context),
            ),
            Positioned.fill(
              child: Container(
                // color: ColorManager.whiteColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: MediaQuery.of(context).viewPadding.top + 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Text(
                        LocaleKeys.change_language.tr().capitalize(),
                        style: TextStyle(
                          fontSize: FontSize.s34,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff482383),
                                  ),
                                  onPressed: () async {
                                    await cubit.setLanguage(
                                        context, const Locale('ar'));
                                    context.pop();
                                  },
                                  child: Text(
                                    LocaleKeys.arabic.tr(),
                                    style: TextStyle(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeightManager.medium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff482383),
                                  ),
                                  onPressed: () async {
                                    await cubit.setLanguage(
                                        context, const Locale('en'));
                                    context.pop();
                                  },
                                  child: Text(
                                    LocaleKeys.english.tr(),
                                    style: TextStyle(
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeightManager.medium,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
