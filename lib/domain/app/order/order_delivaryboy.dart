import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderDelivaryBoyModel extends Equatable {
  final int id;
  final String niceName;
  final String phoneNumber;
  final String status;
  final int active;
  final String avatar;
  const OrderDelivaryBoyModel({
    required this.id,
    required this.niceName,
    required this.phoneNumber,
    required this.status,
    required this.active,
    required this.avatar,
  });

  OrderDelivaryBoyModel copyWith({
    int? id,
    String? niceName,
    String? phoneNumber,
    String? status,
    int? active,
    String? avatar,
  }) {
    return OrderDelivaryBoyModel(
      id: id ?? this.id,
      niceName: niceName ?? this.niceName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      active: active ?? this.active,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nice_name': niceName,
      'phone_number': phoneNumber,
      'status': status,
      'active': active,
      'avatar': avatar,
    };
  }

  factory OrderDelivaryBoyModel.fromMap(Map<String, dynamic> map) {
    return OrderDelivaryBoyModel(
      id: map['id']?.toInt() ?? 0,
      niceName: map['nice_name'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      status: map['status'] ?? '',
      active: map['active']?.toInt() ?? 0,
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDelivaryBoyModel.fromJson(String source) =>
      OrderDelivaryBoyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDelivaryBoyModel(id: $id, niceName: $niceName, phoneNumber: $phoneNumber, status: $status, active: $active, avatar: $avatar)';
  }

  @override
  List<Object> get props {
    return [
      id,
      niceName,
      phoneNumber,
      status,
      active,
      avatar,
    ];
  }

  factory OrderDelivaryBoyModel.init() => const OrderDelivaryBoyModel(
      id: 0, niceName: '', phoneNumber: '', status: '', active: 0, avatar: '');
}
