

import 'UserModel.dart';

class CouponModel {
  final int? id;
  final String? code;
  final int? discount;
  final String? type;
  final DateTime? expiresAt;
  final User? provider;
  final int? limit;
  final bool? isPrivate;

  CouponModel({
    this.id,
    this.code,
    this.discount,
    this.type,
    this.expiresAt,
    this.provider,
    this.limit,
    this.isPrivate,
  });

  CouponModel copyWith({
    int? id,
    int? limit,
    String? code,
    int? discount,
    String? type,
    DateTime? expiresAt,
    User? provider,
    bool? isPrivate,
  }) =>
      CouponModel(
        id: id ?? this.id,
        limit: limit ?? this.limit,
        code: code ?? this.code,
        discount: discount ?? this.discount,
        type: type ?? this.type,
        expiresAt: expiresAt ?? this.expiresAt,
        provider: provider ?? this.provider,
        isPrivate: isPrivate ?? this.isPrivate,
      );

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    id: json["id"],
    code: json["code"],
    isPrivate: json["is_private"],
    discount: json["discount"],
    type: json["type"],
    limit: json["usage_limit"],
    expiresAt: json["expires_at"] == null ? DateTime.now() : DateTime.parse(json["expires_at"]),
    provider: json["provider"] == null ? null : User.fromJson(json["provider"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "usage_limit": limit,
    "discount": discount,
    "is_private": isPrivate,
    "type": type,
    "expires_at": expiresAt?.toIso8601String(),
    "provider": provider?.toJson(),
  };
}