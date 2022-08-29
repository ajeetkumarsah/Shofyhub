import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateCategoryGroupModel extends Equatable {
  final String name;
  final String slug;
  final String desc;
  final String metaTitle;
  final String meatDesc;
  const CreateCategoryGroupModel({
    required this.name,
    required this.slug,
    required this.desc,
    required this.metaTitle,
    required this.meatDesc,
  });

  CreateCategoryGroupModel copyWith({
    String? name,
    String? slug,
    String? desc,
    String? metaTitle,
    String? meatDesc,
  }) {
    return CreateCategoryGroupModel(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      desc: desc ?? this.desc,
      metaTitle: metaTitle ?? this.metaTitle,
      meatDesc: meatDesc ?? this.meatDesc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'desc': desc,
      'meta_title': metaTitle,
      'meat_desc': meatDesc,
    };
  }

  factory CreateCategoryGroupModel.fromMap(Map<String, dynamic> map) {
    return CreateCategoryGroupModel(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      desc: map['desc'] ?? '',
      metaTitle: map['meta_title'] ?? '',
      meatDesc: map['meat_desc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateCategoryGroupModel.fromJson(String source) =>
      CreateCategoryGroupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateCategoryGroupModel(name: $name, slug: $slug, desc: $desc, metaTitle: $metaTitle, meatDesc: $meatDesc)';
  }

  @override
  List<Object> get props {
    return [
      name,
      slug,
      desc,
      metaTitle,
      meatDesc,
    ];
  }

  factory CreateCategoryGroupModel.init() => const CreateCategoryGroupModel(
      name: '', slug: '', desc: '', metaTitle: '', meatDesc: '');
}
