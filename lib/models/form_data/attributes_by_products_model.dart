import 'dart:convert';

Map<String, AttributesByProductModel> attributesByProductModelFromJson(
        String str) =>
    Map.from(json.decode(str)).map(
      (k, v) => MapEntry<String, AttributesByProductModel>(
        k,
        AttributesByProductModel.fromJson(v),
      ),
    );


class AttributesByProductModel {
  String? attribute;
  Map<String, String>? values;

  AttributesByProductModel({
    this.attribute,
    this.values,
  });

  factory AttributesByProductModel.fromJson(Map<String, dynamic> json) =>
      AttributesByProductModel(
        attribute: json["attribute"],
        values: Map.from(json["values"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "attribute": attribute,
        "values":
            Map.from(values!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
