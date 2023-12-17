// To parse this JSON data, do
//
//     final financialSummaryModel = financialSummaryModelFromJson(jsonString);

import 'dart:convert';

import 'package:kashtat/Core/models/ReservationModel.dart';

FinancialSummaryModel financialSummaryModelFromJson(String str) => FinancialSummaryModel.fromJson(json.decode(str));

String financialSummaryModelToJson(FinancialSummaryModel data) => json.encode(data.toJson());

class FinancialSummaryModel {
  final FinancialData? data;

  FinancialSummaryModel({
    this.data,
  });

  FinancialSummaryModel copyWith({
    FinancialData? data,
  }) =>
      FinancialSummaryModel(
        data: data ?? this.data,
      );

  factory FinancialSummaryModel.fromJson(Map<String, dynamic> json) => FinancialSummaryModel(
    data: json["data"] == null ? null : FinancialData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class FinancialData {
  final double? sales;
  final double? commissions;
  final double? netProfit;
  final int? reservationsCount;
  final List<ReservationModel>? reservations;

  FinancialData({
    this.sales,
    this.commissions,
    this.netProfit,
    this.reservationsCount,
    this.reservations,
  });

  FinancialData copyWith({
    double? sales,
    double? commissions,
    double? netProfit,
    final int? reservationsCount,
    final List<ReservationModel>? reservations,
  }) =>
      FinancialData(
        sales: sales ?? this.sales,
        commissions: commissions ?? this.commissions,
        netProfit: netProfit ?? this.netProfit,
        reservationsCount: reservationsCount ?? this.reservationsCount,
        reservations: reservations ?? this.reservations,
      );

  factory FinancialData.fromJson(Map<String, dynamic> json) => FinancialData(
    sales: json["sales"]??0.0,
    commissions: json["commissions"]??0.0,
    netProfit: json["net_profit"]??0.0,
    reservationsCount: json["reservations_count"],
    reservations: json["reservations"] == null ? [] : List<ReservationModel>.from(json["reservations"]!.map((x) => ReservationModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sales": sales,
    "commissions": commissions,
    "net_profit": netProfit,
    "reservations_count": reservationsCount,
    "reservations": reservations == null ? [] : List<ReservationModel>.from(reservations!.map((x) => x.toJson())),
  };
}
