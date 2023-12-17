import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:kashtat/Core/models/AuthModels/LoginSuccess.dart';
import 'package:logger/logger.dart';
import './AuthState.dart';

import '../repository/remote_endpoint_module.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc(): super(InitState());

  NetworkModule request = NetworkModule();

  Future<void> login(String phone)async{

    final result = await request.postRequest('/api/login', {
      "phone": phone,
    },);

    result.fold(
            (failure) {
              // print(failure.failure);
              emit(LoginFailed(msg: 'Invalid phone number'));
            },
            (result){
              final decodedData = json.decode(result.data.toString());
              final data = LoginSuccessModel.fromJson(decodedData);


              emit(LoginSuccess(msg: "Done"));
    });
  }



}
