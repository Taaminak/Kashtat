
// import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'LanguageState.dart';

class LanguageBloc extends Cubit<LanguageState> {
  LanguageBloc(): super(InitState());
  String _lang = 'en';

  setLanguage(BuildContext context, Locale lang){
    context.setLocale(lang);
    _lang = context.locale.languageCode;
    emit(LanguageChangedSuccess());
  }

  String get language => _lang;

}
