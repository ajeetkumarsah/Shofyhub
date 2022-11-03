import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/categories/links_model.dart';
import 'package:zcart_seller/domain/app/category/categories/meta_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';

class WarehousePaginationModel extends Equatable {
  final List<WarehouseModel> data;
  final Links links;
  final Meta meta;

  const WarehousePaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  WarehousePaginationModel copyWith({
    List<WarehouseModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return WarehousePaginationModel(
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

  factory WarehousePaginationModel.fromMap(Map<String, dynamic> map) {
    return WarehousePaginationModel(
      data: List<WarehouseModel>.from(
          map["data"].map((x) => WarehouseModel.fromMap(x))),
      links: Links.fromJson(map["links"]),
      meta: Meta.fromJson(map["meta"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehousePaginationModel.fromJson(String source) =>
      WarehousePaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory WarehousePaginationModel.init() => const WarehousePaginationModel(
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
