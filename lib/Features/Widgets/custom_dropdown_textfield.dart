import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/app_size.dart';
import '../../../Core/constants/style_manager.dart';


class CustomDropDownFormField extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? type;
  Function(dynamic val)? onSubmit;
  void Function(dynamic)? onChange;
  Function? onTap;
  bool isPassword = false;
  String? Function(dynamic)? validate;
  String? hintText;
  Color? fillColor;
  var textAlign;
  Widget? icon;
  String? prefixText;

  double? radius;
  double? heigh;

  String? label;
  var labelWidgets;
  var prefix;
  var suffix;
  Function? suffixPressed;
  bool isClickable = true;
  bool autofocus = false;
  var labelBehavior;
  var suffixText;
  var preFixWidget;
  String? selectedValue;

  int? maxLines;

  bool? enableState;
  List<DropdownMenuItem<Object>>? dropDownListItems;

  int? maxLenth;

  dynamic drobDownValue;

  CustomDropDownFormField(
      {super.key,
      this.controller,
      this.enableState,
      this.icon,
      this.drobDownValue,
      this.type,
      this.selectedValue,
      this.hintText,
      this.maxLines = 1,
      this.labelBehavior,
      this.labelWidgets,
      required this.dropDownListItems,
      this.fillColor,
      this.maxLenth,
      this.onSubmit,
      this.onChange,
      this.heigh,
      this.onTap,
      this.prefixText,
      this.radius,
      this.suffixText,
      this.preFixWidget,
      this.isPassword = false,
      required this.validate,
      this.label,
      this.prefix,
      this.suffix,
      this.suffixPressed,
      this.isClickable = true,
      this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      onSaved: onChange,
      value: drobDownValue,
      alignment: Alignment.centerLeft,
      hint: Text(
        hintText ?? "",
        style: StyleManager.getMediumStyle(
            fontSize: AppSize.sp14, color: ColorManager.grey4),
      ),
      icon: icon,
      iconSize: 5.sp,
      style: StyleManager.getMediumStyle(
          fontSize: AppSize.sp14, color: ColorManager.black),
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        prefixStyle: TextStyle(
            color: ColorManager.primaryColor,
            fontWeight: FontWeight.bold,
            /*fontFamily: "Taga",*/
            fontSize: 13.sp),
        errorStyle: TextStyle(
          fontSize: 10.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: heigh ?? 2.h, horizontal: AppSize.w20),
        prefix: preFixWidget,
        labelText: label,
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        label: labelWidgets,
        suffixText: suffixText,
        floatingLabelBehavior: labelBehavior,
        suffixStyle: const TextStyle(color: ColorManager.kOrangeColor),
        labelStyle: TextStyle(
            color: Colors.black,
            fontFamily: "cal",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 2.h),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 2.h),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 3.h),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
        hintText: hintText,
        hintStyle: StyleManager.getMediumStyle(
            fontSize: AppSize.sp14, color: ColorManager.grey4),
        prefixIconConstraints: BoxConstraints(maxHeight: 20.h, maxWidth: 50.w),
        prefixText: prefixText,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () => suffixPressed,
                icon: icon!,
              )
            : null,
      ),
      items: dropDownListItems ?? [const DropdownMenuItem(child: Text(""))],
    );
  }
}
