import 'dart:convert';

import 'package:equatable/equatable.dart';

class ImagesModel extends Equatable {
  final int id;
  final String path;
  final String name;
  final String extension;
  final int order;
  final String featured;
  const ImagesModel({
    required this.id,
    required this.path,
    required this.name,
    required this.extension,
    required this.order,
    required this.featured,
  });

  ImagesModel copyWith({
    int? id,
    String? path,
    String? name,
    String? extension,
    int? order,
    String? featured,
  }) {
    return ImagesModel(
      id: id ?? this.id,
      path: path ?? this.path,
      name: name ?? this.name,
      extension: extension ?? this.extension,
      order: order ?? this.order,
      featured: featured ?? this.featured,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'name': name,
      'extension': extension,
      'order': order,
      'featured': featured,
    };
  }

  factory ImagesModel.fromMap(Map<String, dynamic> map) {
    return ImagesModel(
      id: map['id']?.toInt() ?? 0,
      path: map['path'] ?? '',
      name: map['name'] ?? '',
      extension: map['extension'] ?? '',
      order: map['order']?.toInt() ?? 0,
      featured: map['featured'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesModel.fromJson(String source) =>
      ImagesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImagesModel(id: $id, path: $path, name: $name, extension: $extension, order: $order, featured: $featured)';
  }

  @override
  List<Object> get props {
    return [
      id,
      path,
      name,
      extension,
      order,
      featured,
    ];
  }

  factory ImagesModel.init() => const ImagesModel(
        id: 0,
        path: '',
        name: '',
        extension: '',
        order: 0,
        featured: '',
      );
}
