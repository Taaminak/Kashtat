import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';
import '../../../Core/constants/app_size.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.child,
      required this.height,
      required this.color});
  final Widget child;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: AppSize.w10),
        height: height,
        width: context.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: color),
        child: child);
  }
}
