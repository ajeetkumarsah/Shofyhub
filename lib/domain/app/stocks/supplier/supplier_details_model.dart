import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/shop/taxes/country_state_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/primary_address_model.dart';

class SupplierDetailsModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String contactPerson;
  final String url;
  final String description;
  final PrimaryAddressModel primaryAddress;
  final String image;
  final bool active;

  const SupplierDetailsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.contactPerson,
    required this.url,
    required this.description,
    required this.primaryAddress,
    required this.image,
    required this.active,
  });

  SupplierDetailsModel copyWith({
    int? id,
    String? name,
    String? email,
    String? contactPerson,
    String? url,
    String? description,
    PrimaryAddressModel? primaryAddress,
    String? image,
    bool? active,
  }) {
    return SupplierDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      contactPerson: contactPerson ?? this.contactPerson,
      url: url ?? this.url,
      description: description ?? this.description,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      image: image ?? this.image,
      active: active ?? this.active,
    );
  }

  factory SupplierDetailsModel.fromJson(Map<String, dynamic> map) =>
      SupplierDetailsModel(
        id: map["id"]?.toInt() ?? 0,
        name: map["name"] ?? '',
        email: map["email"] ?? '',
        contactPerson: map["contact_person"] ?? '',
        url: map["url"] ?? '',
        description: map["description"] ?? '',
        primaryAddress: PrimaryAddressModel.fromJson(map["primaryAddress"]),
        image: map["image"] ?? '',
        active: map["active"] ?? false,
      );

  factory SupplierDetailsModel.init() => SupplierDetailsModel(
        id: 0,
        name: '',
        email: '',
        contactPerson: '',
        url: '',
        description: '',
        primaryAddress: PrimaryAddressModel(
          id: 0,
          addressType: '',
          addressTitle: '',
          addressLine1: '',
          addressLine2: '',
          city: '',
          zipCode: '',
          country: CountryStateModel.init(),
          state: '',
          phone: '',
        ),
        image: '',
        active: false,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        contactPerson,
        url,
        description,
        primaryAddress,
        image,
        active,
      ];
}
