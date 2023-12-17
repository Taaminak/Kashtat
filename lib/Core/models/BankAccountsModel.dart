import 'dart:convert';

import 'AccountModel.dart';

BankAccountsModel bankAccountsModelFromJson(String str) => BankAccountsModel.fromJson(json.decode(str));

String bankAccountsModelToJson(BankAccountsModel data) => json.encode(data.toJson());

class BankAccountsModel {
  final List<BankAccountModel>? data;

  BankAccountsModel({
    this.data,
  });

  BankAccountsModel copyWith({
    List<BankAccountModel>? data,
  }) =>
      BankAccountsModel(
        data: data ?? this.data,
      );

  factory BankAccountsModel.fromJson(Map<String, dynamic> json) => BankAccountsModel(
    data: json["data"] == null ? [] : List<BankAccountModel>.from(json["data"]!.map((x) => BankAccountModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

