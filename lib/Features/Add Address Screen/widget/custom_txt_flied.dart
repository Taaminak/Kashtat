import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';

import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/style_manager.dart';
import '../../../../translations/locale_keys.g.dart';
import 'dart:ui' as ui;

class CustomTxtFlied extends StatelessWidget {
  const CustomTxtFlied({
    super.key,
    required this.hintText,
    required this.controller,
    this.translationKey,
  });
  final String hintText;
  final TextEditingController controller;
  final String? translationKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10.r),
        height: 47.h,
        width: context.width,
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.grey, width: 0.5.r),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.r),
              hintText:
                  translationKey != null ? translationKey!.tr() : hintText,
              hintStyle: StyleManager.getMediumStyle(
                  fontSize: 14.sp, color: ColorManager.grey4),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
