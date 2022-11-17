import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:zcart_seller/domain/app/shop/user/create_shop_user_model.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';

class ShopUserState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final List<ShopUsersModel> getShopUser;
  final List<ShopUsersModel> getTrashShopUser;
  const ShopUserState({
    required this.loading,
    required this.failure,
    required this.getShopUser,
    required this.getTrashShopUser,
  });

  ShopUserState copyWith({
    bool? loading,
    CleanFailure? failure,
    List<ShopUsersModel>? getShopUser,
    List<ShopUsersModel>? getTrashShopUser,
    CreateShopUserModel? shopUser,
  }) {
    return ShopUserState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      getShopUser: getShopUser ?? this.getShopUser,
      getTrashShopUser: getTrashShopUser ?? this.getTrashShopUser,
    );
  }

  @override
  String toString() {
    return 'ShopUserState(loading: $loading, failure: $failure, getShopUser: $getShopUser, getTrashShopUser: $getTrashShopUser)';
  }

  @override
  List<Object> get props => [
        loading,
        failure,
        getShopUser,
        getTrashShopUser,
      ];
  factory ShopUserState.init() => ShopUserState(
        loading: false,
        failure: CleanFailure.none(),
        getShopUser: const [],
        getTrashShopUser: const [],
      );
}
