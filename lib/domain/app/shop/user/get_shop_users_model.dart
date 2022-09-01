import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetShopUsersModel extends Equatable {
  final List data;
  const GetShopUsersModel({
    required this.data,
  });

  GetShopUsersModel copyWith({
    List? data,
  }) {
    return GetShopUsersModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory GetShopUsersModel.fromMap(Map<String, dynamic> map) {
    return GetShopUsersModel(
      data: List.from(map['data'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetShopUsersModel.fromJson(String source) =>
      GetShopUsersModel.fromMap(json.decode(source));

  @override
  String toString() => 'GetShopUsersModel(data: $data)';

  @override
  List<Object> get props => [data];
  factory GetShopUsersModel.init() => const GetShopUsersModel(data: []);

  static from(map) {}
}
