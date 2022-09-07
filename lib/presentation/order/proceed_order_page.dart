import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/delivary_boys/delivary_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/domain/app/delivary%20boy/delivary_boy_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class ProceedOrderScreen extends HookConsumerWidget {
  final int orderId;

  const ProceedOrderScreen({
    required this.orderId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final List<DelivaryBoy> delivaryBoyList =
        ref.watch(delivaryProvider).delivaryBoys;
    final ValueNotifier<DelivaryBoy> selectedDelivaryBoy =
        useState(delivaryBoyList[0]);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      title: const Center(child: Text("Assign delivery boy")),
      content: SizedBox(
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
            value: selectedDelivaryBoy.value,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: delivaryBoyList
                .map<DropdownMenuItem<DelivaryBoy>>((DelivaryBoy value) {
              return DropdownMenuItem<DelivaryBoy>(
                value: value,
                child: Text(
                  value.name,
                  style: TextStyle(
                      color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
            onChanged: (DelivaryBoy? newValue) {
              selectedDelivaryBoy.value = newValue!;
            },
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Constants.buttonColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          onPressed: () {
            ref.read(orderProvider(null).notifier).assignDelivaryBoy(
                orderId, int.parse(selectedDelivaryBoy.value.id));
            Navigator.of(context).pop();
          },
          child: const Text("Proceed"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
          ),
        ),
      ],
    );
  }
}
