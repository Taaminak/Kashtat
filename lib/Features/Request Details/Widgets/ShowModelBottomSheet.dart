import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/FontManager.dart';
import '../../../translations/locale_keys.g.dart';

Future<void> customBottomSheet(
    BuildContext context, String? title, Widget widget,
    [bool hasCustomHeight = false, double? customHeight]) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: hasCustomHeight
            ? customHeight ?? MediaQuery.of(context).size.height * 0.75
            : 250,
        decoration: new BoxDecoration(
          color: ColorManager.mainlyBlueColor,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(30.0),
            topRight: const Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: ColorManager.mainlyBlueColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title?.tr() ?? '',
                    style: TextStyle(
                      fontWeight: FontWeightManager.bold,
                      fontSize: FontSize.s16,
                      color: ColorManager.whiteDarkColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: widget))
          ],
        ),
      ),
    ),
  );
  return;
}
