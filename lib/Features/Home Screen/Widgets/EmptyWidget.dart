import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/FontManager.dart';
import '../../../Core/constants/ImageManager.dart';

class HomeEmptyWidget extends StatelessWidget {
  const HomeEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: size.width,
        height: size.width - 100,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                child: Image.asset(
                  ImageManager.logoHalfGrey,
                  width: 100,
                )),
            Positioned.fill(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageManager.warning,
                  width: 45,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  LocaleKeys.no_units.tr(),
                  style: TextStyle(
                      color: ColorManager.darkGreyColor,
                      fontWeight: FontWeightManager.bold),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
