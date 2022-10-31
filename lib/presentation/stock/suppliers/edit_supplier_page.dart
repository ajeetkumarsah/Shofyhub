
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_details_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_details_state.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/app/stocks/supplier/create_supplier_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_multiline_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class EditSupplierPage extends HookConsumerWidget {
  const EditSupplierPage({Key? key, required this.supplierId})
      : super(key: key);
  final int supplierId;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(supplierDetailsProvider.notifier)
            .getSupplierDetails(supplierId: supplierId);
      });
      return null;
    }, []);

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

    final loading =
        ref.watch(supplierDetailsProvider.select((value) => value.loading));

    final updateLoading =
        ref.watch(supplierProvider.select((value) => value.loading));
    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen<SupplierDetailsState>(supplierDetailsProvider, (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.supplierDetails.name;
        addressLine1Controller.text =
            next.supplierDetails.primaryAddress.addressLine1;
        addressLine2Controller.text =
            next.supplierDetails.primaryAddress.addressLine2;
        contactPersonController.text = next.supplierDetails.contactPerson;
        cityController.text = next.supplierDetails.primaryAddress.city;
        descriptionController.text = next.supplierDetails.description;
        emailController.text = next.supplierDetails.email;
        phoneController.text = next.supplierDetails.primaryAddress.phone;
        phoneController.text = next.supplierDetails.primaryAddress.phone;
        urlController.text = next.supplierDetails.url;
        zipCodeController.text = next.supplierDetails.primaryAddress.zipCode;
        active.value = next.supplierDetails.active;
        selectedCountry.value = countryList
            .where((e) =>
                e.value == next.supplierDetails.primaryAddress.country.name)
            .toList()[0];
      }
    });

    ref.listen<SupplierState>(supplierProvider, (previous, next) {
      if (previous != next && !next.loading && buttonPressed.value) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'supplier_updated'.tr());
          // CherryToast.info(
          //   title: Text('supplier_updated'.tr()),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
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
        title: Text('update_supplier'.tr()),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
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
                                  NotificationHelper.info(message: 'please_select_a_country'.tr());
                                  // CherryToast.info(
                                  //   title: Text('please_select_a_country'.tr()),
                                  //   animationType: AnimationType.fromTop,
                                  // ).show(context);
                                } else {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    buttonPressed.value = true;

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
                                        .updateSupplier(
                                            supplierInfo: supplierInfo,
                                            supplierId: supplierId);
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
