import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/foundation.dart';
import 'package:kashtat/Core/models/CategoryModel.dart';
import 'package:kashtat/Core/models/CityModel.dart';
import 'package:kashtat/Core/models/StateModel.dart';
import 'package:kashtat/Core/models/UserModel.dart';

class UnitModel {
  final int? id;
  final String? name;
  final List<DateTime>? availableDates;
  final List<String>? reservedDates;
  final CategoryModel? category;
  final CategoryModel? subCategory;
  final User? provider;
  final int? capacity;
  final int? reservationsCount;
  final StateModel? state;
  final City? city;
  final double? latitude;
  final double? longitude;
  final Price? price;
  final List<String>? pics;
  final String? mainPic;
  final String? description;
  final String? arrivalTime;
  final String? leavingTime;
  final bool? isActive;
  final DateTime? createdAt;
  String? cancellationPolicy;
  String? reservationRoles;
  String? instruction1;
  String? instruction2;
  String? instructionImage;
  double? rate;

  double get subtotal => price == null ? 0.0:double.parse(price?.others??"0");
  double get vat => subtotal * 0.15;
  double get total => subtotal + vat;

  UnitModel({
    this.id,
    this.name,
    this.availableDates,
    this.reservedDates,
    this.category,
    this.subCategory,
    this.provider,
    this.capacity,
    this.reservationsCount,
    this.state,
    this.city,
    this.latitude,
    this.longitude,
    this.price,
    this.pics,
    this.mainPic,
    this.description,
    this.arrivalTime,
    this.leavingTime,
    this.isActive,
    this.createdAt,
    this.cancellationPolicy,
    this.reservationRoles,
    this.instruction1,
    this.instruction2,
    this.instructionImage,
    this.rate,
  });

  UnitModel copyWith({
    int? id,
    String? name,
    List<DateTime>? availableDates,
    List<String>? reservedDates,
    CategoryModel? category,
    CategoryModel? subCategory,
    User? provider,
    int? capacity,
    int? reservationsCount,
    StateModel? state,
    City? city,
    double? latitude,
    double? longitude,
    Price? price,
    List<String>? pics,
    String? mainPic,
    String? description,
    String? arrivalTime,
    String? leavingTime,
    bool? isActive,
    DateTime? createdAt,
    String? cancellationPolicy,
    String? reservationRoles,
    String? instruction1,
    String? instruction2,
    String? instructionImage,
    double? rate,
  }) =>
      UnitModel(
        id: id ?? this.id,
        name: name ?? this.name,
        availableDates: availableDates ?? this.availableDates,
        reservedDates: reservedDates ?? this.reservedDates,
        category: category ?? this.category,
        subCategory: subCategory ?? this.subCategory,
        provider: provider ?? this.provider,
        capacity: capacity ?? this.capacity,
        reservationsCount: reservationsCount ?? this.reservationsCount,
        state: state ?? this.state,
        city: city ?? this.city,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        price: price ?? this.price,
        pics: pics ?? this.pics,
        mainPic: mainPic ?? this.mainPic,
        description: description ?? this.description,
        arrivalTime: arrivalTime ?? this.arrivalTime,
        leavingTime: leavingTime ?? this.leavingTime,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        cancellationPolicy: cancellationPolicy??this.cancellationPolicy,
        instruction1: instruction1??this.instruction1,
        instruction2: instruction2?? this.instruction2,
        instructionImage:instructionImage?? this.instructionImage,
        reservationRoles: reservationRoles?? this.reservationRoles,
        rate: rate?? this.rate,
      );

  factory UnitModel.fromJson(Map<String, dynamic> json){
    List<String> allImgs = [];
    allImgs.add(json["main_pic"]??'');
    List<String> imgs = json["pics"] == null ? [] : (List<String>.from(json["pics"]!.map((x) => x)));
    allImgs.addAll(imgs);
    return UnitModel(
      id: json["id"],
      name: json["name"],
      availableDates: json["available_dates"] == null ? [] : List<DateTime>.from(json["available_dates"]!.map((x) => DateTime.parse(x))),
      reservedDates: json["reservations_dates"] == null ? [] : List<String>.from(json["reservations_dates"]!.map((x) => x)),
      category: json["category"] == null ? CategoryModel() : CategoryModel.fromJson(json["category"]),
      subCategory: json["sub_category"] == null ? CategoryModel() : CategoryModel.fromJson(json["sub_category"]),
      provider: json["provider"] == null ? User() : User.fromJson(json["provider"]),
      capacity: int.parse(json["capacity"]??"0"),
      reservationsCount: int.parse(json["reservations_count"]??'0'),
      state: json["state"] == null ? null : StateModel.fromJson(json["state"]),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
      latitude: json["latitude"]== null? 0.0: double.parse(json["latitude"].toString()),
      longitude: json["longitude"]== null? 0.0: double.parse(json["longitude"].toString()),
      // longitude: json["longitude"],
      price: json["price"] == null ? null : Price.fromJson(json["price"]),
      pics: allImgs,
      mainPic: json["main_pic"],
      description: json["description"]??'',
      arrivalTime: json["check_in"]??'',
      leavingTime: json["check_out"]??'',
      isActive: json["is_active"]??false,
      createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      cancellationPolicy: json["cancellation_and_refund_policy"]??'',
      reservationRoles: json["reservations_terms"]??'',
      instruction1: json["arrival_policy"]??'',
      instruction2: json["other_arrival_policy"]??'',
      instructionImage: json["arrival_policy_pic"]??'',
      rate: json["average_ratings"]==null?0.0:double.parse(json["average_ratings"].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "available_dates": availableDates == null ? [] : List<dynamic>.from(availableDates!.map((x) => "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
    "category": category?.toJson(),
    "sub_category": subCategory?.toJson(),
    "provider": provider?.toJson(),
    "capacity": capacity,
    "reservations_count": reservationsCount,
    "state": state?.toJson(),
    "city": city?.toJson(),
    "latitude": latitude,
    "longitude": longitude,
    "price": price?.toJson(),
    "pics": pics == null ? [] : List<dynamic>.from(pics!.map((x) => x)),
    "main_pic": mainPic,
    "description": description,
    "check_in": arrivalTime,
    "check_out": leavingTime,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "cancellation_and_refund_policy": cancellationPolicy,
    "reservations_terms": reservationRoles,
    "arrival_policy": instruction1,
    "other_arrival_policy": instruction2,
    "arrival_policy_pic": instructionImage,
    "average_ratings": rate,
  };
}

class Price {
  final String? friday;
  final String? others;
  final String? saturday;
  final String? thursday;

  Price({
    this.friday,
    this.others,
    this.saturday,
    this.thursday,
  });

  Price copyWith({
    String? friday,
    String? others,
    String? saturday,
    String? thursday,
  }) =>
      Price(
        friday: friday ?? this.friday,
        others: others ?? this.others,
        saturday: saturday ?? this.saturday,
        thursday: thursday ?? this.thursday,
      );

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    friday: json["friday"],
    others: json["others"],
    saturday: json["saturday"],
    thursday: json["thursday"],
  );

  Map<String, dynamic> toJson() => {
    "friday": friday,
    "others": others,
    "saturday": saturday,
    "thursday": thursday,
  };

}

class CalculatedPrice{
  double max;
  double min;
  double total;
  double average;

  CalculatedPrice({required this.max,required this.min, required this.total,required this.average});
}


