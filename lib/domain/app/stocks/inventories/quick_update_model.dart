import 'dart:convert';

import 'package:equatable/equatable.dart';

class QuickUpdateModel extends Equatable {
  final String title;
  final int quantity;
  final double salePrice;
  final int active;
  final String expiryDate;
  const QuickUpdateModel({
    required this.title,
    required this.quantity,
    required this.salePrice,
    required this.active,
    required this.expiryDate,
  });

  QuickUpdateModel copyWith({
    String? title,
    int? quantity,
    double? salePrice,
    int? active,
    String? expiryDate,
  }) {
    return QuickUpdateModel(
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      salePrice: salePrice ?? this.salePrice,
      active: active ?? this.active,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'quantity': quantity,
      'sale_price': salePrice,
      'active': active,
      'expiry_date': expiryDate,
    };
  }

  factory QuickUpdateModel.fromMap(Map<String, dynamic> map) {
    return QuickUpdateModel(
      title: map['title'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      salePrice: map['sale_price'] ?? 0.0,
      active: map['active']?.toInt() ?? 0,
      expiryDate: map['expiry_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory QuickUpdateModel.fromJson(String source) =>
      QuickUpdateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuickUpdateModel(title: $title, quantity: $quantity, salePrice: $salePrice, active: $active, expiryDate: $expiryDate)';
  }

  @override
  List<Object> get props {
    return [
      title,
      quantity,
      salePrice,
      active,
      expiryDate,
    ];
  }

  factory QuickUpdateModel.init() => const QuickUpdateModel(
        title: '',
        quantity: 0,
        salePrice: 0.0,
        active: 0,
        expiryDate: '',
      );
}
