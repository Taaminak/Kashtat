import 'dart:convert';

import 'CityModel.dart';

class CitiesModel {
  List<City> data;

  CitiesModel({
    required this.data,
  });

  CitiesModel copyWith({
    List<City>? data,
  }) =>
      CitiesModel(
        data: data ?? this.data,
      );

  factory CitiesModel.fromRawJson(String str) => CitiesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
    data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

