import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kashtat/Core/constants/APIsManager.dart';
import 'package:kashtat/Core/repository/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'endpoint_responses.dart';

class NetworkModule {
  final DioHelper _dio = DioHelper();

  ServerResponse<dynamic> postRequest<T>(
      String url,
      dynamic body,
      [
        bool isFormUrlEncoded = false,
        bool isMultipart = false,
      ]
      // dynamic model,
      ) async {
    try{

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      Response response = await _dio.post(base: APIsManager.baseURL,url: url, body: body,token: token,isMultipart: isMultipart,isFormUrlEncoded: isFormUrlEncoded).onError((error, stackTrace){
        return Left(
          Failure(
            failure: {error},
          ),

        );
      });
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(
            Success(
              message: response.statusMessage ??'Done',
              data: response,
            ));
      } else {
        return Left(
          Failure(
            failure: response,
          ),
        );
      }
    }catch(e){

      return Left(
        Failure(
          failure: e,
        ),
      );
    }
  }

  ServerResponse<dynamic> putRequest<T>(
      String url,
      dynamic body,
      [bool isMultipart = false]
      // dynamic model,
      ) async {
    try{

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';

      Response response = await _dio.put(base: APIsManager.baseURL,url: url, body: body,token: token,isMultipart: isMultipart).onError((error, stackTrace){
        return Left(
          Failure(
            failure: {error},
          ),

        );
      });
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(
            Success(
              message: response.statusMessage ??'Done',
              data: response,
            ));
      } else {
        return Left(
          Failure(
            failure: response,
          ),
        );
      }
    }catch(e){

      return Left(
        Failure(
          failure: e,
        ),
      );
    }
  }

  ServerResponse<dynamic> getRequest<T>(
      String url,
      // dynamic model,
      ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(token);
    Response response = await _dio.get(base: APIsManager.baseURL,url: url,token: token);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(
          Success(
            message: response.statusMessage ??'Done',
            data: response,
          ));
    } else {
      return Left(
        Failure(
          failure: response,
        ),
      );
    }
  }

}