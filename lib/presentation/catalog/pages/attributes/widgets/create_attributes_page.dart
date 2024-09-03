import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/catalog/atributes/atributes_provider.dart';
import 'package:alpesportif_seller/application/app/catalog/atributes/atributes_state.dart';
import 'package:alpesportif_seller/application/app/catalog/atributes/get_atributes_provider.dart';
import 'package:alpesportif_seller/application/app/form/category_list_provider.dart';
import 'package:alpesportif_seller/application/core/notification_helper.dart';
import 'package:alpesportif_seller/domain/app/catalog/atributes/attribute_type_model.dart';
import 'package:alpesportif_seller/domain/app/form/key_value_data.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/core/widgets/required_field_text.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/select_multiple_key_value.dart';
import 'package:alpesportif_seller/presentation/widget_for_all/validator_logic.dart';

class CreateAttributesPage extends HookConsumerWidget {
  const CreateAttributesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(categoryListProvider.notifier).loadData();
      });
      return null;
    }, []);
    final allCategories =
        ref.watch(categoryListProvider.select((value) => value.dataList));

    final nameController = useTextEditingController();
    final orderController = useTextEditingController();
    final ValueNotifier<IList<KeyValueData>> selectedCategories =
        useState(const IListConst([]));
    final List<AttributeTypeModel> attributes =
        ref.watch(getAttributesProvider.select((value) => value.attributeType));

    final ValueNotifier<AttributeTypeModel> selectedAttributes =
        useState(attributes[0]);

    final loading =
        ref.watch(atributesProvider.select((value) => value.loading));

    final buttonPressed = useState(false);

    ref.listen<AtributesState>(atributesProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          Navigator.of(context).pop();
          NotificationHelper.success(message: 'attribute_added'.tr());
          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });
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
        title: Text('add_attribute'.tr()),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                      value: selectedAttributes.value,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: attributes
                          .map<DropdownMenuItem<AttributeTypeModel>>(
                              (AttributeTypeModel value) {
                        return DropdownMenuItem<AttributeTypeModel>(
                          value: value,
                          child: Text(
                            value.name,
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (AttributeTypeModel? newValue) {
                        selectedAttributes.value = newValue!;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                KTextField(
                  controller: orderController,
                  lebelText: 'Order',
                  numberFormatters: true,
                ),
                SizedBox(height: 10.h),
                MultipleKeyValueSelector(
                    title: "select_categories".tr(),
                    allData: allCategories,
                    onSelect: (list) {
                      selectedCategories.value = list;
                    }),
                // SearchChoices<CategoriesModel>.multiple(
                //   items: List<DropdownMenuItem<CategoriesModel>>.from(
                //       categoriesList.map<DropdownMenuItem<CategoriesModel>>(
                //           (e) => DropdownMenuItem<CategoriesModel>(
                //                 value: e,
                //                 child: Text(
                //                   e.name,
                //                   textDirection: TextDirection.rtl,
                //                 ),
                //               ))),
                //   selectedItems: selectedCategories.value.unlock,
                //   hint: const Padding(
                //     padding: EdgeInsets.all(12.0),
                //     child: Text("Select Categories"),
                //   ),
                //   searchHint: "Select Categories",
                //   onChanged: (List<int> value) {
                //     selectedCategories.value = value.lock;
                //     Logger.i(selectedCategories.value);

                //     //  selectedCategories.value = value;
                //   },
                //   closeButton: (selectedItems) {
                //     return (selectedItems.isNotEmpty
                //         ? "Save ${selectedItems.length == 1 ? '"${categoriesList[selectedItems.first].name}"' : '(${selectedItems.length})'}"
                //         : "Save without selection");
                //   },
                //   isExpanded: true,
                // ),
                // MultiSelectDropDown(
                //   onOptionSelected: (List<ValueItem> selectedOptions) {
                //     selectedCategories.value = selectedOptions.lock;
                //   },
                //   options: List<ValueItem>.from(categoriesList
                //       .map((e) => ValueItem(label: e.name, value: e.id))),
                //   selectionType: SelectionType.multi,
                //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                //   dropdownHeight: 300,
                //   optionTextStyle: const TextStyle(fontSize: 16),
                //   selectedOptionIcon: const Icon(Icons.check_circle),
                // ),

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
                              if (formKey.currentState?.validate() ?? false) {
                                final String endPoint = selectedCategories.value
                                    .map((element) => element.key)
                                    .map((id) => "categories_ids[]=$id")
                                    .join('&');

                                Logger.i(endPoint);
                                ref
                                    .read(atributesProvider.notifier)
                                    .createAtributes(
                                      name: nameController.text,
                                      attributeTypeId:
                                          selectedAttributes.value.id,
                                      categoriesIds: endPoint,
                                      order: orderController.text,
                                    );
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
          ),
        ),
      ),
    );
  }
}
