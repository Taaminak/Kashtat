import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';
import 'package:kashtat/Core/models/CouponModel.dart';
import 'package:kashtat/Core/Extentions/media_values.dart';
import '../../../../Core/constants/ColorManager.dart';
import '../../../../Core/constants/app_size.dart';
import '../../../../Features/Widgets/custom_container.dart';
import 'analytics_container.dart';
import 'code_widget.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

class CodesContainer extends StatefulWidget {
  const CodesContainer({super.key, required this.coupon});
  final CouponModel coupon;

  @override
  State<CodesContainer> createState() => _CodesContainerState();
}

class _CodesContainerState extends State<CodesContainer> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return CustomConatiner(
      height: AppSize.h200,
      width: context.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.w10, vertical: AppSize.h15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CodeWidget(
                  title: widget.coupon.code ?? '',
                ),
                CupertinoSwitch(
                  value: _switchValue,
                  activeColor: ColorManager.green,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnalyticsContainer(
                  title: LocaleKeys.analytics_discount.tr(),
                  value: '${widget.coupon.discount}%',
                ),
                AnalyticsContainer(
                  title: LocaleKeys.analytics_usage.tr(),
                  value: (widget.coupon.limit ?? '').toString(),
                ),
                AnalyticsContainer(
                  title: LocaleKeys.analytics_expiry.tr(),
                  value: DateFormat()
                      .add_yMMMd()
                      .format(widget.coupon.expiresAt ?? DateTime.now()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
