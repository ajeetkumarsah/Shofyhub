import 'package:equatable/equatable.dart';

class RoleModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final dynamic public;
  final int level;

  const RoleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.public,
    required this.level,
  });

  RoleModel copyWith({
    int? id,
    String? name,
    String? description,
    dynamic public,
    int? level,
  }) {
    return RoleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      public: public,
      level: level ?? this.level,
    );
  }

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      id: map["id"]?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      public: map['public'],
      level: map['level']?.toInt() ?? 0,
    );
  }

  factory RoleModel.init() => const RoleModel(
        id: 0,
        name: '',
        description: '',
        public: false,
        level: 0,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        public,
        level,
      ];
}
