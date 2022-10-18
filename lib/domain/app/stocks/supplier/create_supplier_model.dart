import 'package:equatable/equatable.dart';

class CreateSupplierModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String addressLine1;
  final String addressLine2;
  final String contactPerson;
  final String city;
  final String description;
  final String url;
  final String zipCode;
  final int countryId;
  // final int stateId;
  final int active;
  const CreateSupplierModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.contactPerson,
    required this.city,
    required this.description,
    required this.url,
    required this.zipCode,
    required this.countryId,
    // required this.stateId,
    required this.active,
  });

  CreateSupplierModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? addressLine1,
    String? addressLine2,
    String? contactPerson,
    String? city,
    String? description,
    String? url,
    String? zipCode,
    int? countryId,
    // int? stateId,
    int? active,
  }) {
    return CreateSupplierModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      contactPerson: contactPerson ?? this.contactPerson,
      city: city ?? this.city,
      description: description ?? this.description,
      countryId: countryId ?? this.countryId,
      url: url ?? this.url,
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
      addressLine1,
      addressLine2,
      contactPerson,
      city,
      description,
      url,
      zipCode,
      countryId,
      // stateId,
      active,
    ];
  }
}
