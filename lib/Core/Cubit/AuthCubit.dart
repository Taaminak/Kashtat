import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/APIsManager.dart';
import '../models/UserModel.dart';
import './AuthState.dart';

import '../repository/remote_endpoint_module.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc(): super(InitState());

  NetworkModule request = NetworkModule();

  User? userProfile;

  /// Account Login
  Future<void> login({required String phone})async{

    // final dio = Dio();
    //   FormData formData = FormData.fromMap({
    //     "phone": "+966$phone",
    //   });
    //   Response response;
    //   response = await dio.post(APIsManager.baseURL+APIsManager.loginApi,data: formData);
    //   print(response.data.toString());
    //   print(response.data['data']);

    emit(LoginLoadingState());
    try{
      FormData formData = FormData.fromMap({
        "phone": "+966$phone",
      });
      final result = await request.postRequest(APIsManager.loginApi,formData);
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) async{

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final decodedData = json.decode(result.data.toString());
        print('----------------------------------------------------');
        print(decodedData['data']);
        print('----------------------------------------------------');
        await prefs.setString('guest_otp', decodedData['data'].toString());
        emit(LoginSuccess(msg: "Check Your Otp"));
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(LoginFailed(msg: e.toString()));
    }
  }

  /// Account Otp
  Future<void> otpLogin({required String phone,required String otpCode})async{
    emit(OtpLoadingState());
    try{
      final result = await request.postRequest(APIsManager.otpApi,{
        "phone": "+966$phone",
        "otp": otpCode,
      });
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final decodedData = json.decode(result.data.toString());
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('token', decodedData['token'].toString());
        await prefs.setString('name', decodedData['data']['name'].toString());
        await prefs.setString('id', decodedData['data']['id'].toString());
        await prefs.setString('phone', decodedData['data']['phone'].toString());
        await prefs.setString('avatar', decodedData['data']['avatar'].toString());
        await prefs.setString('role', decodedData['data']['role'].toString());
        emit(OtpSuccess(msg: "You logged in successfully"));
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(OtpFailed(msg: e.toString()));
    }
  }

  /// Account Register
  Future<void> register({required String phone,required String name})async{
    emit(RegisterLoadingState());
    try{
      final result = await request.postRequest(APIsManager.registerApi,{
        "phone": "+966$phone",
        "name": name,
        "role":'normal',
      });
      result.fold((failure) {
        throw Exception(failure.failure);
      }, (result) {
        emit(RegisterSuccess(msg: "Check Your Otp"));
      });
    }catch(e){
      debugPrintStack(label: e.toString());
      emit(RegisterFailed(msg: e.toString()));
    }
  }


  Future<void> getUserProfile() async {
    emit(LoadingProfileState());
    final result = await request.getRequest('/api/profile');
    result.fold((failure) {
      emit(FailureProfileProfileState());
    }, (result) {
      final decodedData = json.decode(result.data.toString());
      userProfile = User.fromJson(decodedData['data']);
      emit(SuccessProfileProfileState());
    });
  }


}
