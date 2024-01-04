import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/FontManager.dart';

import '../../../Core/constants/ColorManager.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({Key? key, required this.requestKey, required this.value}) : super(key: key);
  final String requestKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding:
        const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              requestKey,
              style: TextStyle(
                color: ColorManager.blackColor,
                fontSize: 15,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: ColorManager.darkerGreyColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
  }
}
