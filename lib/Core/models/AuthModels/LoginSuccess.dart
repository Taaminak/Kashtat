import 'dart:convert';

LoginSuccessModel loginSuccessModelFromJson(String str) => LoginSuccessModel.fromJson(json.decode(str));

String loginSuccessModelToJson(LoginSuccessModel data) => json.encode(data.toJson());

class LoginSuccessModel {
  int? data;
  String? message;

  LoginSuccessModel({
    this.data,
    this.message,
  });

  LoginSuccessModel copyWith({
    int? data,
    String? message,
  }) =>
      LoginSuccessModel(
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory LoginSuccessModel.fromJson(Map<String, dynamic> json) => LoginSuccessModel(
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
  };
}
