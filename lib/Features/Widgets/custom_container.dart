import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomConatiner extends StatelessWidget {
  const CustomConatiner(
      {super.key,
      required this.child,
      required this.height,
      required this.width});
  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 5,
        child: child,
      ),
    );
  }
}
