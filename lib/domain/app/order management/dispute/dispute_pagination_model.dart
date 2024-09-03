import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/order%20management/dispute/dispute_mode.dart';
import 'package:alpesportif_seller/domain/app/category/categories/links_model.dart';
import 'package:alpesportif_seller/domain/app/category/categories/meta_model.dart';

class DisputePaginationModel extends Equatable {
  final List<DisputeModel> data;
  final Links links;
  final Meta meta;

  const DisputePaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  DisputePaginationModel copyWith({
    List<DisputeModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return DisputePaginationModel(
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

  factory DisputePaginationModel.fromMap(Map<String, dynamic> map) {
    return DisputePaginationModel(
      data: List<DisputeModel>.from(
          map["data"].map((x) => DisputeModel.fromMap(x))),
      links: Links.fromJson(map["links"]),
      meta: Meta.fromJson(map["meta"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory DisputePaginationModel.fromJson(String source) =>
      DisputePaginationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory DisputePaginationModel.init() => const DisputePaginationModel(
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
