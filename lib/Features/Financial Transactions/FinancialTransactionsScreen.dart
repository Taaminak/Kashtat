import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
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
    return ScreenTemplateWidget(
        title: LocaleKeys.financial_transactions.tr(),
        content: Column(
          children: [
            MoreItemWidget(
                title: LocaleKeys.bank_account_settings_receive.tr(),
                img: null,
                onTap: () {
                  context.push(ScreenName.bankAccountSettings);
                }),
            MoreItemWidget(
                title: LocaleKeys.transfers.tr(),
                img: null,
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TransfarsScreen()));
                }),
            MoreItemWidget(
                title: LocaleKeys.invoices.tr(),
                img: null,
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportssScreen()));
                }),
            MoreItemWidget(
                title: LocaleKeys.account_statements.tr(),
                img: null,
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AccountExplanationScreen()));
                }),
            MoreItemWidget(
                title: LocaleKeys.account_summary.tr(),
                img: null,
                onTap: () {
                  context.push(ScreenName.accountSummary);
                }),
          ],
        ));
  }
}
