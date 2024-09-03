import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/shop/user/shop_user_state.dart';
import 'package:alpesportif_seller/domain/app/shop/user/create_shop_user_model.dart';
import 'package:alpesportif_seller/domain/app/shop/user/i_shop_user_repo.dart';
import 'package:alpesportif_seller/infrastructure/app/shop/user/shop_user_repo.dart';

final shopUserProvider =
    StateNotifierProvider<ShopUserNotifier, ShopUserState>((ref) {
  return ShopUserNotifier(ShopUserRepo());
});

class ShopUserNotifier extends StateNotifier<ShopUserState> {
  final IShopUserRepo shopUserRepo;

  ShopUserNotifier(this.shopUserRepo) : super(ShopUserState.init());

  getShopUser() async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.getShopUser(filter: 'null');
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, failure: CleanFailure.none(), getShopUser: r),
    );
  }

  getTrashShopUser() async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.getShopUser(filter: 'trash');
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, failure: CleanFailure.none(), getTrashShopUser: r),
    );
  }

  createShopUser({required CreateShopUserModel createShopUser}) async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.createShopUser(user: createShopUser);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
    getShopUser();
  }

  shopUserDetails({required int userId}) async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.shopUserDetails(userId: userId);
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
          loading: false, failure: CleanFailure.none(), shopUser: r),
    );
  }

  updateShopUser({
    required int userId,
    required int shopId,
    required int roleId,
    required String name,
    required String niceName,
    required String email,
    required int active,
    // required String dob,
    // required String sex,
    required String description,
  }) async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.updateShopUser(
        userId: userId,
        shopId: shopId,
        roleId: roleId,
        name: name,
        niceName: niceName,
        email: email,
        active: active,
        // dob: dob,
        // sex: sex,
        description: description);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getShopUser();
  }

  trashShopUser({required int userId}) async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.trashShopUser(userId: userId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getShopUser();
    getTrashShopUser();
  }

  restoreShopUser({required int userId}) async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.restoreShopUser(userId: userId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getShopUser();
    getTrashShopUser();
  }

  deleteShopUser({required int userId}) async {
    state = state.copyWith(loading: true);
    final data = await shopUserRepo.deleteShopUser(userId: userId);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, failure: CleanFailure.none()));
    getShopUser();
    getTrashShopUser();
  }
}
