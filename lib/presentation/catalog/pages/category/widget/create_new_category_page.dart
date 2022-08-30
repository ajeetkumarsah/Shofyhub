import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_provider.dart';
import 'package:zcart_seller/application/app/category/categories/category_attribute_provider.dart';
import 'package:zcart_seller/domain/app/category/categories/attributes_model.dart';
import 'package:zcart_seller/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/color.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:search_choices/search_choices.dart';

class CreateNewCategoryPage extends HookConsumerWidget {
  final int categorySubgroupId;
  const CreateNewCategoryPage({Key? key, required this.categorySubgroupId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ValueNotifier<IList<int>> selectedCategories =
        useState(const IListConst([]));
    final nameController = useTextEditingController();
    final descController = useTextEditingController();
    final metaController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final orderDescController = useTextEditingController();
    final active = useState(true);
    final attributeList = ref.watch(
        categoryAttributeProvider.select((value) => value.attributeList));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Add category'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 10.h),
              KTextField(controller: nameController, lebelText: 'Name'),
              SizedBox(height: 10.h),
              SizedBox(height: 10.h),
              KTextField(controller: descController, lebelText: 'description'),
              SizedBox(height: 10.h),
              KTextField(controller: metaController, lebelText: 'meta_title'),
              SizedBox(height: 10.h),
              KTextField(
                  controller: metaDescController,
                  lebelText: 'meta_description'),
              SizedBox(height: 10.h),
              KTextField(controller: orderDescController, lebelText: 'Order'),
              SizedBox(height: 10.h),
              CheckboxListTile(
                  title: const Text('Active'),
                  value: active.value,
                  onChanged: (value) {
                    active.value = value!;
                  }),
              SizedBox(height: 10.h),
              SearchChoices<CategoryAttribuitesModel>.multiple(
                items: List<DropdownMenuItem<CategoryAttribuitesModel>>.from(
                    attributeList
                        .map<DropdownMenuItem<CategoryAttribuitesModel>>(
                            (e) => DropdownMenuItem<CategoryAttribuitesModel>(
                                  value: e,
                                  child: Text(
                                    e.name,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ))),
                selectedItems: selectedCategories.value.unlock,
                hint: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Select any"),
                ),
                searchHint: "Select any",
                onChanged: (List<int> value) {
                  selectedCategories.value = value.lock;
                  Logger.i(selectedCategories.value);

                  //  selectedCategories.value = value;
                },
                closeButton: (selectedItems) {
                  return (selectedItems.isNotEmpty
                      ? "Save ${selectedItems.length == 1 ? '"${attributeList[selectedItems.first].name}"' : '(${selectedItems.length})'}"
                      : "Save without selection");
                },
                isExpanded: true,
              ),
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
                          .map((element) => attributeList[element])
                          .map((e) => e.id)
                          .toList();

                      final categorys = selectedCategoryIds
                          .map((id) => "attribute_ids[]=$id")
                          .join('&');
                      Logger.i(categorys);

                      final createCategory = CreateCategoryModel(
                          categorySubGroupId: categorySubgroupId,
                          name: nameController.text,
                          slug: nameController.text
                              .toLowerCase()
                              .replaceAll(RegExp(r' '), '-'),
                          description: descController.text,
                          metaTitle: metaDescController.text,
                          metaDescription: metaDescController.text,
                          attributeIds: categorys,
                          active: active.value,
                          order: orderDescController.text);
                      ref
                          .read(categoryProvider(categorySubgroupId).notifier)
                          .createNewCategory(createCategory);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
