import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';

import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/style_manager.dart';

class CustomTxtFlied extends StatelessWidget {
  const CustomTxtFlied(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

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
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.r),
              hintText: hintText,
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
