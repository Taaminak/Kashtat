import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/app_size.dart';
import '../../../../Features/Widgets/custom_dropdown_textfield.dart';
import '../../../../Features/Widgets/image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class DropMenuDwonWidget extends StatefulWidget {
  const DropMenuDwonWidget({super.key});

  @override
  State<DropMenuDwonWidget> createState() => _DropMenuDwonWidgetState();
}

class _DropMenuDwonWidgetState extends State<DropMenuDwonWidget> {
  TextEditingController controller = TextEditingController();
  String value = "1";
  void setgenderController(String val) {
    setState(() {
      value = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: AppSize.screenWidth * .8,
        height: AppSize.h50,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.grey, width: 1.r),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: CustomDropDownFormField(
              fillColor: Colors.white,
              radius: AppSize.h15,
              hintText: LocaleKeys.choose_kashta.tr(),
              icon: AssetImageWidget(
                height: AppSize.h15,
                imgPath: ImageManager.dropButton,
                width: AppSize.w15,
              ),
              controller: controller,
              drobDownValue: controller.text != "" ? controller.text : null,
              dropDownListItems: ["1", "2", "3"].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Center(child: Text(e.toString())),
                );
              }).toList(),
              validate: (val) {
                return null;
              },
              onChange: (val) {
                setgenderController(val);
              },
            ),
          ),
        ),
      ),
    );
  }
}
