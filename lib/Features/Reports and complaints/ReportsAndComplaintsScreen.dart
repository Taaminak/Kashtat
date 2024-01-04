import 'package:flutter/material.dart';

import '../../Core/constants/ColorManager.dart';
import '../Widgets/ScreenTemplateWidget.dart';
class ReportsAndComplaintsScreen extends StatelessWidget {
  const ReportsAndComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateWidget(
      title: 'البلاغات والشكاوي',
      content: SizedBox(
        height: 400,
        width: double.infinity,
        child: Center(child: Text('لا يوجد اي بلاغات حتى الآن',style: TextStyle(
            color: ColorManager.darkerGreyColor
        ),)),
      ),);
  }
}
