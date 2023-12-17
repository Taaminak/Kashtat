import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Features/My%20Requests/Widgets/RequestItemWidget.dart';
import 'package:kashtat/Features/Wallet%20Logs%20Screen/Widgets/WalletItemWidget.dart';
import 'package:kashtat/translations/locale_keys.g.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../../Core/constants/ImageManager.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key, this.fromDashboard = false}) : super(key: key);
  final bool fromDashboard;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,leading: SizedBox(),
        title: Text('الاشعارات'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: (true? Center(
        child: Text('لا يوجد لديك اشعارات في الوقت الحالي',style: TextStyle(
          color: ColorManager.darkerGreyColor,
          fontWeight: FontWeight.w500,
        ),),
      ):ListView.builder(
          itemCount: 5,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ContainerDecorated(content: Column(
            children: [
              Text('للأسف لم يتم قبول طلب إضافة تعليمات الوصول بسبب الرجاء إضافة صورة البوابة الخارجية بشكل واضح',style: TextStyle(
                color: ColorManager.mainlyBlueColor,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('شاليهات القمر',style: TextStyle(
                  color: ColorManager.darkerGreyColor,
                  fontWeight: FontWeight.w500,
                ),),
                Text('25 اكتوبر 2023',style: TextStyle(
                  color: ColorManager.darkerGreyColor,
                  fontWeight: FontWeight.w500,
                ),),
              ],)
            ],
          )),
        );
      })),
    );
  }
}

