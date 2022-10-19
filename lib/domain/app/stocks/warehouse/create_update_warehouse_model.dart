import 'package:equatable/equatable.dart';

class CreateUpdateWarehouseModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String description;
  final String addressLine1;
  final String addressLine2;
  final String openingTime;
  final String closeTime;
  final int inchargeId;
  final List<String> businessDays;
  final String city;
  final int countryId;
  final String zipCode;
  // final int stateId;
  final int active;
  const CreateUpdateWarehouseModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
    required this.addressLine1,
    required this.addressLine2,
    required this.openingTime,
    required this.closeTime,
    required this.inchargeId,
    required this.businessDays,
    required this.city,
    required this.countryId,
    required this.zipCode,
    // required this.stateId,
    required this.active,
  });

  CreateUpdateWarehouseModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? description,
    String? addressLine1,
    String? addressLine2,
    String? openingTime,
    String? closeTime,
    int? inchargeId,
    List<String>? businessDays,
    String? city,
    int? countryId,
    String? zipCode,
    int? active,
  }) {
    return CreateUpdateWarehouseModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      openingTime: openingTime ?? this.openingTime,
      closeTime: closeTime ?? this.closeTime,
      inchargeId: inchargeId ?? this.inchargeId,
      businessDays: businessDays ?? this.businessDays,
      city: city ?? this.city,
      countryId: countryId ?? this.countryId,
      zipCode: zipCode ?? this.zipCode,
      // stateId: stateId ?? this.stateId,
      active: active ?? this.active,
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      email,
      phone,
      description,
      addressLine1,
      addressLine2,
      openingTime,
      closeTime,
      inchargeId,
      businessDays,
      city,
      countryId,
      zipCode,
      // stateId,
      active,
    ];
  }
}
