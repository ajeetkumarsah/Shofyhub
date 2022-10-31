import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/shop/taxes/tax_provider.dart';
import 'package:zcart_seller/application/app/shop/taxes/tax_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/domain/app/shop/taxes/create_tax_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class CreateTaxPage extends HookConsumerWidget {
  const CreateTaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final IList<KeyValueData> countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final ValueNotifier<KeyValueData?> selectedCountry = useState(null);

    final nameController = useTextEditingController();
    final taxRateController = useTextEditingController();
    final active = useState(true);

    ref.listen<TaxState>(taxProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'tax_added'.tr());
          // CherryToast.info(
          //   title: Text('tax_added'.tr()),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
          // CherryToast.error(
          //   title: Text(
          //     next.failure.error,
          //   ),
          //   toastPosition: Position.bottom,
          // ).show(context);
        }
      }
    });
    final loading = ref.watch(taxProvider.select((value) => value.loading));
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
        title: Text('add_tax'.tr()),
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
                  Text('* Required fields.',
                      style: TextStyle(color: Theme.of(context).hintColor)),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: nameController,
                    lebelText: 'Name *',
                    validator: (text) =>
                        ValidatorLogic.requiredField(text, fieldName: 'Name'),
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: taxRateController,
                    lebelText: 'Tax Rate',
                    numberFormatters: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    // height: 50.h,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<KeyValueData?>(
                        // onTap: () {
                        //   countryDropdownList.value = countryList;
                        // },
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
                            if (formKey.currentState?.validate() ?? false) {
                              final taxInfo = CreateTaxModel(
                                  name: nameController.text,
                                  taxrate:
                                      double.tryParse(taxRateController.text)!,
                                  countryId: selectedCountry.value != null
                                      ? selectedCountry.value!.key
                                      : '',
                                  stateId: '',
                                  active: active.value ? 1 : 0);
                              ref
                                  .read(taxProvider.notifier)
                                  .createNewTAx(taxInfo: taxInfo);
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
