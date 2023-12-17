import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Features/Widgets/ScreenTemplateWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';

class UsageAgreementScreen extends StatelessWidget {
  const UsageAgreementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateWidget(
      title: 'اتفاقية الاستخدام',
      content: SizedBox(
        height: 350,
        width: double.infinity,
      ),
    );
  }
}
