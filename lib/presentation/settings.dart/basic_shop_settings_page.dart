import 'dart:developer';

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
import 'package:zcart_seller/application/app/shop/taxes/tax_provider.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_provider.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/domain/app/settings/update_basic_shop_settings_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/settings.dart/advance_shop_settings_page.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class ShopSettingsPage extends HookConsumerWidget {
  const ShopSettingsPage({Key? key}) : super(key: key);

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
        ref.read(shopSettingsProvider.notifier).getBasicShopSettings();
      });
      return null;
    }, []);

    final nameController = useTextEditingController();
    final legalNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final buttonPressed = useState(false);

    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.basicShopSettings.name;
        legalNameController.text = next.basicShopSettings.legalName;
        emailController.text = next.basicShopSettings.email;
        descriptionController.text = next.basicShopSettings.description;
      }
    });
    ref.listen<ShopSettingsState>(shopSettingsProvider, (previous, next) {
      if (previous != next && !next.loading && buttonPressed.value) {
        // Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: Text('basic_shop_settings_updated'.tr()),
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
        title: Text('basic_shop_settings'.tr()),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const AdvanceShopSettingsPage()));
              },
              child: const Text('Advance Settings'))
        ],
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
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: nameController,
                        lebelText: '${'name'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'title'.tr()),
                      ),
                      SizedBox(height: 10.h),
                      KTextField(
                          controller: legalNameController,
                          lebelText: 'legal_name'.tr()),
                      SizedBox(height: 10.h),
                      KTextField(
                        controller: descriptionController,
                        lebelText: '${'description'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'description'.tr()),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      KTextField(
                        controller: emailController,
                        lebelText: '${'email'.tr()} *',
                        validator: (text) => ValidatorLogic.requiredField(text,
                            fieldName: 'email'.tr()),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                final basicSettings =
                                    UpdateBasicShopSettingsModel(
                                  shopId: shopId,
                                  name: nameController.text,
                                  slug: nameController.text
                                      .toLowerCase()
                                      .replaceAll(RegExp(r' '), '-'),
                                  legalName: legalNameController.text,
                                  email: emailController.text,
                                  description: descriptionController.text,
                                );
                                ref
                                    .read(shopSettingsProvider.notifier)
                                    .updateBasicShopSettings(
                                        basicSettingsInfo: basicSettings,
                                        shopId: shopId);
                                buttonPressed.value = true;
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
