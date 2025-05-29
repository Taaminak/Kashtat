import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/ColorManager.dart';
import 'package:kashtat/Features/Widgets/ScreenTemplateWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class UsageAgreementScreen extends StatelessWidget {
  const UsageAgreementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateWidget(
      title: LocaleKeys.usage_agreement.tr(),
      content: SizedBox(
        height: 350,
        width: double.infinity,
      ),
    );
  }
}
