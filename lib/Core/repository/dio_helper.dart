import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kashtat/Core/constants/APIsManager.dart';
import 'package:logger/logger.dart';

abstract class DioHelper {

  factory DioHelper() => DioImpl();

  Future<dynamic> post({
    required String url,
    String? base, // if you want to use different base url
    required dynamic body,
    String? token,
    CancelToken? cancelToken,
    bool isMultipart = false,
    bool isFormUrlEncoded = false,
  });
  Future<dynamic> put({
    required String url,
    String? base, // if you want to use different base url
    required dynamic body,
    String? token,
    CancelToken? cancelToken,
    bool isMultipart = false,
  });

  Future<dynamic> get({
    required String url,
    String? base, // if you want to use different base url
    String? token,
    CancelToken? cancelToken,
    bool isMultipart = false,
  });
}

class DioImpl implements DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      // the connection will return timeout after 10 seconds
      connectTimeout: const Duration(seconds: 10),
    )
  );

  @override
  Future post({
    required String url,
    String? base,
    required body,
    String? token,
    CancelToken? cancelToken,
    bool isMultipart = false,
    bool isFormUrlEncoded = false,
  }) async {
    if(base != null){
      dio.options.baseUrl = base;
    }else{
      dio.options.baseUrl = APIsManager.baseURL;
    }

    dio.options.headers = {
      'Content-Type': isFormUrlEncoded? "application/x-www-form-urlencoded":'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      "Keep-Alive": "timeout=5, max=1000",
      if (token != null)'Authorization': 'Bearer $token',
    };

    dio.options.validateStatus = (code)
    {
      if (code!<=500){
        return true;
      }
      return false;
    };

    // debugPrint('URL => ${dio.options.baseUrl + url}');
    // debugPrint('Body => $body');

    // log(dio.options.baseUrl + url,name: "URL");
    // log(body.toString(),name: "Body");

    final r= await request(
      () => dio.post(
        url,
        data: body,
        cancelToken: cancelToken,
      ),
    );
    log(r.realUri.toString(),name: "URL");
    log(body.toString(),name: "Body");
    log('',name: "Response");
    print(r.data.toString());
    return r;

  }

  @override
  Future put({
    required String url,
    String? base,
    required body,
    String? token,
    CancelToken? cancelToken,
    bool isMultipart = false,
  }) async {
    if(base != null){
      dio.options.baseUrl = base;
    }else{
      dio.options.baseUrl = APIsManager.baseURL;
    }

    dio.options.headers = {
      // 'Content-Type': 'multipart/form-data',
      "Content-Type": "application/x-www-form-urlencoded",
      // 'Accept': '*/*',
      // 'Connection': 'keep-alive',
      // 'Accept-Encoding': 'gzip, deflate, br',
      // "Keep-Alive": "timeout=5, max=1000",
      if (token != null)'Authorization': 'Bearer $token',
    };

    dio.options.validateStatus = (code)
    {
      if (code!<=500){
        return true;
      }
      return false;
    };

    // debugPrint('URL => ${dio.options.baseUrl + url}');
    // debugPrint('Body => $body');

    // log(dio.options.baseUrl + url,name: "URL");
    // log(body.toString(),name: "Body");

    final r = await request(
          () => dio.put(
        url,
        data: body,
        cancelToken: cancelToken,
      ),
    );
    log(r.realUri.toString(),name: "URL");
    log(body.toString(),name: "Body");
    log('',name: "Response");
    print(r.data.toString());
    return r;
  }

  @override
  Future get({
    required String url,
    String? base,
    String? token,
    dynamic query,
    CancelToken? cancelToken,
    bool isMultipart = false,
  }) async {


    Dio dio = Dio();
    if(base != null){
      dio.options.baseUrl = base;
    }else{
      dio.options.baseUrl = APIsManager.baseURL;
    }

    dio.options.headers = {
      // 'Content-Type': 'multipart/form-data',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Connection': 'keep-alive',
       "Keep-Alive": "timeout=5, max=1000",
      if (token != null)'Authorization': 'Bearer $token',
    };

    // debugPrint('URL => ${dio.options.baseUrl + url}');
    // debugPrint('Query => $query');
    // log(dio.options.baseUrl + url,name: "URL");
    // log(query.toString(),name: "Query");
    final r = await request(
          () => dio.get(
        url,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
    log(r.realUri.toString(),name: "URL");
    log('',name: "Response");
    print(r.data.toString());
    return r;
  }
}

extension on DioHelper{
  Future request(Future<Response> Function() request)async{
    try{
      final r = await request.call();
      // log(r.data.toString(),name: "Response:");
      // var logger = Logger();
      // logger.i('Response => ${r.data}');
      return r;
    }catch(e){
      var logger = Logger();
      logger.e('Response => $e');
      rethrow;
    }
  }
}
