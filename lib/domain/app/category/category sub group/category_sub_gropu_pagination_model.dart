import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/categories/links_model.dart';
import 'package:zcart_seller/domain/app/category/categories/meta_model.dart';
import 'package:zcart_seller/domain/app/category/category%20sub%20group/category_sub_group_model.dart';

class CategorySubGropuPaginationModel extends Equatable {
  final List<CategorySubGroupModel> data;
  final Links links;
  final Meta meta;

  const CategorySubGropuPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  CategorySubGropuPaginationModel copyWith({
    List<CategorySubGroupModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return CategorySubGropuPaginationModel(
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

  factory CategorySubGropuPaginationModel.fromMap(Map<String, dynamic> map) {
    return CategorySubGropuPaginationModel(
      data: List<CategorySubGroupModel>.from(
          map["data"].map((x) => CategorySubGroupModel.fromMap(x))),
      links: Links.fromJson(map["links"]),
      meta: Meta.fromJson(map["meta"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySubGropuPaginationModel.fromJson(String source) =>
      CategorySubGropuPaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory CategorySubGropuPaginationModel.init() =>
      const CategorySubGropuPaginationModel(
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
