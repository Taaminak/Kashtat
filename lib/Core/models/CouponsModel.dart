import 'dart:convert';
import 'CouponModel.dart';

CouponsModel couponsModelFromJson(String str) => CouponsModel.fromJson(json.decode(str));

String couponsModelToJson(CouponsModel data) => json.encode(data.toJson());

class CouponsModel {
  final List<CouponModel>? data;

  CouponsModel({
    this.data,
  });

  CouponsModel copyWith({
    List<CouponModel>? data,
  }) =>
      CouponsModel(
        data: data ?? this.data,
      );

  factory CouponsModel.fromJson(Map<String, dynamic> json) => CouponsModel(
    data: json["data"] == null ? [] : List<CouponModel>.from(json["data"]!.map((x) => CouponModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
