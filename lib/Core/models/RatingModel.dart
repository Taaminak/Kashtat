
import 'dart:convert';

import 'UserModel.dart';

class RateModel {
  final List<RateItemModel>? data;

  RateModel({
    this.data,
  });

  RateModel copyWith({
    List<RateItemModel>? data,
  }) =>
      RateModel(
        data: data ?? this.data,
      );

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
    data: json["data"] == null ? [] : List<RateItemModel>.from(json["data"]!.map((x) => RateItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RateItemModel {
  final int? id;
  final User? user;
  final int? rating;
  final int? unitId;
  final String? createdAt;

  RateItemModel({
    this.id,
    this.user,
    this.rating,
    this.unitId,
    this.createdAt,
  });

  RateItemModel copyWith({
    int? id,
    User? user,
    int? rating,
    int? unitId,
    String? createdAt,
  }) =>
      RateItemModel(
        id: id ?? this.id,
        user: user ?? this.user,
        rating: rating ?? this.rating,
        unitId: unitId ?? this.unitId,
        createdAt: createdAt ?? this.createdAt,
      );

  factory RateItemModel.fromJson(Map<String, dynamic> json) => RateItemModel(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    rating: json["rating"],
    unitId: json["unit_id"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "rating": rating,
    "unit_id": unitId,
    "created_at": createdAt,
  };
}

