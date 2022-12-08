import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/settings/shop_settings_model.dart';
import 'package:zcart_seller/domain/app/settings/shop_config_model.dart';
import 'package:zcart_seller/domain/app/settings/system_config_model.dart';
import 'package:zcart_seller/domain/app/settings/update_shop_configs_model.dart';

abstract class IShopSettingsRepo {
  Future<Either<CleanFailure, ShopSettingsModel>> getShopSettings();
  Future<Either<CleanFailure, String>> updateShopSettings(
      {required formData, required int shopId});
  Future<Either<CleanFailure, ShopConfigModel>> getShopConfigs();
  Future<Either<CleanFailure, Unit>> updateShopConfigs(
      {required UpdateShopConfigsModel shopConfigsInfo,
      required int shopId});
  Future<Either<CleanFailure, SystemConfigModel>> getSystemConfigs();
}
