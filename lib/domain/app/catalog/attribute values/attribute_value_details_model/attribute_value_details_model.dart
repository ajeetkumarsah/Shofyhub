// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/attribute_value_details_model/attribute_class.dart';

class AttributeValueDetailsModel extends Equatable {
  final int id;
  final String value;
  final String color;
  final int attributeId;
  final int order;
  final AttributeClass attribute;
  const AttributeValueDetailsModel({
    required this.id,
    required this.value,
    required this.color,
    required this.attributeId,
    required this.order,
    required this.attribute,
  });

  AttributeValueDetailsModel copyWith({
    int? id,
    String? value,
    String? color,
    int? attributeId,
    int? order,
    AttributeClass? attribute,
  }) {
    return AttributeValueDetailsModel(
      id: id ?? this.id,
      value: value ?? this.value,
      color: color ?? this.color,
      attributeId: attributeId ?? this.attributeId,
      order: order ?? this.order,
      attribute: attribute ?? this.attribute,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'color': color,
      'attribute_id': attributeId,
      'order': order,
      'attribute': attribute.toMap(),
    };
  }

  factory AttributeValueDetailsModel.fromMap(Map<String, dynamic> map) {
    return AttributeValueDetailsModel(
      id: map['id']?.toInt ?? 0,
      value: map['value'] ?? '',
      color: map['color'] ?? '',
      attributeId: map['attribute_id']?.toInt() ?? 0,
      order: map['order']?.toInt() ?? 0,
      attribute: AttributeClass.fromMap(map['attribute']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeValueDetailsModel.fromJson(String source) =>
      AttributeValueDetailsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      value,
      color,
      attributeId,
      order,
      attribute,
    ];
  }

  factory AttributeValueDetailsModel.init() => AttributeValueDetailsModel(
      id: 0,
      value: '',
      color: '',
      attributeId: 0,
      order: 0,
      attribute: AttributeClass.init());
}
