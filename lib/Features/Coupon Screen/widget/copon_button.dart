import 'package:flutter/material.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';
import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/app_size.dart';
import '../../../../Core/constants/style_manager.dart';
import '../../../../Features/Widgets/custom_button.dart';
import '../../../../Features/Widgets/custom_container.dart';

class BuildCoponButton extends StatelessWidget {
  const BuildCoponButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return CustomConatiner(
      height: AppSize.h120,
      width: context.width,
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: CustomButton(
            height: AppSize.h45,
            color: ColorManager.primaryColor,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 20, color: ColorManager.white),
                  SizedBox(
                    width: AppSize.w4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "أنشئ كود خصم جديد",
                      textAlign: TextAlign.center,
                      style: StyleManager.getBoldStyle(
                          fontSize: AppSize.sp14, color: ColorManager.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
