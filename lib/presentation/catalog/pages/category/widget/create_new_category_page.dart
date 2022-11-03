 
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/categories/categories_provider.dart';
import 'package:zcart_seller/application/app/category/categories/categories_state.dart';
import 'package:zcart_seller/application/app/form/attribute_list_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/category/categories/create_category_model.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

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

    final descController = useTextEditingController();
    final metaController = useTextEditingController();
    final metaDescController = useTextEditingController();
    final orderDescController = useTextEditingController();
    final active = useState(true);
    final attributes =
        ref.watch(attributeListProvider.select((value) => value.dataList));
    final buttonPressed = useState(false);
    ref.listen<CategoryState>(categoryProvider(categorySubgroupId),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'category_added'.tr());
          // CherryToast.info(
          //   title: Text('category_added'.tr()),
          //   animationType: AnimationType.fromTop,
          // ).show(context);

          buttonPressed.value = false;
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
    final loading = ref.watch(
        categoryProvider(categorySubgroupId).select((value) => value.loading));
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
        title: Text('add_category'.tr()),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 10.h),
                Text('* Required fields.',
                    style: TextStyle(color: Theme.of(context).hintColor)),
                SizedBox(height: 10.h),
                KTextField(
                  controller: nameController,
                  lebelText: 'Name *',
                  validator: (text) => ValidatorLogic.requiredField(text,
                      fieldName: 'name'.tr()),
                ),
                SizedBox(height: 10.h),
                KTextField(
                    controller: descController, lebelText: 'description'.tr()),
                SizedBox(height: 10.h),
                KTextField(
                    controller: metaController, lebelText: 'meta_title'.tr()),
                SizedBox(height: 10.h),
                KTextField(
                    controller: metaDescController,
                    lebelText: 'meta_description'.tr()),
                SizedBox(height: 10.h),
                KTextField(
                  controller: orderDescController,
                  lebelText: 'order'.tr(),
                  numberFormatters: true,
                ),
                SizedBox(height: 10.h),
                CheckboxListTile(
                    title: Text('active'.tr()),
                    value: active.value,
                    onChanged: (value) {
                      active.value = value!;
                    }),
                SizedBox(height: 10.h),
                if (attributes.isNotEmpty)
                  MultipleKeyValueSelector(
                      title: "select_attribute".tr(),
                      allData: attributes,
                      initialData: const IListConst([]),
                      onSelect: (list) {
                        Logger.i(list.length);
                        selectedAttributes.value = list;
                      }),
                SizedBox(height: 10.h),
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
                        buttonPressed.value = true;
                        if (formKey.currentState?.validate() ?? false) {
                          final createCategory = CreateCategoryModel(
                              categorySubGroupId: categorySubgroupId,
                              name: nameController.text,
                              slug: nameController.text
                                  .toLowerCase()
                                  .replaceAll(RegExp(r' '), '-'),
                              description: descController.text,
                              metaTitle: metaDescController.text,
                              metaDescription: metaDescController.text,
                              attribute: selectedAttributes.value,
                              active: active.value ? 1 : 0,
                              order: orderDescController.text.isNotEmpty
                                  ? orderDescController.text
                                  : 0.toString());
                          ref
                              .read(
                                  categoryProvider(categorySubgroupId).notifier)
                              .createNewCategory(createCategory);
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
