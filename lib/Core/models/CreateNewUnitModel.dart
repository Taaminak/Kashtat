import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class CreateUnitBody {
  String? name;
  int? stateId;
  int? categoryId;
  int? subCategoryId;
  int? priceThursday;
  int? priceFriday;
  int? priceSaturday;
  int? priceOthers;
  MultipartFile? mainPic;
  List<MultipartFile>? pics;
  String? description;
  double? latitude;
  double? longitude;
  int? capacity;
  String? arrivalDate;
  String? leavingDate;
  String? cancellationPolicy;
  String? reservationRoles;
  String? instruction1;
  String? instruction2;
  MultipartFile? instructionImage;


  CreateUnitBody({
    this.name,
    this.stateId,
    this.categoryId,
    this.subCategoryId,
    this.priceThursday,
    this.priceFriday,
    this.priceSaturday,
    this.priceOthers,
    this.mainPic,
    this.pics,
    this.description,
    this.latitude,
    this.longitude,
    this.capacity,
    this.arrivalDate,
    this.leavingDate,
    this.cancellationPolicy,
    this.reservationRoles,
    this.instruction1,
    this.instruction2,
    this.instructionImage,
  });

  CreateUnitBody copyWith({
    String? name,
    int? stateId,
    int? categoryId,
    int? subCategoryId,
    int? priceThursday,
    int? priceFriday,
    int? priceSaturday,
    int? priceOthers,
    MultipartFile? mainPic,
    List<MultipartFile>? pics,
    String? description,
    double? latitude,
    double? longitude,
    int? capacity,
    String? arrivalDate,
    String? leavingDate,
    String? cancellationPolicy,
    String? reservationRoles,
    String? instruction1,
    String? instruction2,
    MultipartFile? instructionImage,
  }) =>
      CreateUnitBody(
        name: name ?? this.name,
        stateId: stateId ?? this.stateId,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId:  subCategoryId == -1 ? null : subCategoryId ?? this.subCategoryId,
        priceThursday: priceThursday ?? this.priceThursday,
        priceFriday: priceFriday ?? this.priceFriday,
        priceSaturday: priceSaturday ?? this.priceSaturday,
        priceOthers: priceOthers ?? this.priceOthers,
        mainPic: mainPic ?? this.mainPic,
        pics: pics ?? this.pics,
        description: description ?? this.description,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        capacity: capacity ?? this.capacity,
        arrivalDate: arrivalDate??this.arrivalDate,
        leavingDate: leavingDate??this.leavingDate,
        cancellationPolicy: cancellationPolicy??this.cancellationPolicy,
        instruction1: instruction1??this.instruction1,
        instruction2: instruction2?? this.instruction2,
        instructionImage:instructionImage?? this.instructionImage,
        reservationRoles:reservationRoles?? this.reservationRoles,
      );

  Map<String, dynamic> toJson() {

    Map<String, dynamic> body = {
      "name": name,
      "state_id": stateId,
      "category_id": categoryId,
      if(subCategoryId!=null) "sub_category_id": subCategoryId,
      "price[thursday]": priceThursday,
      "price[friday]": priceFriday,
      "price[saturday]": priceSaturday,
      "price[others]": priceOthers,
      "available_dates[0]": '2023-12-01',
      "main_pic": mainPic,
      "description": description,
      "latitude": latitude,
      "longitude": longitude,
      "capacity": capacity,
      "check_in": arrivalDate,
      "check_out": leavingDate,
      "cancellation_and_refund_policy": cancellationPolicy,
      "reservations_terms": reservationRoles,
      "arrival_policy": instruction1,
      "other_arrival_policy": instruction2,
      "arrival_policy_pic": instructionImage,
    };

    if(pics != null){
      for(int i = 0; i<pics!.length ; i++){
        body['pics[$i]'] = pics![i];
      }
    }
    return body;
  }
}

enum UpdateType{
  status,
  nameAndDetails,
  cityAndState,
  mapLocation,
  photos,
  categories,
  dates,
  pricing,
  times,
  returnAndCancellationPolicy,
  reservationRoles,
  arrivalInstructions,
}
