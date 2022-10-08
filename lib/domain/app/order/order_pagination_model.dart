import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/order/order_model.dart';
import 'package:zcart_seller/domain/app/category/categories/links_model.dart';
import 'package:zcart_seller/domain/app/category/categories/meta_model.dart';

class OrderPaginationModel extends Equatable {
  final List<OrderModel> data;
  final Links links;
  final Meta meta;

  const OrderPaginationModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  OrderPaginationModel copyWith({
    List<OrderModel>? data,
    Links? links,
    Meta? meta,
  }) {
    return OrderPaginationModel(
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

  factory OrderPaginationModel.fromMap(Map<String, dynamic> map) {
    return OrderPaginationModel(
      data:
          List<OrderModel>.from(map["data"].map((x) => OrderModel.fromMap(x))),
      links: Links.fromJson(map["links"]),
      meta: Meta.fromJson(map["meta"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderPaginationModel.fromJson(String source) =>
      OrderPaginationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  factory OrderPaginationModel.init() => OrderPaginationModel(
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
