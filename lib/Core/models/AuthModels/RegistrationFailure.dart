import 'dart:convert';

RegistrationFailureModel registrationModelFromJson(String str) => RegistrationFailureModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationFailureModel data) => json.encode(data.toJson());

class RegistrationFailureModel {
  String message;
  Errors errors;

  RegistrationFailureModel({
    required this.message,
    required this.errors,
  });

  RegistrationFailureModel copyWith({
    String? message,
    Errors? errors,
  }) =>
      RegistrationFailureModel(
        message: message ?? this.message,
        errors: errors ?? this.errors,
      );

  factory RegistrationFailureModel.fromJson(Map<String, dynamic> json) => RegistrationFailureModel(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  List<String> phone;

  Errors({
    required this.phone,
  });

  Errors copyWith({
    List<String>? phone,
  }) =>
      Errors(
        phone: phone ?? this.phone,
      );

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    phone: List<String>.from(json["phone"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "phone": List<dynamic>.from(phone.map((x) => x)),
  };
}
