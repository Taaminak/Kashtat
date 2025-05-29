import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kashtat/Features/Widgets/ItemScreenTitle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kashtat/translations/locale_keys.g.dart';

import '../../Core/Cubit/AppCubit.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../Widgets/kButton.dart';

class ReservationRequirementScreen extends StatefulWidget {
  const ReservationRequirementScreen({Key? key}) : super(key: key);

  @override
  State<ReservationRequirementScreen> createState() =>
      _ReservationRequirementScreenState();
}

class _ReservationRequirementScreenState
    extends State<ReservationRequirementScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    final cubit = BlocProvider.of<AppBloc>(context);
    print(cubit.selectedUnit.reservationRoles);
    setState(() {
      controller.text = cubit.selectedUnit.reservationRoles ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.mainlyBlueColor,
        title: Text(LocaleKeys.reservation_requirement.tr(),
            style: TextStyle(fontWeight: FontWeight.normal)),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: const FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TitleWidget(txt: 'اكتب شروط الحجز'),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffDDDDDD), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          minLines: 20,
                          maxLines: 20,
                          controller: controller,
                          style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s14),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: FontSize.s14),
                              fillColor: Colors.white30,
                              hintText: 'ادخل كل شرط في سطر جديد'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                BlocConsumer<AppBloc, AppState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return KButton(
                      onTap: controller.text.isEmpty
                          ? () {}
                          : () {
                              final cubit = BlocProvider.of<AppBloc>(context);
                              cubit.updateNewUnitReservationRole(
                                  reservationRole: controller.text);
                              cubit.updateUnitReservationRoles();
                            },
                      title: 'اضافة',
                      width: size.width,
                      paddingV: 15,
                      isLoading: state is UpdateUnitLoadingState,
                    );
                  },
                ),
                // KButton(onTap: controller.text.isEmpty?(){}: (){
                //   final cubit = BlocProvider.of<AppBloc>(context);
                //   cubit.updateNewUnitReservationRole(reservationRole: controller.text);
                //   cubit.updateUnitReservationRoles();
                //   }, title: 'اضافة',width: size.width,paddingV: 15),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
