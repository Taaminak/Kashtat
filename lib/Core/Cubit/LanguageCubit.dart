// import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:kashtat/Core/utils/language_manager.dart';

import 'LanguageState.dart';

class LanguageBloc extends Cubit<LanguageState> {
  LanguageBloc() : super(InitState());
  String _lang = 'en';

  Future<void> setLanguage(BuildContext context, Locale lang) async {
    context.setLocale(lang);
    _lang = context.locale.languageCode;
    await LanguageManager.saveLanguage(_lang);
    print("Language: $_lang");
    print("Language: context.locale: ${context.locale}");
    emit(LanguageChangedSuccess());
  }

  String get language => _lang;
}
