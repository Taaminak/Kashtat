import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kashtat/Core/Cubit/AppCubit.dart';
import 'package:kashtat/Core/repository/dio_helper.dart';
import 'package:kashtat/Core/repository/remote_endpoint_module.dart';
import 'package:kashtat/Features/Map%20Screen/MapScreen.dart';
import 'package:kashtat/Features/Splash%20Screen/SplashScreen.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<DateTime?> _dates = [];
  @override
  Widget build(BuildContext context) {
    return false? MapScreen(): Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()async {
              final cubit = BlocProvider.of<AppBloc>(context);
              // await cubit.createCoupon(body: {
              //   "code": "22222",
              //   "discount": 0.5,
              //   "expires_at": "2024-01-01 00:00:00",
              // });
              // await cubit.createNewBankAccount(name: "Ahmed", iban: "NBEXXX10001232323", bankId: 1);
              // cubit.getFinancialSummary(from: '2022-11-01',to: '2023-11-07'/*,unitId:11*/,categoryId:1);
              cubit.getAllCoupons();
              // cubit.updateNewUnitCategoryAndTitle(catId: 1, subCatId: 6);
              // cubit.updateUnitCategories(unitId: 11);
              // cubit.getAllCoupons();
              // cubit.reserveTrip();
            },child: Text('تيست ياعم الحاج'),),
          ],
        ),
      ),
    );
  }
}
