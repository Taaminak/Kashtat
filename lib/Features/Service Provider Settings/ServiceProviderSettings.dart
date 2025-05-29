import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Features/Cancellation%20And%20Return%20Policy/CalncelationAndReturnPolicy.dart';
import 'package:kashtat/Features/Widgets/ScreenTemplateWidget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

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
        return ScreenTemplateWidget(
            title: LocaleKeys.settings.tr(),
            content: Column(
              children: [
                MoreItemWidget(
                    title: LocaleKeys.entry_and_departure_time.tr(),
                    img: null,
                    onTap: () {
                      context.push(ScreenName.entryAndDepartureTime);
                    }),
                MoreItemWidget(
                  title: LocaleKeys.cancellation_and_return_policy.tr(),
                  img: null,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CancellationAndReturnPolicyScreen()));
                  },
                  hint: cubit.selectedUnit.cancellationPolicy!.isEmpty
                      ? LocaleKeys.incomplete.tr()
                      : null,
                ),
                MoreItemWidget(
                  title: LocaleKeys.booking_conditions.tr(),
                  img: null,
                  onTap: () {
                    context.push(ScreenName.reservationRequirement);
                  },
                  hint: cubit.selectedUnit.reservationRoles!.isEmpty
                      ? LocaleKeys.incomplete.tr()
                      : null,
                ),
                MoreItemWidget(
                  title: LocaleKeys.arrival_instructions.tr(),
                  img: null,
                  onTap: () {
                    context.push(ScreenName.arrivalInstructions);
                  },
                  hint: (cubit.selectedUnit.instruction1!.isEmpty ||
                          cubit.selectedUnit.instruction2!.isEmpty)
                      ? LocaleKeys.incomplete.tr()
                      : null,
                ),
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
