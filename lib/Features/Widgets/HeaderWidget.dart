import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/ImageManager.dart';
import '../../Core/constants/RoutesManager.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, this.allowToBack = false}) : super(key: key);
  final bool allowToBack;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: ColorManager.mainlyBlueColor,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: allowToBack?35:0,),
                  Image.asset(ImageManager.logoWithTitleHWhite,width: 100,),
                  allowToBack? InkWell(
                    onTap: (){
                      context.pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SizedBox(
                          width: 10,
                          child: FaIcon(FontAwesomeIcons.chevronLeft,size:20,color: Colors.white,)),
                    ),
                  ):const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
