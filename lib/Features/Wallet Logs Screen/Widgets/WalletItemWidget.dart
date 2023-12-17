import 'package:flutter/material.dart';

import '../../../Core/constants/ColorManager.dart';

class ContainerDecorated extends StatelessWidget {
  const ContainerDecorated({Key? key,required this.content, this.addPadding = true}) : super(key: key);
  final Widget content;
  final bool? addPadding;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 0), // changes position of shadow
          ),

        ],
      ),
      margin: const EdgeInsets.all(7.0),
      child: Padding(
          padding:  EdgeInsets.all(addPadding!?15.0:0),

          child: content,
      ),
    );
  }
}
