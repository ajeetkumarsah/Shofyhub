import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/order%20management/cancellation/cancellation_model.dart';
import 'package:zcart_seller/domain/app/category/categories/links_model.dart';
import 'package:zcart_seller/domain/app/category/categories/meta_model.dart';

class CancellationPaginationModel extends Equatable {
  final List<CancellationModel> data;
  final Links links;
  final Meta meta;

  const CancellationPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  CancellationPaginationModel copyWith({
    List<CancellationModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return CancellationPaginationModel(
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

  factory CancellationPaginationModel.fromMap(Map<String, dynamic> map) {
    return CancellationPaginationModel(
      data: List<CancellationModel>.from(
          map["data"].map((x) => CancellationModel.fromMap(x))),
      links: Links.fromJson(map["links"]),
      meta: Meta.fromJson(map["meta"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory CancellationPaginationModel.fromJson(String source) =>
      CancellationPaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory CancellationPaginationModel.init() => CancellationPaginationModel(
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
