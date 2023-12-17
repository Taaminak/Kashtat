import 'dart:convert';
import 'dart:developer';


import 'UnitModel.dart';
import 'UserModel.dart';

class UserReservationModel {
  List<ReservationModel> past;
  List<ReservationModel> upcoming;

  UserReservationModel({
    required this.past,
    required this.upcoming,
  });

  UserReservationModel copyWith({
    List<ReservationModel>? past,
    List<ReservationModel>? upcoming,
  }) =>
      UserReservationModel(
        past: past ?? this.past,
        upcoming: upcoming ?? this.upcoming,
      );

  factory UserReservationModel.fromRawJson(String str) => UserReservationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserReservationModel.fromJson(Map<String, dynamic> json) {
    print('=======================================================================');
    print(json["past"]);
    print(json["upcoming"]);
    print('=======================================================================');
    final data = UserReservationModel(
      past: List<ReservationModel>.from(json["past"].map((x) => ReservationModel.fromJson(x))),
      upcoming: List<ReservationModel>.from(json["upcoming"].map((x) => ReservationModel.fromJson(x))),
    );
    return data;
  }

  Map<String, dynamic> toJson() => {
    "past": List<dynamic>.from(past.map((x) => x.toJson())),
    "upcoming": List<dynamic>.from(upcoming.map((x) => x.toJson())),
  };
}


class ReservationModel {
  int id;
  UnitModel unit;
  User user;
  String arrivalDateTime;
  String leavingDateTime;
  String subtotal;
  String vat;
  String total;
  int rating;
  List<String> paymentMethods;

  ReservationModel({
    required this.id,
    required this.unit,
    required this.user,
    required this.arrivalDateTime,
    required this.leavingDateTime,
    required this.subtotal,
    required this.vat,
    required this.total,
    required this.rating,
    required this.paymentMethods,
  });

  ReservationModel copyWith({
    int? id,
    int? rating,
    UnitModel? unit,
    User? user,
    String? arrivalDateTime,
    String? leavingDateTime,
    List<String>? paymentMethods,
  }) =>
      ReservationModel(
        id: id ?? this.id,
        rating: rating ?? this.rating,
        unit: unit ?? this.unit,
        user: user ?? this.user,
        paymentMethods: paymentMethods ?? this.paymentMethods,
        arrivalDateTime: arrivalDateTime ?? this.arrivalDateTime,
        leavingDateTime: leavingDateTime ?? this.leavingDateTime,
        subtotal: subtotal,
        vat: vat,
        total: total,
      );

  factory ReservationModel.fromRawJson(String str) => ReservationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReservationModel.fromJson(Map<String, dynamic> json) => ReservationModel(
    id: json["id"],
    rating: json["rating"]??0,
    unit: UnitModel.fromJson(json["unit"]),
    user: User.fromJson(json["user"]),
    arrivalDateTime: json["arrival_date_time"].toString().substring(0,json["arrival_date_time"].toString().length-6) ,
    leavingDateTime: json["leaving_date_time"].toString().substring(0,json["leaving_date_time"].toString().length-6) ,
    // leavingDateTime: json["leaving_date_time"]?? DateTime.now().add(Duration(days: 2)),
    subtotal: json["subtotal"]??'0',
    vat: json["vat"]??'0',
    total: json["total"]??'0',
    paymentMethods: json["payment_methods"] == null ? [] : List<String>.from(json["payment_methods"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "unit": unit.toJson(),
    "user": user.toJson(),
    "arrival_date_time": arrivalDateTime,
    "leaving_date_time": leavingDateTime,
    "subtotal": subtotal,
    "vat": vat,
    "total": total,
    "payment_methods": List<String>.from(paymentMethods.map((x) => x)),
  };

}
