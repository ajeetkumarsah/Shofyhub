import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:zcart_seller/application/app/form/business_days_provider.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_details_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_details_state.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_state.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/select_business_day_provider.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_details_provider.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_details_state.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_provider.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/app/shop/user/get_shop_users_model.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/create_supplier_model.dart';
import 'package:zcart_seller/domain/app/stocks/warehouse/create_update_warehouse_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class EditWarehousePage extends HookConsumerWidget {
  const EditWarehousePage({Key? key, required this.warehouseId})
      : super(key: key);
  final int warehouseId;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(warehouseDetailsProvider.notifier)
            .getWarehouseDetails(warehouseId: warehouseId);
        ref.read(selectBusinessDaysProvider).clear();
      });
      return null;
    }, []);

    final IList<KeyValueData> countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final ValueNotifier<KeyValueData?> selectedCountry = useState(null);

    final List<ShopUsersModel> staffList =
        ref.watch(shopUserProvider.select((value) => value.getShopUser));

    final ValueNotifier<ShopUsersModel?> selectedStaff = useState(null);

    final IList<KeyValueData> businessDaysList =
        ref.watch(businessDaysProvider.select((value) => value.dataList));
    List<String> selectedBusinessDays = [];

    final nameController = useTextEditingController();
    final addressLine1Controller = useTextEditingController();
    final addressLine2Controller = useTextEditingController();
    final cityController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final zipCodeController = useTextEditingController();
    final openingTimeController = useTextEditingController();
    final closingTimeController = useTextEditingController();
    // final inchargeIdController = useTextEditingController();
    final active = useState(true);

    final buttonPressed = useState(false);

    final loading =
        ref.watch(warehouseDetailsProvider.select((value) => value.loading));

    final updateLoading =
        ref.watch(warehouseProvider.select((value) => value.loading));
    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen<WarehouseDetailsState>(warehouseDetailsProvider,
        (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.warehouseDetails.name;
        addressLine1Controller.text =
            next.warehouseDetails.primaryAddress.addressLine1;
        addressLine2Controller.text =
            next.warehouseDetails.primaryAddress.addressLine2;
        cityController.text = next.warehouseDetails.primaryAddress.city;
        descriptionController.text = next.warehouseDetails.description;
        emailController.text = next.warehouseDetails.email;
        phoneController.text = next.warehouseDetails.primaryAddress.phone;
        phoneController.text = next.warehouseDetails.primaryAddress.phone;
        openingTimeController.text = next.warehouseDetails.openingTime;
        closingTimeController.text = next.warehouseDetails.closingTime;
        zipCodeController.text = next.warehouseDetails.primaryAddress.zipCode;
        active.value = next.warehouseDetails.active;
        ref
            .read(selectBusinessDaysProvider)
            .addBusinessDays(next.warehouseDetails.businessDays);

        selectedStaff.value = staffList
            .where((e) => e.id == next.warehouseDetails.incharge.id)
            .toList()[0];

        selectedCountry.value = countryList
            .where((e) =>
                e.value == next.warehouseDetails.primaryAddress.country.name)
            .toList()[0];
      }
    });

    ref.listen<WarehouseState>(warehouseProvider, (previous, next) {
      if (previous != next && !next.loading && buttonPressed.value) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'warehouse_updated'.tr());
          // showSimpleNotification(
          //   Text('warehouse_updated'.tr()),
          //   background: Colors.green,
          // );
          // CherryToast.info(
          //   title: Text('warehouse_updated'.tr()),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: 'next.failure.error'.tr());

          // CherryToast.error(
          //   title: Text(
          //     next.failure.error,
          //   ),
          //   toastPosition: Position.bottom,
          // ).show(context);
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
        title: Text('update_warehouse'.tr()),
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Text('* Required fields.',
                            style:
                                TextStyle(color: Theme.of(context).hintColor)),
                        SizedBox(height: 10.h),
                        KTextField(
                          controller: nameController,
                          lebelText: '${'name'.tr()} *',
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
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
                              hint: Text('select_country'.tr()),
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: countryList
                                  .map<DropdownMenuItem<KeyValueData?>>(
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
                        SizedBox(
                          // height: 50.h,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<ShopUsersModel>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.w),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              style: TextStyle(color: Colors.grey.shade800),
                              isExpanded: true,
                              value: selectedStaff.value,
                              hint: Text('select_incharge'.tr()),
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              items: staffList
                                  .map<DropdownMenuItem<ShopUsersModel>>(
                                      (ShopUsersModel? value) {
                                return DropdownMenuItem<ShopUsersModel>(
                                  value: value,
                                  child: Text(
                                    value!.name.toString(),
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              }).toList(),
                              onChanged: (ShopUsersModel? newValue) {
                                selectedStaff.value = newValue;
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
                        // Business Days
                        Text(
                          'business_days'.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Divider(),
                        MultiSelectContainer<String>(
                            items: businessDaysList
                                .map((element) => MultiSelectCard(
                                    value: element.key,
                                    label: element.value,
                                    selected: ref
                                        .read(selectBusinessDaysProvider)
                                        .selectedBusinessDays
                                        .contains(element.key)))
                                .toList(),
                            onChange: (allSelectedItems, selectedItem) {
                              ref
                                  .read(selectBusinessDaysProvider)
                                  .addBusinessDays(allSelectedItems);
                            }),
                        SizedBox(height: 20.h),
                        KTextField(
                          controller: openingTimeController,
                          lebelText: 'opening_time'.tr(),
                          readOnly: true,
                          suffixIcon: const Icon(Icons.punch_clock),
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
                              fieldName: 'opening_time'.tr()),
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              openingTimeController.text =
                                  '${pickedTime.hour}:${pickedTime.minute}';
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        KTextField(
                          controller: closingTimeController,
                          lebelText: 'closing_time'.tr(),
                          readOnly: true,
                          suffixIcon: const Icon(Icons.punch_clock),
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
                              fieldName: 'closing_time'.tr()),
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              closingTimeController.text =
                                  '${pickedTime.hour}:${pickedTime.minute}';
                            }
                          },
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
                              onPressed: () {
                                if (selectedCountry.value == null) {
                                  NotificationHelper.info(
                                      message: 'please_select_a_country'.tr());
                                } else if (ref
                                    .read(selectBusinessDaysProvider)
                                    .selectedBusinessDays
                                    .isEmpty) {
                                  NotificationHelper.info(
                                      message:
                                          'please_select_business_days'.tr());
                                } else {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    buttonPressed.value = true;

                                    final String endPoint = ref
                                        .read(selectBusinessDaysProvider)
                                        .selectedBusinessDays
                                        .map((element) =>
                                            "business_days[]=$element")
                                        .join('&');
                                    final warehouseInfo =
                                        CreateUpdateWarehouseModel(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      description: descriptionController.text,
                                      addressLine1: addressLine1Controller.text,
                                      addressLine2: addressLine2Controller.text,
                                      openingTime: openingTimeController.text,
                                      closeTime: closingTimeController.text,
                                      inchargeId: selectedStaff.value!.id,
                                      businessDays: endPoint,
                                      city: cityController.text,
                                      countryId: selectedCountry.value != null
                                          ? int.tryParse(
                                              selectedCountry.value!.key)!
                                          : 0,
                                      // stateId: 0,
                                      active: active.value ? 1 : 0,
                                      zipCode: zipCodeController.text,
                                    );
                                    ref
                                        .read(warehouseProvider.notifier)
                                        .updateWarehouse(
                                            warehouseInfo: warehouseInfo,
                                            warehouseId: warehouseId);
                                  }
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
                  )),
            ),
    );
  }
}
