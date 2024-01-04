import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kashtat/Core/Extentions/extention.dart';

import '../../../Core/constants/ColorManager.dart';
import '../../../Core/constants/FontManager.dart';
import '../../../Core/constants/ImageManager.dart';

class MoreItemWidget extends StatelessWidget {
  const MoreItemWidget({Key? key, required this.title, required this.img, required this.onTap, this.textColor,this.hint}) : super(key: key);
  final String title;
  final String? img;
  final String? hint;
  final Color? textColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.2))
          ),
          child: ListTile(
            leading:img==null?null  :Image.asset(img!,width: 20,color: ColorManager.orangeColor,),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title.capitalize(),style: TextStyle(color:textColor??ColorManager.blackColor ,fontSize: 13, fontWeight: FontWeightManager.bold),),
                if(hint!=null)
                const SizedBox(width: 10,),
                Text(hint??'',style: TextStyle(color: ColorManager.orangeColor,fontSize: FontSize.s14, fontWeight: FontWeightManager.bold),),
              ],
            ),
            trailing: Icon(context.locale == Locale('ar') ?Icons.arrow_back_ios_new_outlined:Icons.arrow_forward_ios_rounded,color: ColorManager.orangeColor,size: 20),
            onTap: onTap,
          ),
        ),
      );
  }
}
