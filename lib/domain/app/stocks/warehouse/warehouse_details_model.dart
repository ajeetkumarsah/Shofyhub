import 'package:equatable/equatable.dart';
import 'package:zcart_seller/domain/app/shop/taxes/country_state_model.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/primary_address_model.dart';

class WarehouseDetailsModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final ShopUsersModel incharge;
  final String description;
  final String openingTime;
  final dynamic closingTime;
  final List<String> businessDays;
  final PrimaryAddressModel primaryAddress;
  final ShopUsersModel manager;
  final bool active;
  final String image;

  const WarehouseDetailsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.incharge,
    required this.description,
    required this.openingTime,
    required this.closingTime,
    required this.businessDays,
    required this.primaryAddress,
    required this.manager,
    required this.active,
    required this.image,
  });

  WarehouseDetailsModel copyWith({
    int? id,
    String? name,
    String? email,
    ShopUsersModel? incharge,
    String? description,
    String? openingTime,
    dynamic closingTime,
    List<String>? businessDays,
    PrimaryAddressModel? primaryAddress,
    ShopUsersModel? manager,
    bool? active,
    String? image,
  }) {
    return WarehouseDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      incharge: incharge ?? this.incharge,
      description: description ?? this.description,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      businessDays: businessDays ?? this.businessDays,
      primaryAddress: primaryAddress ?? this.primaryAddress,
      manager: manager ?? this.manager,
      active: active ?? this.active,
      image: image ?? this.image,
    );
  }

  factory WarehouseDetailsModel.fromJson(Map<String, dynamic> map) =>
      WarehouseDetailsModel(
        id: map["id"]?.toInt() ?? 0,
        name: map["name"] ?? '',
        email: map["email"] ?? '',
        incharge: ShopUsersModel.fromMap(map["incharge"]),
        description: map["description"] ?? '',
        openingTime: map["opening_time"] ?? '',
        closingTime: map["closing_time"] ?? '',
        businessDays: List<String>.from(map['business_days'].map((x) => x)),
        primaryAddress: PrimaryAddressModel.fromJson(map["primary_address"]),
        manager: (map['manager'] != null || map['manager'] != [])
            ? ShopUsersModel.fromMap(map['manager'])
            : ShopUsersModel.init(),
        image: map["image"] ?? '',
        active: map["active"] ?? false,
      );

  factory WarehouseDetailsModel.init() => WarehouseDetailsModel(
        id: 0,
        name: '',
        email: '',
        incharge: ShopUsersModel.init(),
        description: '',
        openingTime: '',
        closingTime: '',
        businessDays: const [],
        manager: ShopUsersModel.init(),
        primaryAddress: PrimaryAddressModel(
          id: 0,
          addressType: '',
          addressTitle: '',
          addressLine1: '',
          addressLine2: '',
          city: '',
          zipCode: '',
          country: CountryStateModel.init(),
          state: CountryStateModel.init(),
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
        incharge,
        description,
        openingTime,
        closingTime,
        businessDays,
        primaryAddress,
        manager,
        active,
        image,
      ];
}
