// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Items extends Equatable {
  final int id;
  final String slug;
  final String description;
  final int quantity;
  final String unit_price;
  final String total;
  final String image;
  const Items({
    required this.id,
    required this.slug,
    required this.description,
    required this.quantity,
    required this.unit_price,
    required this.total,
    required this.image,
  });

  Items copyWith({
    int? id,
    String? slug,
    String? description,
    int? quantity,
    String? unit_price,
    String? total,
    String? image,
  }) {
    return Items(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unit_price: unit_price ?? this.unit_price,
      total: total ?? this.total,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'slug': slug,
      'description': description,
      'quantity': quantity,
      'unit_price': unit_price,
      'total': total,
      'image': image,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['id'] as int,
      slug: map['slug'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
      unit_price: map['unit_price'] as String,
      total: map['total'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) =>
      Items.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      slug,
      description,
      quantity,
      unit_price,
      total,
      image,
    ];
  }
}
