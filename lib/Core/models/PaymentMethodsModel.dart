import 'dart:convert';

import 'package:kashtat/Core/models/PaymentMethodModel.dart';


class PaymentMethodsModel {
  List<PaymentGateway> data;

  PaymentMethodsModel({
    required this.data,
  });

  PaymentMethodsModel copyWith({
    List<PaymentGateway>? data,
  }) =>
      PaymentMethodsModel(
        data: data ?? this.data,
      );

  factory PaymentMethodsModel.fromRawJson(String str) => PaymentMethodsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) => PaymentMethodsModel(
    data: List<PaymentGateway>.from(json["data"].map((x) => PaymentGateway.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

