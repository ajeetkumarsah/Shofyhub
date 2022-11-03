import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/categories/links_model.dart';
import 'package:zcart_seller/domain/app/category/categories/meta_model.dart';
import 'package:zcart_seller/domain/app/stocks/inventories/inventories_model.dart';

class InventoryPaginationModel extends Equatable {
  final List<InventoriesModel> data;
  final Links links;
  final Meta meta;

  const InventoryPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  InventoryPaginationModel copyWith({
    List<InventoriesModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return InventoryPaginationModel(
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

  factory InventoryPaginationModel.fromMap(Map<String, dynamic> map) {
    return InventoryPaginationModel(
      data: List<InventoriesModel>.from(
          map["data"].map((x) => InventoriesModel.fromMap(x))),
      links: Links.fromJson(map["links"]),
      meta: Meta.fromJson(map["meta"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryPaginationModel.fromJson(String source) =>
      InventoryPaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory InventoryPaginationModel.init() => const InventoryPaginationModel(
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
