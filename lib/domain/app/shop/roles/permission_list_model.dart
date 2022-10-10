import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/shop/roles/permission_model.dart';

class PermissionListModel extends Equatable {
  final int id;
  final String name;
  final String access;
  final String description;
  final String actions;
  final int active;
  final List<PermissionModel> permissions;

  const PermissionListModel({
    required this.id,
    required this.name,
    required this.access,
    required this.description,
    required this.actions,
    required this.active,
    required this.permissions,
  });

  PermissionListModel copyWith({
    int? id,
    String? name,
    String? access,
    String? description,
    String? actions,
    int? active,
    List<PermissionModel>? permissions,
  }) {
    return PermissionListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      access: access ?? this.access,
      description: description ?? this.description,
      actions: actions ?? this.actions,
      active: active ?? this.active,
      permissions: permissions ?? this.permissions,
    );
  }

  factory PermissionListModel.fromMap(Map<String, dynamic> map) {
    return PermissionListModel(
      id: map["id"]?.toInt() ?? 0,
      name: map['name'] ?? '',
      access: map['access'] ?? '',
      description: map['description'] ?? '',
      actions: map['actions'] ?? '',
      active: map["active"]?.toInt() ?? 0,
      permissions: List<PermissionModel>.from(
          map["permissions"].map((x) => PermissionModel.fromMap(x))),
    );
  }

  factory PermissionListModel.init() => const PermissionListModel(
        id: 0,
        name: '',
        access: '',
        description: '',
        actions: '',
        active: 0,
        permissions: [],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        access,
        description,
        actions,
        active,
        permissions,
      ];
}
