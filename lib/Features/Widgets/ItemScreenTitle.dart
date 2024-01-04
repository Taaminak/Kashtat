import 'package:flutter/material.dart';

import '../../Core/constants/FontManager.dart';
class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key,required this.txt,}) : super(key: key);
  final String txt;
  @override
  Widget build(BuildContext context) {
    return  Text(txt,
      style: TextStyle(
        fontSize: FontSize.s18,
        fontWeight: FontWeightManager.bold,
      ),);
  }
}
