import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_state.dart';
import 'package:zcart_seller/domain/app/settings/i_shop_settings_repo.dart';
import 'package:zcart_seller/domain/app/settings/update_advance_shop_settings_model.dart';
import 'package:zcart_seller/infrastructure/app/settings/shop_settings_repo.dart';

final shopSettingsProvider =
    StateNotifierProvider<ShopSettingsNotifier, ShopSettingsState>((ref) {
  return ShopSettingsNotifier(ShopSettingsRepo());
});

class ShopSettingsNotifier extends StateNotifier<ShopSettingsState> {
  final IShopSettingsRepo shopSettingsRepo;
  ShopSettingsNotifier(this.shopSettingsRepo) : super(ShopSettingsState.init());

  getBasicShopSettings() async {
    state = state.copyWith(loading: true);
    final data = await shopSettingsRepo.getBasicShopSettings();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            basicShopSettings: r));
  }

  updateBasicShopSettings({required formData, required int shopId}) async {
    state = state.copyWith(loadingUpdate: true);
    final data = await shopSettingsRepo.updateBasicShopSettings(
        formData: formData, shopId: shopId);
    state = data.fold(
        (l) => state.copyWith(loadingUpdate: false, failure: l),
        (r) =>
            state.copyWith(loadingUpdate: false, failure: CleanFailure.none()));
    getBasicShopSettings();
  }

  getAdvanceShopSettings() async {
    state = state.copyWith(loading: true);
    final data = await shopSettingsRepo.getAdvanceShopSettings();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false,
            failure: CleanFailure.none(),
            advanceShopSettings: r));
  }

  updateAdvanceShopSettings(
      {required UpdateAdvanceShopSettingsModel advanceSettingsInfo,
      required int shopId}) async {
    state = state.copyWith(loadingUpdate: true);
    final data = await shopSettingsRepo.updateAdvanceShopSettings(
        advanceSettingsInfo: advanceSettingsInfo, shopId: shopId);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) =>
            state.copyWith(loadingUpdate: false, failure: CleanFailure.none()));
  }

  getShopConfigs() async {
    state = state.copyWith(loading: true);
    final data = await shopSettingsRepo.getShopConfigs();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), shopConfigs: r));
  }
}
