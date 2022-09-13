import 'dart:convert';

import 'package:equatable/equatable.dart';

class ManufacturerDetailsModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String url;
  final String email;
  final String phone;
  final String description;
  final String origin;
  final dynamic listingCount;
  final String availableFrom;
  final String image;
  final String coverImage;
  const ManufacturerDetailsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.url,
    required this.email,
    required this.phone,
    required this.description,
    required this.origin,
    required this.listingCount,
    required this.availableFrom,
    required this.image,
    required this.coverImage,
  });

  ManufacturerDetailsModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? url,
    String? email,
    String? phone,
    String? description,
    String? origin,
    dynamic listingCount,
    String? availableFrom,
    String? image,
    String? coverImage,
  }) {
    return ManufacturerDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      url: url ?? this.url,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      origin: origin ?? this.origin,
      listingCount: listingCount ?? this.listingCount,
      availableFrom: availableFrom ?? this.availableFrom,
      image: image ?? this.image,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'url': url,
      'email': email,
      'phone': phone,
      'description': description,
      'origin': origin,
      'listing_count': listingCount,
      'available_from': availableFrom,
      'image': image,
      'cover_image': coverImage,
    };
  }

  factory ManufacturerDetailsModel.fromMap(Map<String, dynamic> map) {
    return ManufacturerDetailsModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      url: map['url'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      description: map['description'] ?? '',
      origin: map['origin'] ?? '',
      listingCount: map['listing_count'],
      availableFrom: map['available_from'] ?? '',
      image: map['image'] ?? '',
      coverImage: map['cover_image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ManufacturerDetailsModel.fromJson(String source) =>
      ManufacturerDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManufacturerDetailsModel(id: $id, name: $name, slug: $slug, url: $url, email: $email, phone: $phone, description: $description, origin: $origin, listingCount: $listingCount, availableFrom: $availableFrom, image: $image, coverImage: $coverImage)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      url,
      email,
      phone,
      description,
      origin,
      listingCount,
      availableFrom,
      image,
      coverImage,
    ];
  }

  factory ManufacturerDetailsModel.inti() => const ManufacturerDetailsModel(
      id: 0,
      name: '',
      slug: '',
      url: '',
      email: '',
      phone: '',
      description: '',
      origin: '',
      listingCount: '',
      availableFrom: '',
      image: '',
      coverImage: '');
}
