import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/app_size.dart';
import '../../../Core/constants/style_manager.dart';
import '../../../Features/Widgets/custom_container.dart';
import '../../../Features/Widgets/image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../translations/locale_keys.g.dart';

class AccountReportsScreen extends StatefulWidget {
  const AccountReportsScreen({super.key});

  @override
  State<AccountReportsScreen> createState() => _AccountReportsScreenState();
}

class _AccountReportsScreenState extends State<AccountReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey3,
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSize.w15, right: AppSize.w15, top: AppSize.h60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AssetImageWidget(
                  imgPath: ImageManager.arrowBack,
                  height: AppSize.h15,
                  width: AppSize.w15,
                ),
              ),
              SizedBox(
                height: AppSize.h10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AssetImageWidget(
                  imgPath: ImageManager.logo2,
                  height: AppSize.h73,
                  width: AppSize.w155,
                ),
              ),
              SizedBox(
                height: AppSize.h10,
              ),
              Text(
                LocaleKeys.account_reports.tr(),
                textAlign: TextAlign.right,
                style: StyleManager.getBoldStyle(
                    fontSize: AppSize.sp30, color: ColorManager.black),
              ),
              SizedBox(
                height: AppSize.h10,
              ),
              CustomConatiner(
                height: AppSize.h420,
                width: context.width,
                child: Center(
                  child: Text(
                    LocaleKeys.no_account_reports_yet.tr(),
                    style: StyleManager.getBoldStyle(
                        fontSize: AppSize.sp14, color: ColorManager.grey2),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
