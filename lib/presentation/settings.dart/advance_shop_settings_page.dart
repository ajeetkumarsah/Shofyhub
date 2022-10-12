import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_provider.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_state.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/domain/app/settings/update_basic_shop_settings_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class AdvanceShopSettingsPage extends HookConsumerWidget {
  const AdvanceShopSettingsPage({Key? key}) : super(key: key);

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
        ref.read(shopSettingsProvider.notifier).getAdvanceShopSettings();
      });
      return null;
    }, []);

    final alertQuanityController = useTextEditingController();
    final supportPhoneController = useTextEditingController();
    final supportPhoneTollFreeController = useTextEditingController();
    final supportEmailController = useTextEditingController();
    final supportAgentController = useTextEditingController();
    final defaultSenderEmailController = useTextEditingController();
    final defaultEmailSenderNameController = useTextEditingController();
    final returnRefundController = useTextEditingController();
    final orderNumerPrefixController = useTextEditingController();
    final orderNumberSuffixController = useTextEditingController();
    final defaultTaxIdController = useTextEditingController();
    final orderHandlingCostController = useTextEditingController();
    final paginationController = useTextEditingController();

    final activeEcommerceController = useTextEditingController();
    final payOnlineController = useTextEditingController();
    final payInPersonController = useTextEditingController();

    final autoArchiveOrder = useState(false);
    final showShopDescriptionWithListing = useState(false);
    final autoArchiveOrderController = useState(false);
    final digitalGoodsOnly = useState(false);
    final defaultPackagingIds = useState(false);
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

    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) {
      if (previous != next && !next.loading) {
        alertQuanityController.text = next.advanceShopSettings.alertQuantity;
        supportPhoneController.text = next.advanceShopSettings.supportPhone;
        supportPhoneTollFreeController.text =
            next.advanceShopSettings.supportPhoneTollFree;
        supportEmailController.text = next.advanceShopSettings.supportEmail;
        supportAgentController.text = next.advanceShopSettings.supportAgent;
        paginationController.text =
            next.advanceShopSettings.pagination.toString();
        defaultSenderEmailController.text =
            next.advanceShopSettings.defaultSenderEmailAddress;
        defaultEmailSenderNameController.text =
            next.advanceShopSettings.defaultEmailSenderName;
        returnRefundController.text = next.advanceShopSettings.returnRefund;
        orderNumerPrefixController.text =
            next.advanceShopSettings.orderNumberPrefix;
        orderNumberSuffixController.text =
            next.advanceShopSettings.orderNumberSuffix;
        defaultTaxIdController.text =
            next.advanceShopSettings.defaultTaxId.toString();
        orderHandlingCostController.text =
            next.advanceShopSettings.orderHandlingCost;
        activeEcommerceController.text =
            next.advanceShopSettings.activeEcommerce.toString();
        payOnlineController.text =
            next.advanceShopSettings.payOnline.toString();
        payInPersonController.text =
            next.advanceShopSettings.payInPerson.toString();

        autoArchiveOrder.value = next.advanceShopSettings.autoArchiveOrder;
        showShopDescriptionWithListing.value =
            next.advanceShopSettings.showShopDescWithListing;
        autoArchiveOrderController.value =
            next.advanceShopSettings.autoArchiveOrder;
        digitalGoodsOnly.value = next.advanceShopSettings.digitalGoodsOnly;
        defaultPackagingIds.value =
            next.advanceShopSettings.defaultPackagingIds;
        notifyNewMessage.value = next.advanceShopSettings.notifyNewMessage;
        notifyAlertQuantity.value =
            next.advanceShopSettings.notifyAlertQuantity;
        notifyInventoryOut.value = next.advanceShopSettings.notifyInventoryOut;
        notifyNewOrder.value = next.advanceShopSettings.notifyNewOrder;
        notifyAbandonedCheckout.value =
            next.advanceShopSettings.notifyAbandonedCheckout;
        notifyNewDisput.value = next.advanceShopSettings.notifyNewDisput;
        enableLiveChat.value = next.advanceShopSettings.enableLiveChat;
        notifyNewChat.value = next.advanceShopSettings.notifyNewChat;
        maintenanceMode.value = next.advanceShopSettings.maintenanceMode;
      }
    });
    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) {
      if (previous != next && !next.loading && buttonPressed.value) {
        // Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: Text('advance_shop_settings_updated'.tr()),
            animationType: AnimationType.fromTop,
          ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.error(
            title: Text(
              next.failure.error,
            ),
            toastPosition: Position.bottom,
          ).show(context);
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
        title: Text('advance_shop_settings'.tr()),
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
                      Text('inventory'.tr()),
                      const Divider(),
                      KTextField(
                        controller: alertQuanityController,
                        lebelText: 'order_number_prefix'.tr(),
                        numberFormatters: true,
                      ),
                      SizedBox(height: 30.h),

                      // TODO: default supplier
                      // TODO: default warehouse
                      // TODO: default packaging

                      // ORDER
                      Text('order'.tr()),
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
                      // TODO: default payment method
                      // TODO: default tax
                      KTextField(
                        controller: orderHandlingCostController,
                        lebelText: 'order_handling_cost'.tr(),
                      ),
                      SizedBox(height: 30.h),

                      // SUPPORT
                      Text('support'.tr()),
                      const Divider(),
                      SwitchListTile(
                        value: enableLiveChat.value,
                        onChanged: (value) => enableLiveChat.value = value,
                        title: Text('enable_live_chat'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: supportAgentController,
                        lebelText: 'support_agent'.tr(),
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
                        lebelText: '${'email'.tr()} *',
                        maxLines: 4,
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'email'.tr()),
                      ),

                      SizedBox(height: 30.h),

                      // VIEWS
                      Text('views'.tr()),
                      const Divider(),

                      SizedBox(height: 10.h),
                      KTextField(
                        controller: paginationController,
                        lebelText: 'pagination'.tr(),
                        numberFormatters: true,
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                // final basicSettings =
                                //     UpdateBasicShopSettingsModel(
                                //   shopId: shopId,
                                //   name: nameController.text,
                                //   slug: nameController.text
                                //       .toLowerCase()
                                //       .replaceAll(RegExp(r' '), '-'),
                                //   legalName: legalNameController.text,
                                //   email: emailController.text,
                                //   description: descriptionController.text,
                                // );
                                // ref
                                //     .read(shopSettingsProvider.notifier)
                                //     .updateBasicShopSettings(
                                //         basicSettingsInfo: basicSettings,
                                //         shopId: shopId);
                                // buttonPressed.value = true;

                                // Navigator.of(context).pop();
                              }
                            },
                            child: updateLoading
                                ? const CircularProgressIndicator()
                                : Text('update'.tr()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
