import 'package:kashtat/Core/models/UnitModel.dart';

class ProviderCategoriesWithUnits{
  String name;
  int categoryId;
  List<UnitModel> units;

  ProviderCategoriesWithUnits({required this.name, required this.units, required this.categoryId});


  Map<String, dynamic> toJson() => {
    "categoryName": name,
    "categoryId": categoryId,
    "units": List<dynamic>.from(units.map((x) => x.toJson())),
  };

}
