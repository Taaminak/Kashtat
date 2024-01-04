// To parse this JSON data, do
//
//     final allBanksModel = allBanksModelFromJson(jsonString);

import 'dart:convert';

import 'package:kashtat/Core/models/BankModel.dart';

AllBanksModel allBanksModelFromJson(String str) => AllBanksModel.fromJson(json.decode(str));

String allBanksModelToJson(AllBanksModel data) => json.encode(data.toJson());

class AllBanksModel {
  final List<BankModel>? data;

  AllBanksModel({
    this.data,
  });

  AllBanksModel copyWith({
    List<BankModel>? data,
  }) =>
      AllBanksModel(
        data: data ?? this.data,
      );

  factory AllBanksModel.fromJson(Map<String, dynamic> json) => AllBanksModel(
    data: json["data"] == null ? [] : List<BankModel>.from(json["data"]!.map((x) => BankModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
