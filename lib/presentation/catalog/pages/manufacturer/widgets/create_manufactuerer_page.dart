import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_provider.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_state.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class CreateManufactuererPage extends HookConsumerWidget {
  const CreateManufactuererPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final IList<KeyValueData> countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final ValueNotifier<KeyValueData?> selectedCountry = useState(null);

    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final urlController = useTextEditingController();

    final active = useState(true);
    ref.listen<ManufacturerState>(manufacturerProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: const Text('Manufacturer added'),
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
    final loading =
        ref.watch(manufacturerProvider.select((value) => value.loading));
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
        title: const Text('Add Manufactuerer'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      controller: descController, lebelText: 'Description'),
                  SizedBox(height: 10.h),
                  KTextField(controller: emailController, lebelText: 'Email'),
                  SizedBox(height: 10.h),
                  KTextField(
                    controller: phoneController,
                    lebelText: 'Phone',
                    numberFormatters: true,
                  ),
                  SizedBox(height: 10.h),
                  KTextField(
                      controller: urlController, lebelText: 'Official Website'),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 50.h,
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
                        hint: const Text('Select Country'),
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
                      title: const Text('Active Status'),
                      value: active.value,
                      onChanged: (value) {
                        active.value = value!;
                      }),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            ref
                                .read(manufacturerProvider.notifier)
                                .createManufacturer(
                                    name: nameController.text,
                                    slug: nameController.text
                                        .toLowerCase()
                                        .replaceAll(RegExp(r' '), '-'),
                                    url: urlController.text,
                                    active: active.value,
                                    countryId: selectedCountry.value != null
                                        ? selectedCountry.value!.key
                                        : '',
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    description: descController.text);
                          }
                        },
                        child: loading
                            ? const CircularProgressIndicator()
                            : const Text('Add'),
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
