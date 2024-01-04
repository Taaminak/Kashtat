import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/app_size.dart';
import '../../../../Core/constants/style_manager.dart';

class AnalyticsContainer extends StatelessWidget {
  const AnalyticsContainer(
      {super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.h70,
      width: 90,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.grey, width: 1.r),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: StyleManager.getBoldStyle(
                  fontSize: AppSize.sp14, color: ColorManager.black),
            ),
            FittedBox(
              child: Text(
                value,
                style: StyleManager.getMediumStyle(
                    fontSize: AppSize.sp16, color: ColorManager.grey2),
              ),
            ),
          ]),
    );
  }
}
