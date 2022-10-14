import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_details_provider.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_details_state.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_provider.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_state.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class EditManufactuererPage extends HookConsumerWidget {
  final int manufacturerId;
  const EditManufactuererPage({Key? key, required this.manufacturerId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(manufacturerDetailsProvider(manufacturerId).notifier)
            .getManufacturerDetails();
      });
      return null;
    }, []);
    final IList<KeyValueData> countryList =
        ref.watch(countryProvider.select((value) => value.dataList));

    final ValueNotifier<KeyValueData?> selectedCountry = useState(null);

    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final urlController = useTextEditingController();

    ref.listen<ManufacturerDetailsState>(
        manufacturerDetailsProvider(manufacturerId), (previous, next) {
      if (previous != next && !next.loading) {
        nameController.text = next.manufacturerDetails.name;
        descController.text = next.manufacturerDetails.description;
        emailController.text = next.manufacturerDetails.email;
        phoneController.text = next.manufacturerDetails.phone;
        urlController.text = next.manufacturerDetails.url;
        selectedCountry.value = countryList
            .where((e) => e.value == next.manufacturerDetails.origin)
            .toList()[0];
      }
    });
    final loadingDetails = ref.watch(manufacturerDetailsProvider(manufacturerId)
        .select((value) => value.loading));
    final manufactuererDetails = ref.watch(
        manufacturerDetailsProvider(manufacturerId)
            .select((value) => value.manufacturerDetails));

    final buttonPressed = useState(false);
    ref.listen<ManufacturerState>(manufacturerProvider, (previous, next) {
      if (previous != next && !next.loading && buttonPressed.value) {
        Navigator.of(context).pop();
        buttonPressed.value = false;
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: Text('manufacturer_updated'.tr()),
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
        title: Text('edit_manufactuerer'.tr()),
        elevation: 0,
      ),
      body: loadingDetails
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
                          lebelText: 'Name *',
                          validator: (text) => ValidatorLogic.requiredField(
                              text,
                              fieldName: 'Name'),
                        ),
                        SizedBox(height: 10.h),
                        KTextField(
                            controller: descController,
                            lebelText: 'Description'),
                        SizedBox(height: 10.h),
                        KTextField(
                            controller: emailController, lebelText: 'Email'),
                        SizedBox(height: 10.h),
                        KTextField(
                          controller: phoneController,
                          lebelText: 'Phone',
                          numberFormatters: true,
                        ),
                        SizedBox(height: 10.h),
                        KTextField(
                            controller: urlController,
                            lebelText: 'Official Website'),
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
                          height: 30.h,
                        ),
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
                                if (formKey.currentState?.validate() ?? false) {
                                  buttonPressed.value = true;
                                  ref
                                      .read(manufacturerProvider.notifier)
                                      .updateManufacturer(
                                          manufacturerId: manufacturerId,
                                          name: nameController.text.isEmpty
                                              ? manufactuererDetails.name
                                              : nameController.text,
                                          slug: manufactuererDetails.slug,
                                          url: urlController.text.isEmpty
                                              ? manufactuererDetails.url
                                              : urlController.text,
                                          active: false,
                                          countryId:
                                              selectedCountry.value != null
                                                  ? selectedCountry.value!.key
                                                  : '',
                                          email: emailController.text.isEmpty
                                              ? manufactuererDetails.email
                                              : emailController.text,
                                          phone: phoneController.text.isEmpty
                                              ? manufactuererDetails.phone
                                              : phoneController.text,
                                          description: descController
                                                  .text.isEmpty
                                              ? manufactuererDetails.description
                                              : descController.text);
                                }
                              },
                              child: loading
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
