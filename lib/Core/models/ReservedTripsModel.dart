import 'dart:convert';

import 'UnitModel.dart';

class ReservedTripsModel {
  List<UnitModel> past;
  List<UnitModel> upcoming;

  ReservedTripsModel({
    required this.past,
    required this.upcoming,
  });

  ReservedTripsModel copyWith({
    List<UnitModel>? past,
    List<UnitModel>? upcoming,
  }) =>
      ReservedTripsModel(
        past: past ?? this.past,
        upcoming: upcoming ?? this.upcoming,
      );

  factory ReservedTripsModel.fromRawJson(String str) => ReservedTripsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReservedTripsModel.fromJson(Map<String, dynamic> json) => ReservedTripsModel(
    past: List<UnitModel>.from(json["past"].map((x) => UnitModel.fromJson(x))),
    upcoming: List<UnitModel>.from(json["upcoming"].map((x) => UnitModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "past": List<dynamic>.from(past.map((x) => x.toJson())),
    "upcoming": List<dynamic>.from(upcoming.map((x) => x.toJson())),
  };
}
