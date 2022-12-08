import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/application/core/dio_client.dart';
import 'package:zcart_seller/domain/app/settings/shop_config_model.dart';
import 'package:zcart_seller/domain/app/settings/shop_settings_model.dart';
import 'package:zcart_seller/domain/app/settings/i_shop_settings_repo.dart';
import 'package:zcart_seller/domain/app/settings/system_config_model.dart';
import 'package:zcart_seller/domain/app/settings/update_shop_configs_model.dart';

class ShopSettingsRepo extends IShopSettingsRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, ShopSettingsModel>> getShopSettings() {
    return cleanApi.get(
        fromData: (json) => ShopSettingsModel.fromMap(json['data']),
        endPoint: 'settings');
  }

  @override
  Future<Either<CleanFailure, String>> updateShopSettings(
      {required formData, required int shopId}) async {
    try {
      final response = await DioClient.post(
          url: '/basic_shop_setting/$shopId/update', payload: formData);
      Logger.i('Basic Shop Settings: ${response.data}');
      return right(response.data['message']);
    } catch (e) {
      return left(
          CleanFailure(tag: 'basic shop settings', error: e.toString()));
    }
  }

  @override
  Future<Either<CleanFailure, ShopConfigModel>> getShopConfigs() {
    return cleanApi.get(
        fromData: (json) => ShopConfigModel.fromMap(json), endPoint: 'configs');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateShopConfigs(
      {required UpdateShopConfigsModel shopConfigsInfo, required int shopId}) {
    return cleanApi.put(
      fromData: (josn) => unit,
      body: null,
      endPoint:
          'configs/$shopId/update?alert_quantity=${shopConfigsInfo.alertQuantity}&default_supplier_id=${shopConfigsInfo.defaultSupplierId}&default_warehouse_id=${shopConfigsInfo.defaultWarehouseId}&order_number_prefix=${shopConfigsInfo.orderNumberPrefix}&order_number_suffix=${shopConfigsInfo.orderNumberSuffix}&default_payment_method_id=${shopConfigsInfo.defaultPaymentMethodId}&default_tax_id=${shopConfigsInfo.defaultTaxId}&order_handling_cost=${shopConfigsInfo.orderHandlingCost}&active_ecommerce=${shopConfigsInfo.activeEcommerce}&auto_archive_order=${shopConfigsInfo.autoArchiveOrder}&pay_online=${shopConfigsInfo.payOnline}&pay_in_person=${shopConfigsInfo.payInPerson}&pagination=${shopConfigsInfo.pagination}&show_shop_desc_with_listing=${shopConfigsInfo.showRefundPolicyWithListing}&show_refund_policy_with_listing=${shopConfigsInfo.showRefundPolicyWithListing}&enable_live_chat=${shopConfigsInfo.enableLiveChat}&support_agent=${shopConfigsInfo.supportAgent}&support_phone=${shopConfigsInfo.supportPhone}&support_phone_toll_free=${shopConfigsInfo.supportPhoneTollFree}&support_email=${shopConfigsInfo.supportEmail}&default_sender_email_address=${shopConfigsInfo.defaultSenderEmailAddress}&default_email_sender_name=${shopConfigsInfo.defaultEmailSenderName}&notify_inventory_out=${shopConfigsInfo.notifyInventoryOut}&notify_alert_quantity=${shopConfigsInfo.notifyAlertQuantity}&notify_new_message=${shopConfigsInfo.notifyNewMessage}&digital_goods_only=${shopConfigsInfo.digitalGoodsOnly}&notify_new_chat=${shopConfigsInfo.notifyNewChat}&notify_new_order=${shopConfigsInfo.notifyNewOrder}&notify_new_disput=${shopConfigsInfo.notifyNewDisput}&notify_abandoned_checkout=${shopConfigsInfo.notifyAbandonedCheckout}',
    );
  }

  @override
  Future<Either<CleanFailure, SystemConfigModel>> getSystemConfigs() {
    return cleanApi.get(
        fromData: (json) => SystemConfigModel.fromMap(json['data']),
        endPoint: 'system_configs');
  }
}
