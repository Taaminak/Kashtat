import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Core/constants/FontManager.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key,}) : super(key: key);


  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                  ),
                  height: 2,
                )),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: ColorManager.mainlyBlueColor,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: ColorManager.whiteColor,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: ColorManager.mainlyBlueColor,
                    ),
                  ),
                ),

                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.mainlyBlueColor,
                  ),
                  height: 2,
                )),
              ],
            ),
            SizedBox(height: 5),
            Text(LocaleKeys.receipt_of_the_request.tr(),style: TextStyle(fontSize: FontSize.s12),)
          ],
        )),
        Expanded(child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.mainlyBlueColor,
                  ),
                  height: 2,
                )),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: ColorManager.mainlyBlueColor,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: ColorManager.whiteColor,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: ColorManager.mainlyBlueColor,
                    ),
                  ),
                ),

                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.mainlyBlueColor,
                  ),
                  height: 2,
                )),
              ],
            ),
            SizedBox(height: 5),
            Text(LocaleKeys.receive_the_service_provider.tr(),style: TextStyle(fontSize: FontSize.s12),)
          ],
        )),
        Expanded(child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.mainlyBlueColor,
                  ),
                  height: 2,
                )),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: ColorManager.mainlyBlueColor,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: ColorManager.whiteColor,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: ColorManager.mainlyBlueColor,
                    ),
                  ),
                ),

                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                  ),
                  height: 2,
                )),
              ],
            ),
            const SizedBox(height: 5),
            Text(LocaleKeys.payment.tr(),style: TextStyle(fontSize: FontSize.s12),)
          ],
        )),
      ],
    );
  }
}
