import 'dart:convert';
import 'StateModel.dart';

class City {
  int id;
  String name;
  List<StateModel> states ;

  City({
    required this.id,
    required this.name,
    required this.states,
  });

  City copyWith({
    int? id,
    String? name,
    List<StateModel>? states,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        states: states ?? this.states,
      );

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"]??-1,
    name: json["name"] ?? '',
    states: json["state"]==null? [] : List<StateModel>.from(json["state"].map((state)=>StateModel.fromJson(state))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state": states,
  };
}