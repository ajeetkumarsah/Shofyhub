import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/atributes/atributes_provider.dart';
import 'package:zcart_seller/application/app/catalog/atributes/atributes_state.dart';
import 'package:zcart_seller/application/app/catalog/atributes/get_atributes_provider.dart';
import 'package:zcart_seller/application/app/form/category_list_provider.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/attribute_type_model.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';

class EditAttributesDialog extends HookConsumerWidget {
  final AtributesModel attribute;
  const EditAttributesDialog({
    Key? key,
    required this.attribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    final orderController = useTextEditingController();

    final List<AttributeTypeModel> attributeTypes =
        ref.watch(getAttributesProvider.select((value) => value.attributeType));

    final allCategories =
        ref.watch(categoryListProvider.select((value) => value.dataList));
    final ValueNotifier<IList<KeyValueData>> selectedCategories =
        useState(const IListConst([]));
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
        ref.read(categoryListProvider.notifier).loadData();
        nameController.text = attribute.name;
        orderController.text = attribute.order.toString();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Edit Attributes'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
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
              MultipleKeyValueSelector(
                  title: "Select Categories",
                  allData: allCategories,
                  onSelect: (list) {
                    selectedCategories.value = list;
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
                      final String endPoint = selectedCategories.value
                          .map((category) => "categories_ids[]=${category.key}")
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
      ),
    );
  }
}
