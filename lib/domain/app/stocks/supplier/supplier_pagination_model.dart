import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/category/categories/links_model.dart';
import 'package:zcart_seller/domain/app/category/categories/meta_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_model.dart';

class SupplierPaginationModel extends Equatable {
  final List<SupplierModel> data;
  final Links links;
  final Meta meta;

  const SupplierPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  SupplierPaginationModel copyWith({
    List<SupplierModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return SupplierPaginationModel(
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

  factory SupplierPaginationModel.fromMap(Map<String, dynamic> map) {
    return SupplierPaginationModel(
      data: List<SupplierModel>.from(
          map["data"].map((x) => SupplierModel.fromMap(x))),
      links: map["links"] != null ? Links.fromJson(map["links"]) : Links.init(),
      meta: map["meta"] != null ? Meta.fromJson(map["meta"]) : Meta.init(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplierPaginationModel.fromJson(String source) =>
      SupplierPaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory SupplierPaginationModel.init() => const SupplierPaginationModel(
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
