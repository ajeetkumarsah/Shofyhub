import 'package:equatable/equatable.dart';

class UpdateBasicShopSettingsModel extends Equatable {
  final int shopId;
  final String name;
  final String legalName;
  final String slug;
  final String email;
  final String description;

  const UpdateBasicShopSettingsModel({
    required this.shopId,
    required this.name,
    required this.legalName,
    required this.slug,
    required this.email,
    required this.description,
  });

  UpdateBasicShopSettingsModel copyWith({
    int? shopId,
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
    return UpdateBasicShopSettingsModel(
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      legalName: legalName ?? this.legalName,
      slug: slug ?? this.slug,
      email: email ?? this.email,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        shopId,
        name,
        legalName,
        slug,
        email,
        description,
      ];
}
