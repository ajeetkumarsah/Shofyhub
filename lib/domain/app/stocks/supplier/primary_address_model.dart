import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/shop/taxes/country_state_model.dart';

class PrimaryAddressModel extends Equatable {
  final int id;
  final String addressType;
  final String addressTitle;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String zipCode;
  final CountryStateModel country;
  final CountryStateModel state;
  final String phone;

  const PrimaryAddressModel({
    required this.id,
    required this.addressType,
    required this.addressTitle,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.state,
    required this.phone,
  });

  PrimaryAddressModel copyWith({
    int? id,
    String? addressType,
    String? addressTitle,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? zipCode,
    CountryStateModel? country,
    dynamic state,
    String? phone,
  }) {
    return PrimaryAddressModel(
      id: id ?? this.id,
      addressType: addressType ?? this.addressType,
      addressTitle: addressTitle ?? this.addressTitle,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      state: state ?? this.state,
      phone: phone ?? this.phone,
    );
  }

  factory PrimaryAddressModel.fromJson(Map<String, dynamic> json) =>
      PrimaryAddressModel(
        id: json["id"]?.toInt() ?? 0,
        addressType: json["address_type"] ?? '',
        addressTitle: json["address_title"] ?? '',
        addressLine1: json["address_line_1"] ?? '',
        addressLine2: json["address_line_2"] ?? '',
        city: json["city"] ?? '',
        zipCode: json["zip_code"] ?? '',
        country: json["country"] != null
            ? CountryStateModel.fromMap(json["country"])
            : CountryStateModel.init(),
        state: CountryStateModel.fromMap(json["state"]),
        phone: json["phone"] ?? '',
      );

  @override
  List<Object?> get props => [
        id,
        addressType,
        addressTitle,
        addressLine2,
        addressLine2,
        city,
        zipCode,
        country,
        state,
        phone,
      ];
}
