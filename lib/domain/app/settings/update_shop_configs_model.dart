import 'package:equatable/equatable.dart';

class UpdateShopConfigsModel extends Equatable {
  final int shopId;
  final int alertQuantity;
  final int? defaultWarehouseId;
  final int? defaultSupplierId;
  final String orderNumberPrefix;
  final dynamic orderNumberSuffix;
  final dynamic defaultPaymentMethodId;
  final int? defaultTaxId;
  final String orderHandlingCost;
  final int activeEcommerce;
  final int payOnline;
  final int payInPerson;
  final int pagination;
  final dynamic showShopDescWithListing;
  final int showRefundPolicyWithListing;
  final dynamic supportAgent;
  final dynamic supportPhone;
  final dynamic supportPhoneTollFree;
  final String supportEmail;
  final int autoArchiveOrder;
  final String defaultSenderEmailAddress;
  final String defaultEmailSenderName;
  final String returnRefund;
  final int notifyNewMessage;
  final int notifyAlertQuantity;
  final int notifyInventoryOut;
  final int notifyNewOrder;
  final dynamic notifyAbandonedCheckout;
  final int notifyNewDisput;
  final int notifyNewChat;
  final int digitalGoodsOnly;
  // final int defaultPackagingIds;
  final int enableLiveChat;
  // final String returnRefund;
  // final bool maintenanceMode;
  // final dynamic pendingVerification;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  const UpdateShopConfigsModel({
    required this.shopId,
    required this.supportPhone,
    required this.supportPhoneTollFree,
    required this.supportEmail,
    required this.supportAgent,
    required this.defaultSenderEmailAddress,
    required this.defaultEmailSenderName,
    required this.returnRefund,
    required this.orderNumberPrefix,
    required this.orderNumberSuffix,
    required this.defaultTaxId,
    required this.orderHandlingCost,
    required this.autoArchiveOrder,
    required this.defaultPaymentMethodId,
    required this.pagination,
    required this.showShopDescWithListing,
    required this.showRefundPolicyWithListing,
    required this.alertQuantity,
    required this.digitalGoodsOnly,
    required this.defaultWarehouseId,
    required this.defaultSupplierId,
    // required this.defaultPackagingIds,
    required this.notifyNewMessage,
    required this.notifyAlertQuantity,
    required this.notifyInventoryOut,
    required this.notifyNewOrder,
    required this.notifyAbandonedCheckout,
    required this.notifyNewDisput,
    required this.enableLiveChat,
    required this.notifyNewChat,
    // required this.maintenanceMode,
    // required this.pendingVerification,
    // required this.createdAt,
    // required this.updatedAt,
    required this.activeEcommerce,
    required this.payOnline,
    required this.payInPerson,
  });

  UpdateShopConfigsModel copyWith({
    int? shopId,
    int? alertQuantity,
    int? defaultWarehouseId,
    int? defaultSupplierId,
    String? orderNumberPrefix,
    dynamic orderNumberSuffix,
    dynamic defaultPaymentMethodId,
    int? defaultTaxId,
    String? orderHandlingCost,
    int? activeEcommerce,
    int? payOnline,
    int? payInPerson,
    int? pagination,
    dynamic showShopDescWithListing,
    int? showRefundPolicyWithListing,
    dynamic supportAgent,
    dynamic supportPhone,
    dynamic supportPhoneTollFree,
    String? supportEmail,
    String? defaultSenderEmailAddress,
    String? defaultEmailSenderName,
    String? returnRefund,
    int? notifyNewMessage,
    int? notifyAlertQuantity,
    int? notifyInventoryOut,
    int? notifyNewOrder,
    dynamic notifyAbandonedCheckout,
    int? notifyNewDisput,
    int? notifyNewChat,
    int? digitalGoodsOnly,
    // int? defaultPackagingIds,
    int? autoArchiveOrder,
    int? enableLiveChat,

    // int? shopId,
    // dynamic supportPhone,
    // dynamic supportPhoneTollFree,
    // String? supportEmail,
    // dynamic supportAgent,
    // String? defaultSenderEmailAddress,
    // String? defaultEmailSenderName,
    // String? returnRefund,
    // String? orderNumberPrefix,
    // dynamic orderNumberSuffix,
    // int? defaultTaxId,
    // String? orderHandlingCost,
    // dynamic defaultPaymentMethodId,
    // int? pagination,
    // dynamic showShopDescWithListing,
    // int? showRefundPolicyWithListing,
    // dynamic alertQuantity,
    // bool? digitalGoodsOnly,
    // dynamic defaultWarehouseId,
    // dynamic defaultSupplierId,
    // bool? defaultPackagingIds,
    // bool? notifyNewMessage,
    // bool? notifyAlertQuantity,
    // bool? notifyInventoryOut,
    // bool? notifyNewOrder,
    // dynamic notifyAbandonedCheckout,
    // bool? notifyNewDisput,
    // bool? notifyNewChat,
    // bool? maintenanceMode,
    // dynamic pendingVerification,
    // DateTime? createdAt,
    // DateTime? updatedAt,
    // int? activeEcommerce,
    // int? payOnline,
    // int? payInPerson,
  }) {
    return UpdateShopConfigsModel(
      shopId: shopId ?? this.shopId,
      supportPhone: supportPhone ?? this.supportPhone,
      supportPhoneTollFree: supportPhoneTollFree ?? this.supportPhoneTollFree,
      supportEmail: supportEmail ?? this.supportEmail,
      supportAgent: supportAgent ?? this.supportAgent,
      defaultSenderEmailAddress:
          defaultSenderEmailAddress ?? this.defaultSenderEmailAddress,
      defaultEmailSenderName:
          defaultEmailSenderName ?? this.defaultEmailSenderName,
      returnRefund: returnRefund ?? this.returnRefund,
      orderNumberPrefix: orderNumberPrefix ?? this.orderNumberPrefix,
      orderNumberSuffix: orderNumberSuffix ?? this.orderNumberSuffix,
      defaultTaxId: defaultTaxId ?? this.defaultTaxId,
      orderHandlingCost: orderHandlingCost ?? this.orderHandlingCost,
      autoArchiveOrder: autoArchiveOrder ?? this.autoArchiveOrder,
      defaultPaymentMethodId:
          defaultPaymentMethodId ?? this.defaultPaymentMethodId,
      pagination: pagination ?? this.pagination,
      showShopDescWithListing:
          showShopDescWithListing ?? this.showShopDescWithListing,
      showRefundPolicyWithListing:
          showRefundPolicyWithListing ?? this.showRefundPolicyWithListing,
      alertQuantity: alertQuantity ?? this.alertQuantity,
      digitalGoodsOnly: digitalGoodsOnly ?? this.digitalGoodsOnly,
      defaultWarehouseId: defaultWarehouseId ?? this.defaultWarehouseId,
      defaultSupplierId: defaultSupplierId ?? this.defaultSupplierId,
      // defaultPackagingIds: defaultPackagingIds ?? this.defaultPackagingIds,
      notifyAlertQuantity: notifyAlertQuantity ?? this.notifyAlertQuantity,
      notifyAbandonedCheckout:
          notifyAbandonedCheckout ?? this.notifyAbandonedCheckout,
      notifyInventoryOut: notifyInventoryOut ?? this.notifyInventoryOut,
      notifyNewChat: notifyNewChat ?? this.notifyNewChat,
      notifyNewDisput: notifyNewDisput ?? this.notifyNewDisput,
      notifyNewMessage: notifyNewMessage ?? this.notifyNewMessage,
      notifyNewOrder: notifyNewOrder ?? this.notifyNewOrder,
      enableLiveChat: enableLiveChat ?? this.enableLiveChat,
      // maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      // pendingVerification: pendingVerification ?? this.pendingVerification,
      // createdAt: createdAt ?? this.createdAt,
      // updatedAt: updatedAt ?? this.updatedAt,
      activeEcommerce: activeEcommerce ?? this.activeEcommerce,
      payOnline: payOnline ?? this.payOnline,
      payInPerson: payInPerson ?? this.payInPerson,
    );
  }

  factory UpdateShopConfigsModel.fromMap(Map<String, dynamic> map) =>
      UpdateShopConfigsModel(
        shopId: map["shop_id"]?.toInt() ?? 0,
        supportPhone: map["support_phone"],
        supportPhoneTollFree: map["support_phone_toll_free"],
        supportEmail: map["support_email"] ?? '',
        supportAgent: map["support_agent"],
        defaultSenderEmailAddress: map["default_sender_email_address"] ?? '',
        defaultEmailSenderName: map["default_email_sender_name"] ?? '',
        returnRefund: map["return_refund"] ?? '',
        orderNumberPrefix: map["order_number_prefix"],
        orderNumberSuffix: map["order_number_suffix"],
        defaultTaxId: map["default_tax_id"]?.toInt() ?? 0,
        orderHandlingCost: map["order_handling_cost"] ?? '',
        autoArchiveOrder: map["auto_archive_order"] ?? false,
        defaultPaymentMethodId: map["default_payment_method_id"],
        pagination: map["pagination"] ?? 0,
        showShopDescWithListing: map["show_shop_desc_with_listing"],
        showRefundPolicyWithListing:
            map["show_refund_policy_with_listing"]?.toInt() ?? 0,
        alertQuantity: map["alert_quantity"],
        digitalGoodsOnly: map["digital_goods_only"] ?? false,
        defaultWarehouseId: map["default_warehouse_id"],
        defaultSupplierId: map["default_supplier_id"],
        // defaultPackagingIds: map["default_packaging_ids"] ?? false,
        notifyNewMessage: map["notify_new_message"] ?? false,
        notifyAlertQuantity: map["notify_alert_quantity"] ?? false,
        notifyInventoryOut: map["notify_inventory_out"] ?? false,
        notifyNewOrder: map["notify_new_order"] ?? false,
        notifyAbandonedCheckout: map["notify_abandoned_checkout"] ?? false,
        notifyNewDisput: map["notify_new_disput"] ?? false,
        enableLiveChat: map["enable_live_chat"] ?? false,
        notifyNewChat: map["notify_new_chat"] ?? false,
        // maintenanceMode: map["maintenance_mode"] ?? false,
        // pendingVerification: map["pending_verification"],
        // createdAt: DateTime.parse(map["created_at"]),
        // updatedAt: DateTime.parse(map["updated_at"]),
        activeEcommerce: map["active_ecommerce"]?.toInt() ?? 0,
        payOnline: map["pay_online"]?.toInt() ?? 0,
        payInPerson: map["pay_in_person"]?.toInt() ?? 0,
      );

  factory UpdateShopConfigsModel.init() => const UpdateShopConfigsModel(
        shopId: 0,
        supportPhone: null,
        supportPhoneTollFree: null,
        supportEmail: '',
        supportAgent: null,
        defaultSenderEmailAddress: '',
        defaultEmailSenderName: '',
        returnRefund: '',
        orderNumberPrefix: '',
        orderNumberSuffix: '',
        defaultTaxId: 0,
        orderHandlingCost: '',
        autoArchiveOrder: 0,
        defaultPaymentMethodId: null,
        pagination: 0,
        showShopDescWithListing: null,
        showRefundPolicyWithListing: 0,
        alertQuantity: 0,
        digitalGoodsOnly: 0,
        defaultWarehouseId: 0,
        defaultSupplierId: 0,
        // defaultPackagingIds: 0,
        notifyNewMessage: 0,
        notifyAlertQuantity: 0,
        notifyInventoryOut: 0,
        notifyNewOrder: 0,
        notifyAbandonedCheckout: 0,
        notifyNewDisput: 0,
        enableLiveChat: 0,
        notifyNewChat: 0,
        // maintenanceMode: false,
        // pendingVerification: false,
        // createdAt: DateTime(1990, 1, 1, 0, 0, 0, 0, 0),
        // updatedAt: DateTime(1990, 1, 1, 0, 0, 0, 0, 0),
        activeEcommerce: 0,
        payOnline: 0,
        payInPerson: 0,
      );

  @override
  List<Object?> get props => [
        shopId,
        supportPhone,
        supportPhoneTollFree,
        supportEmail,
        supportAgent,
        defaultSenderEmailAddress,
        defaultEmailSenderName,
        returnRefund,
        orderNumberPrefix,
        orderNumberSuffix,
        defaultTaxId,
        orderHandlingCost,
        // autoArchiveOrder,
        defaultPaymentMethodId,
        pagination,
        showShopDescWithListing,
        showRefundPolicyWithListing,
        alertQuantity,
        digitalGoodsOnly,
        defaultWarehouseId,
        defaultSupplierId,
        // defaultPackagingIds,
        notifyNewMessage,
        notifyAlertQuantity,
        notifyInventoryOut,
        notifyNewOrder,
        notifyAbandonedCheckout,
        notifyNewDisput,
        enableLiveChat,
        notifyNewChat,
        // maintenanceMode,
        // pendingVerification,
        // createdAt,
        // updatedAt,
        activeEcommerce,
        payOnline,
        payInPerson,
      ];
}
