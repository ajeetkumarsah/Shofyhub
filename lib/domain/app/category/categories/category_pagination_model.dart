import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/categories/category_model.dart';

import 'links_model.dart';
import 'meta_model.dart';

class CategoryPaginationModel extends Equatable {
  final List<CategoryModel> data;
  final Links links;
  final Meta meta;

  const CategoryPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  CategoryPaginationModel copyWith({
    List<CategoryModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return CategoryPaginationModel(
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

  factory CategoryPaginationModel.fromMap(Map<String, dynamic> map) {
    return CategoryPaginationModel(
      data: List<CategoryModel>.from(
          map["data"].map((x) => CategoryModel.fromMap(x))),
      links: map["links"] != null ? Links.fromJson(map["links"]) : Links.init(),
      meta: map["meta"] != null ? Meta.fromJson(map["meta"]) : Meta.init(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryPaginationModel.fromJson(String source) =>
      CategoryPaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;


  factory CategoryPaginationModel.init() => const CategoryPaginationModel(
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
