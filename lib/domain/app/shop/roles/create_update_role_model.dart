import 'package:equatable/equatable.dart';

class CreateUpdateRoleModel extends Equatable {
  final String name;
  final String description;
  final int level;
  final String permissions;

  const CreateUpdateRoleModel({
    required this.name,
    required this.description,
    required this.level,
    required this.permissions,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        level,
        permissions,
      ];
}
