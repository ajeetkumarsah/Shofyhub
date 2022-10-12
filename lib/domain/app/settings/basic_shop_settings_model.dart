import 'package:equatable/equatable.dart';

class BasicShopSettingsModel extends Equatable {
  final int id;
  final int ownerId;
  final String name;
  final String legalName;
  final String slug;
  final String email;
  final String description;
  final dynamic timeZone;
  final dynamic externalUrl;
  final String logo;

  const BasicShopSettingsModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.legalName,
    required this.slug,
    required this.email,
    required this.description,
    required this.timeZone,
    required this.externalUrl,
    required this.logo,
  });

  BasicShopSettingsModel copyWith({
    int? id,
    int? ownerId,
    String? name,
    String? legalName,
    String? slug,
    String? email,
    String? description,
    dynamic timeZone,
    dynamic externalUrl,
    String? logo,
  }) {
    return BasicShopSettingsModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      legalName: legalName ?? this.legalName,
      slug: slug ?? this.slug,
      email: email ?? this.email,
      description: description ?? this.description,
      timeZone: timeZone ?? this.timeZone,
      externalUrl: externalUrl ?? this.externalUrl,
      logo: logo ?? this.logo,
    );
  }

  factory BasicShopSettingsModel.fromMap(Map<String, dynamic> map) =>
      BasicShopSettingsModel(
        id: map["id"]?.toInt() ?? 0,
        ownerId: map["owner_id"] ?? 0,
        name: map["name"] ?? '',
        legalName: map["legal_name"] ?? '',
        slug: map["slug"] ?? '',
        email: map["email"] ?? '',
        description: map["description"] ?? '',
        timeZone: map["time_zone"],
        externalUrl: map["external_url"],
        logo: map["logo"] ?? '',
      );

  factory BasicShopSettingsModel.init() => const BasicShopSettingsModel(
        id: 0,
        ownerId: 0,
        name: '',
        legalName: '',
        slug: '',
        email: '',
        description: '',
        timeZone: '',
        externalUrl: '',
        logo: '',
      );

  @override
  List<Object?> get props => [
        id,
        ownerId,
        name,
        legalName,
        slug,
        email,
        description,
        timeZone,
        externalUrl,
        logo
      ];
}
