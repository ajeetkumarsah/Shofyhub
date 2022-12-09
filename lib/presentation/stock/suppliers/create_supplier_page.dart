import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/create_supplier_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class CreateSupplierPage extends HookConsumerWidget {
  const CreateSupplierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final IList<KeyValueData> countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final ValueNotifier<KeyValueData?> selectedCountry = useState(null);

    final nameController = useTextEditingController();
    final addressLine1Controller = useTextEditingController();
    final addressLine2Controller = useTextEditingController();
    final contactPersonController = useTextEditingController();
    final cityController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final urlController = useTextEditingController();
    final zipCodeController = useTextEditingController();
    final active = useState(true);
    final buttonPressed = useState(false);

    ref.listen<SupplierState>(supplierProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          buttonPressed.value = false;
          NotificationHelper.success(message: 'supplier_added'.tr());
          Navigator.of(context).pop();
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
    final loading =
        ref.watch(supplierProvider.select((value) => value.loading));
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text('add_suppliers'.tr()),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: nameController,
                    lebelText: '${'name'.tr()} *',
                    validator: (text) => ValidatorLogic.requiredField(text,
                        fieldName: 'name'.tr()),
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: emailController,
                    lebelText: 'email'.tr(),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: phoneController,
                    lebelText: 'phone'.tr(),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  KMultiLineTextField(
                    controller: descriptionController,
                    lebelText: 'description'.tr(),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    // height: 50.h,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<KeyValueData?>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        style: TextStyle(color: Colors.grey.shade800),
                        isExpanded: true,
                        value: selectedCountry.value,
                        hint: Text('${'select_country'.tr()} *'),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        items: countryList.map<DropdownMenuItem<KeyValueData?>>(
                            (KeyValueData? value) {
                          return DropdownMenuItem<KeyValueData?>(
                            value: value,
                            child: Text(
                              value!.value,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        onChanged: (KeyValueData? newValue) {
                          selectedCountry.value = newValue;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  KTextField(
                    controller: addressLine1Controller,
                    lebelText: 'address_line_1'.tr(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  KTextField(
                    controller: addressLine2Controller,
                    lebelText: 'address_line_2'.tr(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  KTextField(
                    controller: contactPersonController,
                    lebelText: 'contact_person'.tr(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  KTextField(
                    controller: cityController,
                    lebelText: 'city'.tr(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  KTextField(
                    controller: urlController,
                    lebelText: 'url'.tr(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  KTextField(
                    controller: zipCodeController,
                    lebelText: 'zip_code'.tr(),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CheckboxListTile(
                      title: Text('active'.tr()),
                      value: active.value,
                      onChanged: (value) {
                        active.value = value!;
                      }),
                  SizedBox(height: 10.h),
                  const RequiredFieldText(),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'cancel'.tr(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: loading
                            ? null
                            : () {
                                buttonPressed.value = true;
                                if (selectedCountry.value == null) {
                                  NotificationHelper.info(
                                      message: 'please_select_a_country'.tr());
                                } else {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    final supplierInfo = CreateSupplierModel(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      addressLine1: addressLine1Controller.text,
                                      addressLine2: addressLine2Controller.text,
                                      contactPerson:
                                          contactPersonController.text,
                                      city: cityController.text,
                                      description: descriptionController.text,
                                      url: urlController.text,
                                      zipCode: zipCodeController.text,
                                      countryId: selectedCountry.value != null
                                          ? int.tryParse(
                                              selectedCountry.value!.key)!
                                          : 0,
                                      // stateId: 0,
                                      active: active.value ? 1 : 0,
                                    );

                                    ref
                                        .read(supplierProvider.notifier)
                                        .createNewSupplier(
                                            supplierInfo: supplierInfo);
                                  }
                                }
                              },
                        child: loading
                            ? const CircularProgressIndicator()
                            : Text('add'.tr()),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
