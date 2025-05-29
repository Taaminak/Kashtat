import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../Core/constants/ColorManager.dart';
import '../../translations/locale_keys.g.dart';
import '../Widgets/ScreenTemplateWidget.dart';

class ReportsAndComplaintsScreen extends StatelessWidget {
  const ReportsAndComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateWidget(
      title: LocaleKeys.reports_and_complaints.tr(),
      content: SizedBox(
        height: 400,
        width: double.infinity,
        child: Center(
            child: Text(
          LocaleKeys.no_account_reports_yet.tr(),
          style: TextStyle(color: ColorManager.darkerGreyColor),
        )),
      ),
    );
  }
}
