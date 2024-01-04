
class CategoryModel {
  int? id;
  String? name;
  String? img;
  String? serviceName;
  List<CategoryModel>? subCategories;
  String? tin;
  bool? isApplicableForVat;
  int? vat;
  int? unitsCount;

  CategoryModel({
     this.id,
     this.name,
     this.img,
     this.serviceName,
    this.subCategories,
    this.vat,
    this.isApplicableForVat,
    this.tin,
    this.unitsCount,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? img,
    String? serviceName,
    List<CategoryModel>? subCategories,
    String? tin,
    bool? isApplicableForVat,
    int? vat,
    int? unitsCount,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        img: img ?? this.img,
        serviceName: serviceName ?? this.serviceName,
        subCategories: subCategories ?? this.subCategories,
        tin: tin ?? this.tin,
        isApplicableForVat: isApplicableForVat ?? this.isApplicableForVat,
        vat: vat ?? this.vat,
        unitsCount: unitsCount ?? this.unitsCount,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"]??-1,
    name: json["name"]??'',
    img: json["icon"]??'',
    serviceName: json["service_name"]??'',
    tin: json["tin"]??'',
    vat: json["vat"]??0,
    unitsCount: json["units_count"]??0,
    isApplicableForVat: json["is_applicable_for_vat"]??false,
    subCategories: json["sub_categories"] == null?[] : List<CategoryModel>.from(json["sub_categories"].map((c)=>CategoryModel.fromJson(c))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tin": tin,
    "vat": vat,
    "is_applicable_for_vat": isApplicableForVat,
    "name": name,
    "icon": img,
    "service_name": serviceName,
    "sub_categories": subCategories,
    "units_count": unitsCount,
  };
}