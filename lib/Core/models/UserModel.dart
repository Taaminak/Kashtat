
import 'dart:convert';

class User {
  int? id;
  String? name;
  String? phone;
  String? role;
  String? avatar;
  num? wallet;
  num? reservationsCount;
  num? unitsCount;
  num? totalSales;

  User({
     this.id,
     this.name,
     this.phone,
     this.role,
     this.avatar,
    this.wallet,
    this.reservationsCount,
    this.unitsCount,
    this.totalSales,
  });

  User copyWith({
    int? id,
    String? name,
    String? phone,
    String? role,
    String? avatar,
    num? wallet,
    num? reservationsCount,
    num? unitsCount,
    num? totalSales,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        avatar: avatar ?? this.avatar,
        wallet: wallet ?? this.wallet,
        reservationsCount: reservationsCount ?? this.reservationsCount,
        unitsCount: unitsCount ?? this.unitsCount,
        totalSales: totalSales ?? this.totalSales,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"]??-1,
    name: json["name"]??'',
    phone: json["phone"]??'',
    role: json["role"]??'',
    avatar: json["avatar"]??'',
    wallet: num.parse(json["wallet"]??'0.0'),
    reservationsCount: json["reservations_count"]??0,
    unitsCount: json["units_count"]??0,
    totalSales: json["total_sales"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "role": role,
    "avatar": avatar,
    "wallet": wallet,
    "reservations_count": reservationsCount,
    "units_count": unitsCount,
    "total_sales": totalSales,
  };
}