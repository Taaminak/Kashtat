
import 'BankModel.dart';

class BankAccountModel {
  final int? id;
  final BankModel? bank;
  final String? name;
  final String? iban;

  BankAccountModel({
    this.id,
    this.bank,
    this.name,
    this.iban,
  });

  BankAccountModel copyWith({
    int? id,
    BankModel? bank,
    String? name,
    String? iban,
  }) =>
      BankAccountModel(
        id: id ?? this.id,
        bank: bank ?? this.bank,
        name: name ?? this.name,
        iban: iban ?? this.iban,
      );

  factory BankAccountModel.fromJson(Map<String, dynamic> json) => BankAccountModel(
    id: json["id"],
    bank: json["bank"] == null ? null : BankModel.fromJson(json["bank"]),
    name: json["name"],
    iban: json["iban"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank": bank?.toJson(),
    "name": name,
    "iban": iban,
  };
}
