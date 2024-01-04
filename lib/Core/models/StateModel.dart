import 'dart:convert';

class StateModel {
  final int id;
  final String name;

  StateModel({
    required this.id,
    required this.name,
  });

  StateModel copyWith({
    int? id,
    String? name,
  }) =>
      StateModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory StateModel.fromRawJson(String str) => StateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    id: json["id"]??-1,
    name: json["name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
