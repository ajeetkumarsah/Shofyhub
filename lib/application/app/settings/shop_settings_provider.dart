import 'package:clean_api/clean_api.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_state.dart';
import 'package:zcart_seller/domain/app/settings/i_shop_settings_repo.dart';
import 'package:zcart_seller/domain/app/settings/update_shop_configs_model.dart';
import 'package:zcart_seller/infrastructure/app/settings/shop_settings_repo.dart';

final shopSettingsProvider =
    StateNotifierProvider<ShopSettingsNotifier, ShopSettingsState>((ref) {
  return ShopSettingsNotifier(ShopSettingsRepo());
});

class ShopSettingsNotifier extends StateNotifier<ShopSettingsState> {
  final IShopSettingsRepo shopSettingsRepo;
  ShopSettingsNotifier(this.shopSettingsRepo) : super(ShopSettingsState.init());

  getShopSettings() async {
    state = state.copyWith(loading: true);
    final data = await shopSettingsRepo.getShopSettings();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), shopSettings: r));
  }

  updateShopSettings({
    required FormData formData,
    required int shopId,
    required String apiKey,
  }) async {
    state = state.copyWith(loadingUpdate: true);
    final data = await shopSettingsRepo.updateShopSettings(
      formData: formData,
      shopId: shopId,
      apiKey: apiKey,
    );
    state = data.fold(
        (l) => state.copyWith(loadingUpdate: false, failure: l),
        (r) =>
            state.copyWith(loadingUpdate: false, failure: CleanFailure.none()));
    getShopSettings();
  }

  getShopConfigs() async {
    state = state.copyWith(loading: true);
    final data = await shopSettingsRepo.getShopConfigs();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), shopConfigs: r));
  }

  updateShopConfigs(
      {required UpdateShopConfigsModel advanceSettingsInfo,
      required int shopId}) async {
    state = state.copyWith(loadingUpdate: true);
    final data = await shopSettingsRepo.updateShopConfigs(
        shopConfigsInfo: advanceSettingsInfo, shopId: shopId);
    state = data.fold(
        (l) => state.copyWith(loadingUpdate: false, failure: l),
        (r) =>
            state.copyWith(loadingUpdate: false, failure: CleanFailure.none()));
    getShopConfigs();
  }

  getSystemConfigs() async {
    state = state.copyWith(loading: true);
    final data = await shopSettingsRepo.getSystemConfigs();
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), systemConfigs: r));
  }
}
