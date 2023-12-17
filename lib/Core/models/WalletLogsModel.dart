// To parse this JSON data, do
//
//     final walletsModel = walletsModelFromJson(jsonString);

import 'dart:convert';

import 'UserModel.dart';

WalletsModel walletsModelFromJson(String str) => WalletsModel.fromJson(json.decode(str));

String walletsModelToJson(WalletsModel data) => json.encode(data.toJson());

class WalletsModel {
  final List<WalletLogsModel>? data;

  WalletsModel({
    this.data,
  });

  WalletsModel copyWith({
    List<WalletLogsModel>? data,
  }) =>
      WalletsModel(
        data: data ?? this.data,
      );

  factory WalletsModel.fromJson(Map<String, dynamic> json) => WalletsModel(
    data: json["data"] == null ? [] : List<WalletLogsModel>.from(json["data"]!.map((x) => WalletLogsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WalletLogsModel {
  final int? id;
  final int? amount;
  final User? user;
  final DateTime? createdAt;

  WalletLogsModel({
    this.id,
    this.amount,
    this.user,
    this.createdAt,
  });

  WalletLogsModel copyWith({
    int? id,
    int? amount,
    User? user,
    DateTime? createdAt,
  }) =>
      WalletLogsModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
      );

  factory WalletLogsModel.fromJson(Map<String, dynamic> json) => WalletLogsModel(
    id: json["id"],
    amount: json["amount"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "user": user?.toJson(),
    "created_at": createdAt?.toIso8601String(),
  };
}

