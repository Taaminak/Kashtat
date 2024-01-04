import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  int data;
  String message;

  RegistrationModel({
    required this.data,
    required this.message,
  });

  RegistrationModel copyWith({
    int? data,
    String? message,
  }) =>
      RegistrationModel(
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
  };
}
