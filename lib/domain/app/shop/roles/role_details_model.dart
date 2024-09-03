import 'package:equatable/equatable.dart';
import 'package:alpesportif_seller/domain/app/shop/roles/permission_model.dart';

class RoleDetailsModel extends Equatable {
  final int id;
  final String name;
  final int shopId;
  final String description;
  final dynamic public;
  final int level;
  final List<PermissionModel> permissions;

  const RoleDetailsModel({
    required this.id,
    required this.name,
    required this.shopId,
    required this.description,
    required this.public,
    required this.level,
    required this.permissions,
  });

  RoleDetailsModel copyWith({
    int? id,
    String? name,
    int? shopId,
    String? description,
    dynamic public,
    int? level,
    List<PermissionModel>? permissions,
  }) {
    return RoleDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shopId: shopId ?? this.shopId,
      description: description ?? this.description,
      public: public ?? this.public,
      level: level ?? this.level,
      permissions: permissions ?? this.permissions,
    );
  }

  factory RoleDetailsModel.fromMap(Map<String, dynamic> map) {
    return RoleDetailsModel(
      id: map["id"]?.toInt() ?? 0,
      name: map['name'] ?? '',
      shopId: map["shop_id"]?.toInt() ?? 0,
      description: map['description'] ?? '',
      public: map['public'],
      level: map['level']?.toInt() ?? 0,
      permissions: List<PermissionModel>.from(
          map["permissions"].map((x) => PermissionModel.fromMap(x))),
    );
  }

  factory RoleDetailsModel.init() => const RoleDetailsModel(
      id: 0,
      name: '',
      shopId: 0,
      description: '',
      public: false,
      level: 0,
      permissions: []);

  @override
  List<Object?> get props => [
        id,
        name,
        shopId,
        description,
        public,
        level,
        permissions,
      ];
}
