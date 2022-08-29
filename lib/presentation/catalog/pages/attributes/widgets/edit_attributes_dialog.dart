import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/catalog/atributes/atributes_provider.dart';
import 'package:zcart_vendor/application/app/catalog/atributes/atributes_state.dart';
import 'package:zcart_vendor/application/app/catalog/atributes/get_atributes_provider.dart';
import 'package:zcart_vendor/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_vendor/domain/app/catalog/atributes/attribute_type_model.dart';
import 'package:zcart_vendor/domain/app/catalog/atributes/categories_model.dart';
import 'package:zcart_vendor/presentation/widget_for_all/k_text_field.dart';
import 'package:search_choices/search_choices.dart';

class EditAttributesDialog extends HookConsumerWidget {
  final AtributesModel attribute;
  const EditAttributesDialog({
    Key? key,
    required this.attribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ValueNotifier<IList<int>> selectedCategories =
        useState(const IListConst([]));
    final nameController = useTextEditingController();
    final orderController = useTextEditingController();

    final List<AttributeTypeModel> attributeTypes =
        ref.watch(getAttributesProvider.select((value) => value.attributeType));
    final categoriesList =
        ref.watch(getAttributesProvider.select((value) => value.categories));
    final ValueNotifier<AttributeTypeModel> selectedAttributeType =
        useState(attributeTypes[0]);

    ref.listen<AtributesState>(atributesProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: const Text('Attribute Added'),
            animationType: AnimationType.fromTop,
          ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.info(
            title: const Text('Something went wrong'),
            animationType: AnimationType.fromTop,
          ).show(context);
          // next.failure.showDialogue(context);
        }
      }
    });

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        nameController.text = attribute.name;
        orderController.text = attribute.order.toString();
        // selectedAttributeType.value= AttributeTypeModel(id: attribute.attributeType.id.toString(), name: attribute.atributeType.type);
        // selectedCategories.value = attribute.categories.map((e) => e.id).toIList();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Attributes'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            KTextField(controller: nameController, lebelText: 'Name'),
            SizedBox(height: 10.h),
            SizedBox(
              height: 50.h,
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
                  value: selectedAttributeType.value,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: attributeTypes
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
                    selectedAttributeType.value = newValue!;
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),
            KTextField(controller: orderController, lebelText: 'Order'),
            SizedBox(height: 10.h),
            Expanded(
                child: SearchChoices<CategoriesModel>.multiple(
              items: List<DropdownMenuItem<CategoriesModel>>.from(
                  categoriesList.map<DropdownMenuItem<CategoriesModel>>(
                      (e) => DropdownMenuItem<CategoriesModel>(
                            value: e,
                            child: Text(
                              e.name,
                              textDirection: TextDirection.rtl,
                            ),
                          ))),
              selectedItems: selectedCategories.value.unlock,
              hint: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("Select Categories"),
              ),
              searchHint: "Select Categories",
              onChanged: (List<int> value) {
                selectedCategories.value = value.lock;
                Logger.i(selectedCategories.value);

                //  selectedCategories.value = value;
              },
              closeButton: (selectedItems) {
                return (selectedItems.isNotEmpty
                    ? "Save ${selectedItems.length == 1 ? '"${categoriesList[selectedItems.first].name}"' : '(${selectedItems.length})'}"
                    : "Save without selection");
              },
              isExpanded: true,
            )),
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
                    final selectedCategoryIds = selectedCategories.value
                        .map((element) => categoriesList[element])
                        .map((e) => e.id)
                        .toList();

                    final String endPoint = selectedCategoryIds
                        .map((id) => "categories_ids[]=$id")
                        .join('&');

                    Logger.i(endPoint);
                    ref.read(atributesProvider.notifier).updateAtributes(
                          attributeId: attribute.id,
                          name: nameController.text,
                          attributeTypeId: selectedAttributeType.value.id,
                          categoriesIds: endPoint,
                          order: orderController.text,
                        );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
