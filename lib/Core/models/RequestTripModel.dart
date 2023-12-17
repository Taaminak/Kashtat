import 'dart:convert';

class RequestTripModel {
  String? notes = '';
  int? cityId  = -1;
  int? paymentGatewayId =-1;
  String? arrivalDateTime='';
  String? leavingDateTime='';
  double? subtotal=0;
  double? vat=0;
  double? total=0;
  num? latitude=-1;
  num? longitude=-1;
  int? numberOfPersons=0;
  int? unitId=-1;

  RequestTripModel({
    this.notes,
    this.cityId,
    this.paymentGatewayId,
    this.arrivalDateTime,
    this.leavingDateTime,
    this.subtotal,
    this.vat,
    this.total,
    this.latitude,
    this.longitude,
    this.numberOfPersons,
    this.unitId,
  });

  RequestTripModel copyWith({
    String? notes,
    int? cityId,
    int? paymentGatewayId,
    String? arrivalDateTime,
    String? leavingDateTime,
    double? subtotal,
    double? vat,
    double? total,
    num? latitude,
    num? longitude,
    int? numberOfPersons,
    int? unitId,
  }) =>
      RequestTripModel(
        notes: notes ?? this.notes,
        cityId: cityId ?? this.cityId,
        paymentGatewayId: paymentGatewayId ?? this.paymentGatewayId,
        arrivalDateTime: arrivalDateTime ?? this.arrivalDateTime,
        leavingDateTime: leavingDateTime ?? this.leavingDateTime,
        subtotal: subtotal ?? this.subtotal,
        vat: vat ?? this.vat,
        total: total ?? this.total,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        numberOfPersons: numberOfPersons ?? this.numberOfPersons,
        unitId: unitId ?? this.unitId,
      );

  factory RequestTripModel.fromRawJson(String str) =>
      RequestTripModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestTripModel.fromJson(Map<String, dynamic> json) =>
      RequestTripModel(
        notes: json["notes"],
        cityId: json["city_id"],
        paymentGatewayId: json["payment_gateway_id"],
        arrivalDateTime: json["arrival_date_time"],
        leavingDateTime: json["leaving_date_time"],
        subtotal: json["subtotal"],
        vat: json["vat"],
        total: json["total"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        numberOfPersons: json["number_of_persons"],
        unitId: json["unit_id"],
      );

  Map<String, dynamic> toJson() => {
        "notes": notes,
        "city_id": cityId,
        "payment_gateway_id": paymentGatewayId,
        "arrival_date_time": arrivalDateTime,
        "leaving_date_time": leavingDateTime,
        "subtotal": subtotal,
        "vat": vat,
        "total": total,
        "latitude": latitude,
        "longitude": longitude,
        "number_of_persons": numberOfPersons,
        "unit_id": unitId,
      };
}
