import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashtat/Core/constants/ImageManager.dart';
import 'package:kashtat/Features/Coupons%20Screen/widget/drop_menu_dwon.dart';
import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/app_size.dart';
import '../../../Core/constants/style_manager.dart';
import '../../../Features/Widgets/custom_button.dart';
import '../../../Features/Widgets/image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey3,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: AppSize.w15, right: AppSize.w15, top: AppSize.h60),
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
                  LocaleKeys.discount_codes.tr(),
                  textAlign: TextAlign.right,
                  style: StyleManager.getBoldStyle(
                      fontSize: AppSize.sp30, color: ColorManager.black),
                ),
                SizedBox(
                  height: AppSize.h10,
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: ColorManager.primaryColor),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: AppSize.h5),
                  height: AppSize.h5,
                  width: AppSize.w30,
                  color: ColorManager.white,
                ),
                SizedBox(
                  height: AppSize.h10,
                ),
                Text(
                  LocaleKeys.create_discount_code.tr(),
                  textAlign: TextAlign.right,
                  style: StyleManager.getBoldStyle(
                      fontSize: AppSize.sp14, color: ColorManager.white),
                ),
                SizedBox(
                  height: AppSize.h10,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.w15, vertical: AppSize.h20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: ColorManager.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              LocaleKeys.select_kashta_or_units.tr(),
                              textAlign: TextAlign.right,
                              style: StyleManager.getBoldStyle(
                                  fontSize: AppSize.sp18,
                                  color: ColorManager.grey2),
                            ),
                            SizedBox(
                              height: AppSize.h50,
                            ),
                            Text(
                              LocaleKeys.choose_kashta.tr(),
                              textAlign: TextAlign.right,
                              style: StyleManager.getBoldStyle(
                                  fontSize: AppSize.sp20,
                                  color: ColorManager.black),
                            ),
                            SizedBox(
                              height: AppSize.h15,
                            ),
                            const DropMenuDwonWidget()
                          ],
                        ),
                      ),
                      CustomButton(
                        height: 56,
                        color: ColorManager.primaryColor,
                        child: Center(
                          child: Text(
                            LocaleKeys.next.tr(),
                            textAlign: TextAlign.center,
                            style: StyleManager.getBoldStyle(
                                fontSize: AppSize.sp14,
                                color: ColorManager.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
