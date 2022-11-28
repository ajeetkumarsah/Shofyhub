import 'package:equatable/equatable.dart';

class ProductImageModel extends Equatable {
  final int id;
  final String path;
  final String name;
  final String extension;
  final int order;
  final int featured;

  const ProductImageModel({
    required this.id,
    required this.path,
    required this.name,
    required this.extension,
    required this.order,
    required this.featured,
  });

  ProductImageModel copyWith({
    int? id,
    String? path,
    String? name,
    String? extension,
    int? order,
    int? featured,
  }) {
    return ProductImageModel(
      id: id ?? this.id,
      path: path ?? this.path,
      name: name ?? this.name,
      extension: extension ?? this.extension,
      order: order ?? this.order,
      featured: featured ?? this.featured,
    );
  }

  factory ProductImageModel.fromMap(Map<String, dynamic> map) =>
      ProductImageModel(
        id: map["id"] ?? 0,
        path: map["path"] ?? '',
        name: map["name"] ?? '',
        extension: map["extension"] ?? '',
        order: map["order"] ?? '',
        featured: map["featured"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "path": path,
        "name": name,
        "extension": extension,
        "order": order,
        "featured": featured,
      };

  @override
  List<Object?> get props => [
        id,
        path,
        name,
        extension,
        order,
        featured,
      ];
}
