import 'dart:convert';
import 'UnitModel.dart';


UnitsModel unitsModelFromJson(String str) => UnitsModel.fromJson(json.decode(str));

String unitsModelToJson(UnitsModel data) => json.encode(data.toJson());

class UnitsModel {
  final List<UnitModel>? data;

  UnitsModel({
    this.data,
  });

  UnitsModel copyWith({
    List<UnitModel>? data,
  }) =>
      UnitsModel(
        data: data ?? this.data,
      );

  factory UnitsModel.fromJson(Map<String, dynamic> json) => UnitsModel(
    data: json["data"] == null ? [] : List<UnitModel>.from(json["data"]!.map((x) => UnitModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

