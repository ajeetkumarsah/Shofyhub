import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/product/product_model.dart';
import 'package:alpesportif_seller/domain/app/category/categories/links_model.dart';
import 'package:alpesportif_seller/domain/app/category/categories/meta_model.dart';

class ProductPaginationModel extends Equatable {
  final List<ProductModel> data;
  final Links links;
  final Meta meta;

  const ProductPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  ProductPaginationModel copyWith({
    List<ProductModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return ProductPaginationModel(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
      "links": links.toJson(),
      "meta": meta.toJson(),
    };
  }

  factory ProductPaginationModel.fromMap(Map<String, dynamic> map) {
    return ProductPaginationModel(
      data: List<ProductModel>.from(
          map["data"].map((x) => ProductModel.fromMap(x))),
      links: map["links"] != null ? Links.fromJson(map["links"]) : Links.init(),
      meta: map["meta"] != null ? Meta.fromJson(map["meta"]) : Meta.init(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPaginationModel.fromJson(String source) =>
      ProductPaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory ProductPaginationModel.init() => const ProductPaginationModel(
        data: [],
        links: Links(),
        meta: Meta(currentPage: 1, lastPage: 1),
      );

  @override
  List<Object?> get props => [
        data,
        links,
        meta,
      ];
}
