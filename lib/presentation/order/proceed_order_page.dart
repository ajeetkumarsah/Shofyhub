import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/delivary%20boys/delivary_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/domain/app/delivary%20boy/delivary_boy_model.dart';

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
    final isSwitch = useState(true);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      title: const Center(child: Text("Proceed Order")),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Do you want to assign a\ndelivery guy?",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    width: 23.w,
                  ),
                  isSwitch.value
                      ? InkWell(
                          onTap: () => isSwitch.value = !isSwitch.value,
                          child: const Icon(Icons.check_box_rounded))
                      : InkWell(
                          onTap: () => isSwitch.value = !isSwitch.value,
                          child: const Icon(Icons.check_box_outline_blank))
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Assign a delivery guy:",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              //DropDown
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
                    value: selectedDelivaryBoy.value,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: delivaryBoyList.map<DropdownMenuItem<DelivaryBoy>>(
                        (DelivaryBoy value) {
                      return DropdownMenuItem<DelivaryBoy>(
                        value: value,
                        child: Text(
                          value.name,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    onChanged: (DelivaryBoy? newValue) {
                      selectedDelivaryBoy.value = newValue!;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "OTP: 618514",
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Note: Delivery guy will verify the OTP from customer while delivering the order.",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              SizedBox(
                height: 35.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff683CB7),
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
              ),
              SizedBox(
                height: 5.h,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
