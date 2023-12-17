import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashtat/Features/Dashboard%20Screen/DashboardScreen.dart';
import 'package:kashtat/Features/Widgets/ScreenTemplateWidget.dart';
import 'package:kashtat/Features/Widgets/kButton.dart';
import '../../Core/Cubit/AppCubit.dart';
import '../../Core/Cubit/AppState.dart';
import '../../Core/constants/ColorManager.dart';
import '../../Core/constants/FontManager.dart';
import '../Request Details/Widgets/ShowModelBottomSheet.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({Key? key, this.isCreateUnit = true}) : super(key: key);
  final bool isCreateUnit;

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  @override
  void initState() {
    if(!widget.isCreateUnit){
      final cubit = BlocProvider.of<AppBloc>(context);
      controller1.text = cubit.selectedUnit.price!.others!;
      controller2.text = cubit.selectedUnit.price!.thursday!;
      controller3.text = cubit.selectedUnit.price!.friday!;
      controller4.text = cubit.selectedUnit.price!.saturday!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ScreenTemplateWidget(
              title: 'الاسعار',
              content: Column(
                children: [
                  PriceItem(title: "وسط الأسبوع", controller: controller1),
                  PriceItem(title: "الخميس", controller: controller2),
                  PriceItem(title: "الجمعة", controller: controller3),
                  PriceItem(title: "السبت", controller: controller4),
                ],
              ),
            ),
          ),
          BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              if (state is SuccessCreateUnitState) {
                showModelBottomSheet(context).then((value) {
                  final cubit = BlocProvider.of<AppBloc>(context);
                  cubit.changeUserType(UserType.isProvider);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()));
                });
              }
              if (state is FailureCreateUnitState) {
                final snackBar = SnackBar(
                  content: Center(
                      child: Text(
                    state.msg,
                    textAlign: TextAlign.center,
                  )),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: KButton(
                onTap: widget.isCreateUnit
                    ? () {
                        // showModelBottomSheet(context);
                        if (controller1.text.isEmpty ||
                            controller2.text.isEmpty ||
                            controller3.text.isEmpty ||
                            controller4.text.isEmpty) {
                          const snackBar = SnackBar(
                            content: Center(
                                child: Text(
                              'من فضلك ادخل الاسعار',
                              textAlign: TextAlign.center,
                            )),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        cubit.updateNewUnitPricing(
                            priceOfOthers: int.parse(controller1.text),
                            priceFriday: int.parse(controller3.text),
                            priceSaturday: int.parse(controller4.text),
                            priceThursday: int.parse(controller2.text));
                        cubit.createNewUnit();
                      }
                    : () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        cubit.updateNewUnitPricing(
                            priceOfOthers: int.parse(controller1.text),
                            priceThursday: int.parse(controller2.text),
                            priceFriday: int.parse(controller3.text),
                            priceSaturday: int.parse(controller4.text),
                        );
                        cubit.updateUnitPricing();
                      },
                title: widget.isCreateUnit ? 'خلصنا' : "تعديل",
                width: size.width,
                paddingV: 18,
                isLoading:  state is UpdateUnitLoadingState || state is LoadingCreateNewUnitState,
              ),
            ),
          ),
//           BlocListener<AppBloc, AppState>(
//           listener: (context, state) {
//             if(state is SuccessCreateUnitState){
//               showModelBottomSheet(context).then((value){
//                 final cubit = BlocProvider.of<AppBloc>(context);
//                 cubit.changeUserType(UserType.isProvider);
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const DashboardScreen()));
//               });
//             }
//             if(state is FailureCreateUnitState){
//
//               final snackBar =  SnackBar(
//                 content: Center(child: Text(state.msg,textAlign: TextAlign.center,)),
//               );
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: KButton(
//               onTap: widget.isCreateUnit? () {
//                 // showModelBottomSheet(context);
//                 if(controller1.text.isEmpty ||controller2.text.isEmpty ||controller3.text.isEmpty ||controller4.text.isEmpty ){
//
//                   const snackBar =  SnackBar(
//                     content: Center(child: Text('من فضلك ادخل الاسعار',textAlign: TextAlign.center,)),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   return;
//                 }
//                 cubit.updateNewUnitPricing(priceOfOthers: int.parse(controller1.text), priceFriday: int.parse(controller3.text), priceSaturday: int.parse(controller4.text), priceThursday: int.parse(controller2.text));
//                 cubit.createNewUnit();
//               }:(){
//                 FocusManager.instance.primaryFocus?.unfocus();
//                 cubit.updateNewUnitPricing(priceOfOthers: int.parse(controller1.text), priceFriday: int.parse(controller3.text), priceSaturday: int.parse(controller4.text), priceThursday: int.parse(controller2.text));
//                 cubit.updateUnitPricing();
//                 },
//               title:widget.isCreateUnit? 'خلصنا':"تعديل",
//               width: size.width,
//               paddingV: 18,
//             ),
//           ),
// ),
        ],
      ),
    );
  }

  Future<void> showModelBottomSheet(BuildContext context) async {
    final cubit = BlocProvider.of<AppBloc>(context);
    await customBottomSheet(
      context,
      "",
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorManager.whiteDarkColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
              child: Text(
                'يوجد لديك طلب إضافة كشتة بانتظار الموافقة',
                style: TextStyle(
                    fontSize: FontSize.s18, fontWeight: FontWeightManager.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: KButton(
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'موافق',
                width: MediaQuery.of(context).size.width,
                paddingV: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  const PriceItem({Key? key, required this.title, required this.controller})
      : super(key: key);
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: FontSize.s18,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: _decoration,
            child: Center(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration.collapsed(
                  hintText: '0',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'ر.س',
            style: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.bold,
            ),
          )
        ],
      ),
    );
  }
}

BoxDecoration _decoration = BoxDecoration(
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
  border: Border.all(
    color: Colors.grey.withOpacity(0.2),
    width: 1,
  ),
);
