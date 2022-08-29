import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/catalog/attribute%20values/attribute_values_provider.dart';
import 'package:zcart_vendor/application/app/catalog/attribute%20values/attribute_values_state.dart';
import 'package:zcart_vendor/domain/app/catalog/attribute%20values/attribute_values_model.dart';
import 'package:zcart_vendor/presentation/widget_for_all/k_text_field.dart';

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
    ref.listen<AttributeValuesState>(attributeValuesProvider(attributeId),
        (previous, next) {
      if (previous != next && !next.loading) {
        if (next.failure == CleanFailure.none() && buttonPressed.value) {
          Navigator.of(context).pop();
          CherryToast.info(
            title: const Text('Attribute value added'),
            animationType: AnimationType.fromTop,
          ).show(context);

          buttonPressed.value = false;
        } else if (next.failure != CleanFailure.none()) {
          Navigator.of(context).pop();
          next.failure.showDialogue(context);
        }
      }
    });
    return AlertDialog(
      title: attributeValues != null
          ? const Text('Update Attribute Values')
          : const Text('Add Attribute Values'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KTextField(controller: valueController, lebelText: 'Value'),
          // SizedBox(height: 10.h),
          // KTextField(
          //     controller: attributeIdController, lebelText: 'Attribute id'),
          SizedBox(height: 10.h),
          KTextField(controller: colorController, lebelText: 'Color'),
          SizedBox(height: 10.h),
          KTextField(controller: orderController, lebelText: 'Order'),
        ],
      ),
      actions: [
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
            if (attributeValues == null) {
              if (valueController.text.isNotEmpty &&
                  colorController.text.isNotEmpty &&
                  orderController.text.isNotEmpty) {
                buttonPressed.value = true;
                ref
                    .read(attributeValuesProvider(attributeId).notifier)
                    .createAttributeValue(valueController.text, attributeId,
                        colorController.text, int.parse(orderController.text));
              } else {
                CherryToast.info(
                  title: const Text('Please fill all fields'),
                  animationType: AnimationType.fromTop,
                ).show(context);
              }
            } else {
              if (valueController.text.isNotEmpty &&
                  colorController.text.isNotEmpty &&
                  orderController.text.isNotEmpty) {
                buttonPressed.value = true;
                ref
                    .read(attributeValuesProvider(attributeId).notifier)
                    .updateAttributeValue(
                        attributeId: attributeId,
                        attributeValueId: attributeValues!.id,
                        color: colorController.text,
                        order: int.parse(orderController.text),
                        value: valueController.text);
              } else {
                CherryToast.info(
                  title: const Text('Please fill all fields'),
                  animationType: AnimationType.fromTop,
                ).show(context);
              }
            }
          },
          child: attributeValues != null
              ? const Text('Update')
              : const Text('Add'),
        ),
      ],
    );
  }
}
