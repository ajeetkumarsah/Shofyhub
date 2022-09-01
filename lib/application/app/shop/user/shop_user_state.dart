import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/shop/user/create_shop_user_model.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';

class ShopUserState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<GetShopUsersModel> getShopUser;
  final CreateShopUserModel shopUser;
  const ShopUserState({
    required this.loading,
    required this.failure,
    required this.getShopUser,
    required this.shopUser,
  });

  ShopUserState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<GetShopUsersModel>? getShopUser,
    CreateShopUserModel? shopUser,
  }) {
    return ShopUserState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      getShopUser: getShopUser ?? this.getShopUser,
      shopUser: shopUser ?? this.shopUser,
    );
  }

  @override
  String toString() {
    return 'ShopUserState(loading: $loading, failure: $failure, getShopUser: $getShopUser, shopUser: $shopUser)';
  }

  @override
  List<Object> get props => [loading, failure, getShopUser, shopUser];
  factory ShopUserState.init() => ShopUserState(
        loading: false,
        failure: CleanFailure.none(),
        shopUser: CreateShopUserModel.init(),
        getShopUser: const [],
      );
}
