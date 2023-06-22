class SearchProductModel {
  int? id;
  String? slug;
  String? name;
  Map<String, String>? categories;
  String? modelNumber;
  String? gtin;
  String? gtinType;
  String? mpn;
  String? brand;
  String? availableFrom;
  String? image;

  SearchProductModel({
    this.id,
    this.slug,
    this.name,
    this.categories,
    this.modelNumber,
    this.gtin,
    this.gtinType,
    this.mpn,
    this.brand,
    this.availableFrom,
    this.image,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      SearchProductModel(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        categories: Map.from(json["categories"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
        modelNumber: json["model_number"],
        gtin: json["gtin"],
        gtinType: json["gtin_type"],
        mpn: json["mpn"],
        brand: json["brand"],
        availableFrom: json["available_from"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "categories": Map.from(categories!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "model_number": modelNumber,
        "gtin": gtin,
        "gtin_type": gtinType,
        "mpn": mpn,
        "brand": brand,
        "available_from": availableFrom,
        "image": image,
      };
}
