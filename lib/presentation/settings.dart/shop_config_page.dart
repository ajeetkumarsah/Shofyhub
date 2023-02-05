import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_provider.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_state.dart';
import 'package:zcart_seller/application/app/shop/taxes/tax_provider.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_provider.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_provider.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/settings/payment_method_model.dart';
import 'package:zcart_seller/domain/app/settings/update_shop_configs_model.dart';
import 'package:zcart_seller/domain/app/shop/taxes/tax_model.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/supplier_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/warehouse_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/error_text.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class ShopConfigPage extends HookConsumerWidget {
  const ShopConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final shopId =
        ref.watch(authProvider.select((value) => value.user.shop_id));
    final loading =
        ref.watch(shopSettingsProvider.select((value) => value.loading));

    final updateLoading =
        ref.watch(shopSettingsProvider.select((value) => value.loadingUpdate));

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(shopSettingsProvider.notifier).getShopConfigs();
      });
      return null;
    }, []);

    final alertQuanityController = useTextEditingController();
    final supportPhoneController = useTextEditingController();
    final supportPhoneTollFreeController = useTextEditingController();
    final supportEmailController = useTextEditingController();
    // final supportAgentController = useTextEditingController();
    final defaultSenderEmailController = useTextEditingController();
    final defaultEmailSenderNameController = useTextEditingController();
    final returnRefundController = useTextEditingController();
    final orderNumerPrefixController = useTextEditingController();
    final orderNumberSuffixController = useTextEditingController();
    final defaultTaxIdController = useTextEditingController();
    final orderHandlingCostController = useTextEditingController();
    final paginationController = useTextEditingController();

    // final activeEcommerceController = useTextEditingController();
    // final payOnlineController = useTextEditingController();
    // final payInPersonController = useTextEditingController();

    final autoArchiveOrder = useState(false);
    final showShopDescriptionWithListing = useState(false);
    final showRefundPolicyWithListing = useState(false);
    final autoArchiveOrderController = useState(false);
    final digitalGoodsOnly = useState(false);
    // final defaultPackagingIds = useState(false);
    final notifyNewMessage = useState(false);
    final notifyAlertQuantity = useState(false);
    final notifyInventoryOut = useState(false);
    final notifyNewOrder = useState(false);
    final notifyAbandonedCheckout = useState(false);
    final notifyNewDisput = useState(false);
    final enableLiveChat = useState(false);
    final notifyNewChat = useState(false);
    final maintenanceMode = useState(false);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final buttonPressed = useState(false);

    final List<TaxModel> taxList =
        ref.watch(taxProvider.select((value) => value.taxList));
    final ValueNotifier<TaxModel?> selectedTax = useState(null);

    final List<ShopUsersModel> agentList =
        ref.watch(shopUserProvider.select((value) => value.getShopUser));
    final ValueNotifier<ShopUsersModel?> selectedAgent =
        agentList.isEmpty ? useState(null) : useState(agentList[0]);

    final List<SupplierModel> supplierList =
        ref.watch(supplierProvider.select((value) => value.allSuppliers));
    final ValueNotifier<SupplierModel?> selectedSupplier = useState(null);

    final List<WarehouseModel> warehouseList =
        ref.watch(warehouseProvider.select((value) => value.warehouseItemList));
    final ValueNotifier<WarehouseModel?> selectedWarehouse = useState(null);

    const List<PaymentMethodModel> paymentMethodList = [
      PaymentMethodModel(id: 1, title: 'Cash On Delivery'),
      PaymentMethodModel(id: 2, title: 'Bank Wire Transfer'),
      PaymentMethodModel(id: 3, title: 'PayPal Express Checkout'),
      PaymentMethodModel(id: 4, title: 'Stripe'),
    ];
    final ValueNotifier<PaymentMethodModel?> selectedPaymentMethod =
        useState(null);

    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) {
      if (previous != next && !next.loading) {
        alertQuanityController.text = next.shopConfigs.alertQuantity.toString();
        supportPhoneController.text = next.shopConfigs.supportPhone;
        supportPhoneTollFreeController.text =
            next.shopConfigs.supportPhoneTollFree;
        supportEmailController.text = next.shopConfigs.supportEmail;
        // supportAgentController.text = next.shopConfigs.supportAgent;

        paginationController.text = next.shopConfigs.pagination.toString();
        defaultSenderEmailController.text =
            next.shopConfigs.defaultSenderEmailAddress;
        defaultEmailSenderNameController.text =
            next.shopConfigs.defaultEmailSenderName;
        returnRefundController.text = next.shopConfigs.returnRefund;
        orderNumerPrefixController.text = next.shopConfigs.orderNumberPrefix;
        orderNumberSuffixController.text = next.shopConfigs.orderNumberSuffix;
        defaultTaxIdController.text = next.shopConfigs.defaultTaxId.toString();
        orderHandlingCostController.text = next.shopConfigs.orderHandlingCost;

        autoArchiveOrder.value = next.shopConfigs.autoArchiveOrder;
        showShopDescriptionWithListing.value =
            next.shopConfigs.showShopDescWithListing == 1 ? true : false;
        showRefundPolicyWithListing.value =
            next.shopConfigs.showRefundPolicyWithListing == 1 ? true : false;
        autoArchiveOrderController.value = next.shopConfigs.autoArchiveOrder;
        digitalGoodsOnly.value = next.shopConfigs.digitalGoodsOnly;

        notifyNewMessage.value = next.shopConfigs.notifyNewMessage;
        notifyAlertQuantity.value = next.shopConfigs.notifyAlertQuantity;
        notifyInventoryOut.value = next.shopConfigs.notifyInventoryOut;
        notifyNewOrder.value = next.shopConfigs.notifyNewOrder;
        notifyAbandonedCheckout.value =
            next.shopConfigs.notifyAbandonedCheckout;
        notifyNewDisput.value = next.shopConfigs.notifyNewDisput;
        enableLiveChat.value = next.shopConfigs.enableLiveChat;
        notifyNewChat.value = next.shopConfigs.notifyNewChat;
        maintenanceMode.value = next.shopConfigs.maintenanceMode;

        var selectedAgenList = agentList
            .where((e) => e.id == next.shopConfigs.supportAgent)
            .toList();
        selectedAgent.value =
            selectedAgenList.isNotEmpty ? selectedAgenList[0] : null;

        selectedPaymentMethod.value = next.shopConfigs.defaultPaymentMethodId !=
                null
            ? paymentMethodList
                .where((e) => e.id == next.shopConfigs.defaultPaymentMethodId)
                .toList()[0]
            : PaymentMethodModel.init();

        var selectedWarehouseList = warehouseList
            .where((e) => e.id == next.shopConfigs.defaultWarehouseId)
            .toList();

        selectedWarehouse.value =
            selectedWarehouseList.isEmpty ? null : selectedWarehouseList[0];

        var selectedSupplierList = supplierList
            .where((e) => e.id == next.shopConfigs.defaultSupplierId)
            .toList();

        selectedSupplier.value =
            supplierList.isEmpty || selectedSupplierList.isEmpty
                ? null
                : selectedSupplierList[0];

        var selectedTaxList = taxList
            .where((e) => e.id == next.shopConfigs.defaultTaxId)
            .toList();

        selectedTax.value = selectedTaxList.isEmpty ? null : selectedTaxList[0];
      }
    });
    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          buttonPressed.value = false;
          NotificationHelper.success(
              message: 'shop_configuration_updated'.tr());
          Navigator.of(context).pop();
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        elevation: 0,
        title: Text('shop_configuration'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()))
              : Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // INVENTORY
                      Text(
                        'inventory'.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      KTextField(
                        controller: alertQuanityController,
                        lebelText: 'alert_quantity'.tr(),
                        numberFormatters: true,
                      ),
                      SizedBox(height: 10.h),
                      Text('default_supplier'.tr()),
                      SizedBox(height: 10.h),
                      supplierList.isEmpty
                          ? const ErrorText(
                              text: 'No supplier found. Please add a Supplier')
                          : SizedBox(
                              // height: 50.h,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.w),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.grey.shade800),
                                  isExpanded: true,
                                  value: selectedSupplier.value,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                                  items: supplierList
                                      .map<DropdownMenuItem<SupplierModel>>(
                                          (SupplierModel value) {
                                    return DropdownMenuItem<SupplierModel>(
                                      value: value,
                                      child: Text(
                                        value.name ?? '',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (SupplierModel? newValue) {
                                    selectedSupplier.value = newValue!;
                                  },
                                ),
                              ),
                            ),
                      SizedBox(height: 10.h),
                      Text('default_warehouse'.tr()),
                      SizedBox(height: 10.h),
                      warehouseList.isEmpty
                          ? const ErrorText(
                              text:
                                  'No warehouse item found. Please add warehouse')
                          : SizedBox(
                              // height: 50.h,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.w),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.grey.shade800),
                                  isExpanded: true,
                                  value: selectedWarehouse.value,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                                  items: warehouseList
                                      .map<DropdownMenuItem<WarehouseModel>>(
                                          (WarehouseModel value) {
                                    return DropdownMenuItem<WarehouseModel>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (WarehouseModel? newValue) {
                                    selectedWarehouse.value = newValue!;
                                  },
                                ),
                              ),
                            ),
                      SizedBox(height: 30.h),

                      // ORDER
                      Text(
                        'order'.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      KTextField(
                        controller: orderNumerPrefixController,
                        lebelText: 'order_number_prefix'.tr(),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: orderNumberSuffixController,
                        lebelText: 'order_number_suffix'.tr(),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'default_payment_method'.tr(),
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        // height: 50.h,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.w),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            style: TextStyle(color: Colors.grey.shade800),
                            isExpanded: true,
                            value: selectedPaymentMethod.value,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            items: paymentMethodList
                                .map<DropdownMenuItem<PaymentMethodModel>>(
                                    (PaymentMethodModel value) {
                              return DropdownMenuItem<PaymentMethodModel>(
                                value: value,
                                child: Text(
                                  value.title,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (PaymentMethodModel? newValue) {
                              selectedPaymentMethod.value = newValue!;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text('default_tax'.tr()),
                      SizedBox(height: 10.h),
                      taxList.isEmpty
                          ? const ErrorText(
                              text: 'No tax found. Please add a Tax')
                          : SizedBox(
                              // height: 50.h,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.w),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.grey.shade800),
                                  isExpanded: true,
                                  value: selectedTax.value,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                                  items: taxList
                                      .map<DropdownMenuItem<TaxModel>>(
                                          (TaxModel value) {
                                    return DropdownMenuItem<TaxModel>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (TaxModel? newValue) {
                                    selectedTax.value = newValue!;
                                  },
                                ),
                              ),
                            ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: orderHandlingCostController,
                        lebelText: 'order_handling_cost'.tr(),
                      ),
                      SizedBox(height: 30.h),

                      // SUPPORT
                      Text(
                        'support'.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      // SwitchListTile(
                      //   value: enableLiveChat.value,
                      //   onChanged: (value) => enableLiveChat.value = value,
                      //   title: Text('enable_live_chat'.tr()),
                      // ),
                      SizedBox(height: 10.h),
                      Text(
                        'support_agent'.tr(),
                      ),
                      SizedBox(height: 10.h),
                      agentList.isEmpty
                          ? const ErrorText(
                              text: 'No agent found. Please add an User')
                          : SizedBox(
                              // height: 50.h,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.w),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.grey.shade800),
                                  isExpanded: true,
                                  value: selectedAgent.value,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                                  items: agentList
                                      .map<DropdownMenuItem<ShopUsersModel>>(
                                          (ShopUsersModel value) {
                                    return DropdownMenuItem<ShopUsersModel>(
                                      value: value,
                                      child: Text(
                                        value.name,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (ShopUsersModel? newValue) {
                                    selectedAgent.value = newValue!;
                                  },
                                ),
                              ),
                            ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: supportPhoneController,
                        lebelText: 'support_phone'.tr(),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: supportPhoneTollFreeController,
                        lebelText: 'toll_free_number'.tr(),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: supportEmailController,
                        lebelText: '${'support_email'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'support_email'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: defaultSenderEmailController,
                        lebelText: '${'default_sender_email'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'default_sender_email'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: defaultEmailSenderNameController,
                        lebelText: '${'default_sender_full_name'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'default_sender_full_name'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KMultiLineTextField(
                        controller: returnRefundController,
                        lebelText: '${'return_and_refund_policy'.tr()} *',
                        maxLines: 4,
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'return_and_refund_policy'.tr()),
                      ),

                      SizedBox(height: 30.h),

                      // VIEWS
                      Text(
                        'views'.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),

                      SizedBox(height: 10.h),
                      KTextField(
                        controller: paginationController,
                        lebelText: 'pagination'.tr(),
                        numberFormatters: true,
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: showShopDescriptionWithListing.value,
                        onChanged: (value) =>
                            showShopDescriptionWithListing.value = value,
                        title: Text('show_description_with_listing'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: showRefundPolicyWithListing.value,
                        onChanged: (value) =>
                            showRefundPolicyWithListing.value = value,
                        title: Text('show_refund_policy_with_listing'.tr()),
                      ),

                      SizedBox(height: 30.h),

                      // NOTIFICATIONS
                      Text('notifications'.tr()),
                      const Divider(),
                      SwitchListTile(
                        value: notifyInventoryOut.value,
                        onChanged: (value) => notifyInventoryOut.value = value,
                        title: Text('low_inventory_alert'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: notifyNewOrder.value,
                        onChanged: (value) => notifyNewOrder.value = value,
                        title: Text('new_order_alert'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: notifyAbandonedCheckout.value,
                        onChanged: (value) =>
                            notifyAbandonedCheckout.value = value,
                        title: Text('abandoned_checkout'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: notifyNewDisput.value,
                        onChanged: (value) => notifyNewDisput.value = value,
                        title: Text('new_dispute'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: notifyAlertQuantity.value,
                        onChanged: (value) => notifyAlertQuantity.value = value,
                        title: Text('stock_out_alert'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: enableLiveChat.value,
                        onChanged: (value) => enableLiveChat.value = value,
                        title: Text('enable_live_chat'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: notifyNewMessage.value,
                        onChanged: (value) => notifyNewMessage.value = value,
                        title: Text('new_message'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      SwitchListTile(
                        value: notifyNewChat.value,
                        onChanged: (value) => notifyNewChat.value = value,
                        title: Text('notify_new_chat_message'.tr()),
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.buttonColor),
                        onPressed: updateLoading
                            ? null
                            : () {
                                if (formKey.currentState?.validate() ?? false) {
                                  final advanceSettings =
                                      UpdateShopConfigsModel(
                                    shopId: shopId,
                                    activeEcommerce: 0,
                                    alertQuantity: int.tryParse(
                                            alertQuanityController.text) ??
                                        0,
                                    autoArchiveOrder:
                                        autoArchiveOrder.value ? 1 : 0,
                                    defaultEmailSenderName:
                                        defaultEmailSenderNameController.text,
                                    // defaultPackagingIds:
                                    //     defaultPackagingIds.value ? 1 : 0,
                                    defaultPaymentMethodId:
                                        selectedPaymentMethod.value != null
                                            ? selectedPaymentMethod.value!.id
                                            : null,
                                    defaultSenderEmailAddress:
                                        defaultSenderEmailController.text,
                                    defaultSupplierId:
                                        selectedSupplier.value != null
                                            ? selectedSupplier.value!.id!
                                            : null,
                                    defaultTaxId: selectedTax.value != null
                                        ? selectedTax.value!.id
                                        : null,
                                    defaultWarehouseId:
                                        selectedWarehouse.value != null
                                            ? selectedWarehouse.value!.id
                                            : null,
                                    digitalGoodsOnly:
                                        digitalGoodsOnly.value ? 1 : 0,
                                    returnRefund: returnRefundController.text,
                                    notifyAbandonedCheckout:
                                        notifyAbandonedCheckout.value ? 1 : 0,
                                    notifyAlertQuantity:
                                        notifyAlertQuantity.value ? 1 : 0,
                                    notifyInventoryOut:
                                        notifyInventoryOut.value ? 1 : 0,
                                    notifyNewChat: notifyNewChat.value ? 1 : 0,
                                    notifyNewDisput:
                                        notifyNewDisput.value ? 1 : 0,
                                    notifyNewMessage:
                                        notifyNewMessage.value ? 1 : 0,
                                    notifyNewOrder:
                                        notifyNewOrder.value ? 1 : 0,
                                    orderHandlingCost:
                                        orderHandlingCostController.text,
                                    orderNumberPrefix:
                                        orderNumerPrefixController.text,
                                    orderNumberSuffix:
                                        orderNumberSuffixController.text,
                                    pagination: int.tryParse(
                                            paginationController.text) ??
                                        0,
                                    payInPerson: 0,
                                    payOnline: 0,
                                    showRefundPolicyWithListing:
                                        showRefundPolicyWithListing.value
                                            ? 1
                                            : 0,
                                    showShopDescWithListing:
                                        showShopDescriptionWithListing.value
                                            ? 1
                                            : 0,
                                    supportAgent: selectedAgent.value != null
                                        ? selectedAgent.value!.id
                                        : null,
                                    supportEmail: supportEmailController.text,
                                    supportPhone: supportPhoneController.text,
                                    supportPhoneTollFree:
                                        supportPhoneTollFreeController.text,
                                    enableLiveChat:
                                        enableLiveChat.value ? 1 : 0,
                                  );
                                  ref
                                      .read(shopSettingsProvider.notifier)
                                      .updateShopConfigs(
                                          advanceSettingsInfo: advanceSettings,
                                          shopId: shopId);

                                  buttonPressed.value = true;
                                }
                              },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50.h,
                          child: Center(
                            child: updateLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : Text(
                                    'update'.tr(),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
