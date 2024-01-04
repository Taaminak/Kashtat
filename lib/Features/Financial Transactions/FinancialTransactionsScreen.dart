import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Features/Account%20Summary/AccountExplanationScreen.dart';
import 'package:kashtat/Features/Account%20Summary/ReportsScreen.dart';
import 'package:kashtat/Features/Account%20Summary/TransfarsScreen.dart';
import 'package:kashtat/Features/Widgets/ScreenTemplateWidget.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/constants/ImageManager.dart';
import '../../Core/constants/RoutesManager.dart';
import '../More Screen/Widgets/ItemWidget.dart';

class FinancialTransactionsScreen extends StatelessWidget {
  const FinancialTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppBloc>(context);
    return ScreenTemplateWidget(title: 'المعاملات المالية', content: Column(
      children: [

        MoreItemWidget(
            title: "اعدادات الحساب البنكي (استلام المبالغ)",
            img: null,
            onTap: () {
              context.push(ScreenName.bankAccountSettings);
            }),
        MoreItemWidget(
            title: "الحوالات",
            img: null,
            onTap: () async{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const TransfarsScreen()));
            }),
        MoreItemWidget(
            title: "الفواتير",
            img: null,
            onTap: () async{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReportssScreen()));
              // context.push(ScreenName.myAccount);
            }),
        MoreItemWidget(
            title: "كشوف الحسابات",
            img: null,
            onTap: () async{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AccountExplanationScreen()));
              // context.push(ScreenName.myAccount);
            }),
        MoreItemWidget(
            title: "ملخص الحسابات",
            img: null,
            onTap: () {
              context.push(ScreenName.accountSummary);
            }),
      ],
    ));
  }
}
