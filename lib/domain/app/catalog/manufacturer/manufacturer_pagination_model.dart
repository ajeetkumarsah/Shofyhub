import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/catalog/manufacturer/manufacturer_model.dart';
import 'package:zcart_seller/domain/app/category/categories/links_model.dart';
import 'package:zcart_seller/domain/app/category/categories/meta_model.dart';

class ManufacturerPaginationModel extends Equatable {
  final List<ManufacturerModel> data;
  final Links links;
  final Meta meta;

  const ManufacturerPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  ManufacturerPaginationModel copyWith({
    List<ManufacturerModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return ManufacturerPaginationModel(
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

  factory ManufacturerPaginationModel.fromMap(Map<String, dynamic> map) {
    return ManufacturerPaginationModel(
      data: List<ManufacturerModel>.from(
          map["data"].map((x) => ManufacturerModel.fromMap(x))),
      links: Links.fromJson(map["links"]),
      meta: Meta.fromJson(map["meta"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory ManufacturerPaginationModel.fromJson(String source) =>
      ManufacturerPaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory ManufacturerPaginationModel.init() =>
      const ManufacturerPaginationModel(
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
