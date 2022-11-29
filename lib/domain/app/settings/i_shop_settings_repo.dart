import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/domain/app/settings/advance_shop_settings_model.dart';
import 'package:zcart_seller/domain/app/settings/basic_shop_settings_model.dart';
import 'package:zcart_seller/domain/app/settings/update_advance_shop_settings_model.dart';

abstract class IShopSettingsRepo {
  Future<Either<CleanFailure, BasicShopSettingsModel>> getBasicShopSettings();
  Future<Either<CleanFailure, Unit>> updateBasicShopSettings(
      {required formData, required int shopId});
  Future<Either<CleanFailure, AdvanceShopSettingsModel>>
      getAdvanceShopSettings();
  Future<Either<CleanFailure, Unit>> updateAdvanceShopSettings(
      {required UpdateAdvanceShopSettingsModel advanceSettingsInfo,
      required int shopId});
}
