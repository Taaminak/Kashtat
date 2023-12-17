
import 'dart:convert';

class PaymentGateway {
  int id;
  String name;
  bool isActive;

  PaymentGateway({
    required this.id,
    required this.name,
    required this.isActive,
  });

  PaymentGateway copyWith({
    int? id,
    String? name,
    bool? isActive,
  }) =>
      PaymentGateway(
        id: id ?? this.id,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
      );

  factory PaymentGateway.fromRawJson(String str) => PaymentGateway.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
    id: json["id"],
    name: json["name"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_active": isActive,
  };
}