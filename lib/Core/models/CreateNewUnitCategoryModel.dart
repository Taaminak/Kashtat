class CreateNewUnitCategoryModel {
  final String name;
  final String img;
  final int categoryId;
  final int? subCategoryId;
  final String serviceText;

  CreateNewUnitCategoryModel({
    required this.name,
    required this.img,
    required this.serviceText,
    required this.categoryId,
    this.subCategoryId,
  });


  Map<String, dynamic> toJson() => {
    "name": name,
    "img": img,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "serviceName": serviceText,
  };
}
