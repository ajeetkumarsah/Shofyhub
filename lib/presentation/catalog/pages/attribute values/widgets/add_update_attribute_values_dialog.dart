import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/attribute%20values/attribute_values_provider.dart';
import 'package:zcart_seller/application/app/catalog/attribute%20values/attribute_values_state.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/catalog/attribute%20values/attribute_values_model.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';
import 'package:zcart_seller/presentation/widget_for_all/validator_logic.dart';

class AddUpdateAttributeValuesDialog extends HookConsumerWidget {
  final int attributeId;
  final AttributeValuesModel? attributeValues;
  const AddUpdateAttributeValuesDialog(
      {Key? key, required this.attributeId, this.attributeValues})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final valueController = useTextEditingController();
    final colorController = useTextEditingController();
    final orderController = useTextEditingController();
    final buttonPressed = useState(false);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (attributeValues != null) {
          valueController.text = attributeValues!.value;
          colorController.text = attributeValues!.color;
          orderController.text = attributeValues!.order.toString();
        }
      });
      return null;
    }, []);

    final loading = ref.watch(
        attributeValuesProvider(attributeId).select((value) => value.loading));

    ref.listen<AttributeValuesState>(attributeValuesProvider(attributeId),
        (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          Navigator.of(context).pop();
          NotificationHelper.success(
            message: attributeValues != null
                ? 'attribute_value_updated'.tr()
                : 'attribute_value_added'.tr(),
          );
          // CherryToast.info(
          //   title: attributeValues != null
          //       ? Text('attribute_value_updated'.tr())
          //       : Text('attribute_value_added'.tr()),
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
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return AlertDialog(
      title: attributeValues != null
          ? Text('update_attribute_value'.tr())
          : Text('add_attribute_value'.tr()),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('* Required fields.',
                style: TextStyle(color: Theme.of(context).hintColor)),
            SizedBox(height: 10.h),
            KTextField(
              controller: valueController,
              lebelText: 'Value *',
              validator: (text) =>
                  ValidatorLogic.requiredField(text, fieldName: 'Value'),
            ),
            // SizedBox(height: 10.h),
            // KTextField(
            //     controller: attributeIdController, lebelText: 'Attribute id'),
            SizedBox(height: 10.h),
            KTextField(controller: colorController, lebelText: 'Color'),
            SizedBox(height: 10.h),
            KTextField(
              controller: orderController,
              lebelText: 'Order',
              numberFormatters: true,
            ),
          ],
        ),
      ),
      actions: [
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
            if (attributeValues == null) {
              if (formKey.currentState?.validate() ?? false) {
                buttonPressed.value = true;
                ref
                    .read(attributeValuesProvider(attributeId).notifier)
                    .createAttributeValue(
                        valueController.text,
                        attributeId,
                        colorController.text,
                        orderController.text.isEmpty
                            ? 0
                            : int.parse(orderController.text));
              }
            } else {
              buttonPressed.value = true;
              ref
                  .read(attributeValuesProvider(attributeId).notifier)
                  .updateAttributeValue(
                      attributeId: attributeId,
                      attributeValueId: attributeValues!.id,
                      color: colorController.text.isEmpty
                          ? attributeValues!.color
                          : colorController.text,
                      order: orderController.text.isEmpty
                          ? 0
                          : int.parse(orderController.text),
                      value: valueController.text.isEmpty
                          ? attributeValues!.value
                          : valueController.text);
            }
          },
          child: attributeValues != null
              ? loading
                  ? const CircularProgressIndicator()
                  : Text('update'.tr())
              : loading
                  ? const CircularProgressIndicator()
                  : Text('add'.tr()),
        ),
      ],
    );
  }
}
