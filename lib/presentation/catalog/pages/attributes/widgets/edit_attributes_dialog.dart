import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/atributes/atributes_provider.dart';
import 'package:zcart_seller/application/app/catalog/atributes/atributes_state.dart';
import 'package:zcart_seller/application/app/catalog/atributes/get_atributes_provider.dart';
import 'package:zcart_seller/application/app/form/category_list_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/atributes_model.dart';
import 'package:zcart_seller/domain/app/catalog/atributes/attribute_type_model.dart';
import 'package:zcart_seller/domain/app/form/key_value_data.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/required_field_text.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/select_multiple_key_value.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class EditAttributesDialog extends HookConsumerWidget {
  final AtributesModel attribute;
  const EditAttributesDialog({
    Key? key,
    required this.attribute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(getAttributesProvider.notifier)
            .getAlAtributes(attributeId: attribute.id);
      });
      return null;
    }, []);
    final attributeDetails =
        ref.watch(getAttributesProvider.select((value) => value.atributeId));
    final nameController = useTextEditingController();
    final orderController = useTextEditingController();

    final List<AttributeTypeModel> attributeTypes =
        ref.watch(getAttributesProvider.select((value) => value.attributeType));

    final loading =
        ref.watch(getAttributesProvider.select((value) => value.loading));

    final loadingUpdate =
        ref.watch(atributesProvider.select((value) => value.loading));

    final allCategories =
        ref.watch(categoryListProvider.select((value) => value.dataList));
    final ValueNotifier<IList<KeyValueData>> selectedCategories =
        useState(const IListConst([]));
    final ValueNotifier<AttributeTypeModel> selectedAttributeType =
        useState(attributeTypes[0]);

    final buttonPressed = useState(false);

    ref.listen<AtributesState>(atributesProvider, (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          NotificationHelper.success(message: 'attribute_updated'.tr());
          Navigator.of(context).pop();
          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: next.failure.error);
        }
      }
    });

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(categoryListProvider.notifier).loadData();
        nameController.text = attribute.name;
        orderController.text = attribute.order.toString();
        selectedAttributeType.value = attributeTypes
            .where((element) => element.name == attribute.attributeType)
            .toList()[0];

        // selectedCategories.value.addAll(allCategories.where((e) =>
        //     e.key ==
        //     attributeDetails.categories
        //         .map((value) => value.id.toString())
        //         .toList()));
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
        title: Text('edit_attributes'.tr()),
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    KTextField(
                      controller: orderController,
                      lebelText: 'order'.tr(),
                      numberFormatters: true,
                    ),
                    SizedBox(height: 10.h),
                    if (allCategories.isNotEmpty)
                      MultipleKeyValueSelector(
                          title: "select_categories".tr(),
                          initialData: attributeDetails.categories
                              .map((e) => e.toKeyValue())
                              .toIList(),
                          allData: allCategories,
                          onSelect: (list) {
                            selectedCategories.value = list;
                          }),
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
                          onPressed: loadingUpdate
                              ? null
                              : () {
                                  buttonPressed.value = true;

                                  final String endPoint = selectedCategories
                                      .value
                                      .map((category) =>
                                          "categories_ids[]=${category.key}")
                                      .join('&');

                                  Logger.i(endPoint);
                                  ref
                                      .read(atributesProvider.notifier)
                                      .updateAtributes(
                                        attributeId: attribute.id,
                                        name: nameController.text.isEmpty
                                            ? attribute.name
                                            : nameController.text,
                                        attributeTypeId:
                                            selectedAttributeType.value.id,
                                        categoriesIds: endPoint,
                                        order: orderController.text.isEmpty
                                            ? attribute.order.toString()
                                            : orderController.text,
                                      );
                                },
                          child: loadingUpdate
                              ? const CircularProgressIndicator()
                              : Text('save'.tr()),
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
