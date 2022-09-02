import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_provider.dart';
import 'package:zcart_seller/application/app/form/attribute_list_provider.dart';
import 'package:zcart_seller/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';

class CreateNewCategoryPage extends HookConsumerWidget {
  final int categorySubgroupId;
  const CreateNewCategoryPage({Key? key, required this.categorySubgroupId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(attributeListProvider.notifier).loadData();
      });
      return null;
    }, []);
    final ValueNotifier<IList<KeyValueData>> selectedAttributes =
        useState(const IListConst([]));

    final nameController = useTextEditingController();
    final slugController = useTextEditingController();
    final descController = useTextEditingController();
    final metaController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final orderDescController = useTextEditingController();
    final active = useState(true);
    final attributes =
        ref.watch(attributeListProvider.select((value) => value.dataList));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
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
              KTextField(controller: slugController, lebelText: 'Slug'),
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
              if (attributes.isNotEmpty)
                MultipleKeyValueSelector(
                    title: "Select Attribute",
                    allData: attributes,
                    initialData: const IListConst([]),
                    onSelect: (list) {
                      Logger.i(list.length);
                      selectedAttributes.value = list;
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
                      final createCategory = CreateCategoryModel(
                          categorySubGroupId: categorySubgroupId,
                          name: nameController.text,
                          slug: slugController.text
                              .toLowerCase()
                              .replaceAll(RegExp(r' '), '-'),
                          description: descController.text,
                          metaTitle: metaDescController.text,
                          metaDescription: metaDescController.text,
                          attribute: selectedAttributes.value,
                          active: active.value ? 1 : 0,
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
