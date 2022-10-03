// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateCategoryGroupModel extends Equatable {
  final String name;
  final String slug;
  final String desc;
  final String metaTitle;
  final String meatDesc;
  final int order;
  final String icon;
  final int active;
  const CreateCategoryGroupModel({
    required this.name,
    required this.slug,
    required this.desc,
    required this.metaTitle,
    required this.meatDesc,
    required this.order,
    required this.icon,
    required this.active,
  });

  CreateCategoryGroupModel copyWith({
    String? name,
    String? slug,
    String? desc,
    String? metaTitle,
    String? meatDesc,
    int? order,
    String? icon,
    int? active,
  }) {
    return CreateCategoryGroupModel(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      desc: desc ?? this.desc,
      metaTitle: metaTitle ?? this.metaTitle,
      meatDesc: meatDesc ?? this.meatDesc,
      order: order ?? this.order,
      icon: icon ?? this.icon,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'slug': slug,
      'desc': desc,
      'metaTitle': metaTitle,
      'meatDesc': meatDesc,
      'order': order,
      'icon': icon,
      'active': active,
    };
  }

  factory CreateCategoryGroupModel.fromMap(Map<String, dynamic> map) {
    return CreateCategoryGroupModel(
      name: map['name'] as String,
      slug: map['slug'] as String,
      desc: map['desc'] as String,
      metaTitle: map['metaTitle'] as String,
      meatDesc: map['meatDesc'] as String,
      order: map['order'] as int,
      icon: map['icon'] as String,
      active: map['active'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateCategoryGroupModel.fromJson(String source) =>
      CreateCategoryGroupModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

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
      order,
      icon,
      active,
    ];
  }

  factory CreateCategoryGroupModel.init() => const CreateCategoryGroupModel(
      name: '',
      slug: '',
      desc: '',
      metaTitle: '',
      meatDesc: '',
      active: 0,
      icon: '',
      order: 0);

  @override
  bool get stringify => true;
}
