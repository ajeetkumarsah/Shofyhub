import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:zcart_vendor/domain/app/catalog/atributes/get_atributes_model.dart/classes/attribute_type_class.dart';
import 'package:zcart_vendor/domain/app/catalog/atributes/get_atributes_model.dart/classes/categories_class.dart';
import 'package:zcart_vendor/domain/app/catalog/atributes/get_atributes_model.dart/classes/values_class.dart';

class GetAtributesModel extends Equatable {
  final int id;
  final String name;
  final AttributeTypeClass atributeType;
  final List<ValuesClass> values;
  final List<CategoriesClass> categories;
  final int order;
  const GetAtributesModel({
    required this.id,
    required this.name,
    required this.atributeType,
    required this.values,
    required this.categories,
    required this.order,
  });

  GetAtributesModel copyWith({
    int? id,
    String? name,
    AttributeTypeClass? atributeType,
    List<ValuesClass>? values,
    List<CategoriesClass>? categories,
    int? order,
  }) {
    return GetAtributesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      atributeType: atributeType ?? this.atributeType,
      values: values ?? this.values,
      categories: categories ?? this.categories,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'atribute_type': atributeType.toMap(),
      'values': values.map((x) => x.toMap()).toList(),
      'categories': categories.map((x) => x.toMap()).toList(),
      'order': order,
    };
  }

  factory GetAtributesModel.fromMap(Map<String, dynamic> map) {
    return GetAtributesModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      atributeType: AttributeTypeClass.fromMap(map['atribute_type']),
      values: List<ValuesClass>.from(
          map['values']?.map((x) => ValuesClass.fromMap(x)) ?? const []),
      categories: List<CategoriesClass>.from(
          map['categories']?.map((x) => CategoriesClass.fromMap(x)) ??
              const []),
      order: map['order']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAtributesModel.fromJson(String source) =>
      GetAtributesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetAtributesModeel(id: $id, name: $name, atributeType: $atributeType, values: $values, categories: $categories, order: $order)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      atributeType,
      values,
      categories,
      order,
    ];
  }

  factory GetAtributesModel.init() => GetAtributesModel(
        id: 0,
        name: '',
        atributeType: AttributeTypeClass.init(),
        values: [ValuesClass.init()],
        categories: [CategoriesClass.init()],
        order: 0,
      );

  static from(map) {}
}
