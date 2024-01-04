import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Features/Cancellation%20And%20Return%20Policy/CalncelationAndReturnPolicy.dart';
import 'package:kashtat/Features/Widgets/ScreenTemplateWidget.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/ImageManager.dart';
import '../../Core/constants/RoutesManager.dart';
import '../More Screen/Widgets/ItemWidget.dart';

class ServiceProviderSettingsScreen extends StatelessWidget {
  const ServiceProviderSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<AppBloc>(context);
        return ScreenTemplateWidget(title: 'الاعدادات', content: Column(
          children: [

            MoreItemWidget(
                title: "وقت الدخول والمغادرة",
                img: null,
                onTap: () {
                  context.push(ScreenName.entryAndDepartureTime);
                }),
            MoreItemWidget(
              title: "سياسة الإلغاء والاسترجاع",
              img: null,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CancellationAndReturnPolicyScreen()));
              },
              hint:cubit.selectedUnit.cancellationPolicy!.isEmpty?"غير مكتمل":null,
            ),
            MoreItemWidget(
                title: "شروط الحجز",
                img: null,
                onTap: () {
                  context.push(ScreenName.reservationRequirement);
                },
              hint:cubit.selectedUnit.reservationRoles!.isEmpty?"غير مكتمل":null,),
            MoreItemWidget(
                title: "تعليمات الوصول",
                img: null,
                onTap: () {
                  context.push(ScreenName.arrivalInstructions);
                },
              hint:(cubit.selectedUnit.instruction1!.isEmpty||cubit.selectedUnit.instruction2!.isEmpty)?"غير مكتمل":null,),
            // MoreItemWidget(
            //     title: "ضريبة القيمة المضافة",
            //     img: null,
            //     onTap: () {
            //       // context.push(ScreenName.accountSummary);
            //     }),
          ],
        ));
      },
    );
  }
}
