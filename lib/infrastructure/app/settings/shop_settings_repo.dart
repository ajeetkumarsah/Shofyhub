import 'package:clean_api/clean_api.dart';
import 'package:zcart_seller/application/core/dio_client.dart';
import 'package:zcart_seller/domain/app/settings/advance_shop_settings_model.dart';
import 'package:zcart_seller/domain/app/settings/basic_shop_settings_model.dart';
import 'package:zcart_seller/domain/app/settings/i_shop_settings_repo.dart';
import 'package:zcart_seller/domain/app/settings/update_advance_shop_settings_model.dart';

class ShopSettingsRepo extends IShopSettingsRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<Either<CleanFailure, BasicShopSettingsModel>> getBasicShopSettings() {
    return cleanApi.get(
        fromData: (json) => BasicShopSettingsModel.fromMap(json['data']),
        endPoint: 'basic_shop_settings');
  }

  @override
  Future<Either<CleanFailure, String>> updateBasicShopSettings(
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
  Future<Either<CleanFailure, AdvanceShopSettingsModel>>
      getAdvanceShopSettings() {
    return cleanApi.get(
        fromData: (json) => AdvanceShopSettingsModel.fromMap(json),
        endPoint: 'advance_shop_settings');
  }

  @override
  Future<Either<CleanFailure, Unit>> updateAdvanceShopSettings(
      {required UpdateAdvanceShopSettingsModel advanceSettingsInfo,
      required int shopId}) {
    return cleanApi.put(
      fromData: (josn) => unit,
      body: null,
      endPoint:
          'advance_shop_setting/$shopId/update?alert_quantity=${advanceSettingsInfo.alertQuantity}&default_supplier_id=${advanceSettingsInfo.defaultSupplierId}&default_warehouse_id=${advanceSettingsInfo.defaultWarehouseId}&order_number_prefix=${advanceSettingsInfo.orderNumberPrefix}&order_number_suffix=${advanceSettingsInfo.orderNumberSuffix}&default_payment_method_id=${advanceSettingsInfo.defaultPaymentMethodId}&default_tax_id=${advanceSettingsInfo.defaultTaxId}&order_handling_cost=${advanceSettingsInfo.orderHandlingCost}&active_ecommerce=${advanceSettingsInfo.activeEcommerce}&auto_archive_order=${advanceSettingsInfo.autoArchiveOrder}&pay_online=${advanceSettingsInfo.payOnline}&pay_in_person=${advanceSettingsInfo.payInPerson}&pagination=${advanceSettingsInfo.pagination}&show_shop_desc_with_listing=${advanceSettingsInfo.showRefundPolicyWithListing}&show_refund_policy_with_listing=${advanceSettingsInfo.showRefundPolicyWithListing}&enable_live_chat=${advanceSettingsInfo.enableLiveChat}&support_agent=${advanceSettingsInfo.supportAgent}&support_phone=${advanceSettingsInfo.supportPhone}&support_phone_toll_free=${advanceSettingsInfo.supportPhoneTollFree}&support_email=${advanceSettingsInfo.supportEmail}&default_sender_email_address=${advanceSettingsInfo.defaultSenderEmailAddress}&default_email_sender_name=${advanceSettingsInfo.defaultEmailSenderName}&notify_inventory_out=${advanceSettingsInfo.notifyInventoryOut}&notify_alert_quantity=${advanceSettingsInfo.notifyAlertQuantity}&notify_new_message=${advanceSettingsInfo.notifyNewMessage}&digital_goods_only=${advanceSettingsInfo.digitalGoodsOnly}&notify_new_chat=${advanceSettingsInfo.notifyNewChat}&notify_new_order=${advanceSettingsInfo.notifyNewOrder}&notify_new_disput=${advanceSettingsInfo.notifyNewDisput}&notify_abandoned_checkout=${advanceSettingsInfo.notifyAbandonedCheckout}',
    );
  }
}
