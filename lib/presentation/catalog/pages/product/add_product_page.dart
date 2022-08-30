import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class AddProductPage extends HookConsumerWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    // final mpnController = useTextEditingController();
    final active = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            KTextField(controller: nameController, lebelText: 'Name'),
            SizedBox(height: 10.h),
            SwitchListTile(
              value: active.value,
              onChanged: (value) => active.value = value,
              title: const Text('Active status'),
            ),
            KTextField(
                controller: nameController,
                lebelText: 'Manufacturer part Number'),
            KTextField(
                controller: nameController,
                lebelText: 'Global Trade Item Number'),

            // SizedBox(
            //   height: 50.h,
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButtonFormField(
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderSide: BorderSide(width: 1.w),
            //           borderRadius: BorderRadius.circular(10.r),
            //         ),
            //       ),
            //       style: TextStyle(color: Colors.grey.shade800),
            //       isExpanded: true,
            //       value: selectedCarrier.value,
            //       icon: const Icon(Icons.keyboard_arrow_down_rounded),
            //       items: carriers.map<DropdownMenuItem<AttributeTypeModel>>(
            //           (AttributeTypeModel value) {
            //         return DropdownMenuItem<AttributeTypeModel>(
            //           value: value,
            //           child: Text(
            //             value.name,
            //             style: TextStyle(
            //                 color: Colors.grey.shade700,
            //                 fontWeight: FontWeight.w500),
            //           ),
            //         );
            //       }).toList(),
            //       onChanged: (AttributeTypeModel? newValue) {
            //         selectedCarrier.value = newValue!;
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(height: 10.h),
            // KTextField(controller: orderController, lebelText: 'Order'),
            SizedBox(height: 10.h),
            // Expanded(
            //     child: SearchChoices<CategoriesModel>.multiple(
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
            //     child: Text("Select any"),
            //   ),
            //   searchHint: "Select any",
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
            // )),
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
                    // final selectedCategoryIds = selectedCategories.value
                    //     .map((element) => categoriesList[element])
                    //     .map((e) => e.id)
                    //     .toList();

                    // Logger.i(selectedCategoryIds);
                    // ref.read(getAttributesProvider.notifier).createAtributes(
                    //       attributeId: attributeId,
                    //       name: nameController.text,
                    //       attributeTypeId: attributeTypeId,
                    //       categoriesIds: selectedCategoryIds,
                    //       order: order,
                    //     );
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
