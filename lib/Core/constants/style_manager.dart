import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'FontManager.dart';

class StyleManager {
  static TextStyle _getTextStyle(
      double fontSize, FontWeight fontWeight, Color color) {
    return GoogleFonts.tajawal(
        fontWeight: fontWeight, fontSize: fontSize, color: color);
  }

  static TextStyle getRegularStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  static TextStyle getLightStyle({double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

  static TextStyle getMediumStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  static TextStyle getSemiBoldStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

  static TextStyle getBoldStyle({double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }
}
