import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/app_size.dart';
import '../../../../Core/constants/style_manager.dart';

class CodeWidget extends StatelessWidget {
  const CodeWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.h56,
      width: AppSize.w137,
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.primaryColor, width: 2.r),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
          child: Text(
        title,
        textAlign: TextAlign.center,
        style: StyleManager.getBoldStyle(
            fontSize: AppSize.sp18, color: ColorManager.primaryColor),
      )),
    );
  }
}
