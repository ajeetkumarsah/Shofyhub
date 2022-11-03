  

import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/delivary%20boy/delivary_boy_provider.dart';
import 'package:zcart_seller/application/app/shop/delivary%20boy/delivary_boy_state.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/create_delivary_boy_model.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class AddUpdateDelivaryBoyPage extends HookConsumerWidget {
  final DelivaryBoyModel? delivaryBoyDetails;
  const AddUpdateDelivaryBoyPage({Key? key, this.delivaryBoyDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final List<String> genderList = ['Male', 'Female', 'Others'];
    final shopId =
        ref.watch(authProvider.select((value) => value.user.shop_id));

    final loading =
        ref.watch(delivaryBoyProvider.select((value) => value.loading));

    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final nickNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final phoneNoController = useTextEditingController();
    final dobController = useTextEditingController();

    final ValueNotifier<String> selectedGender = useState('Male');
    // final deliveryBoyDob = DateTime.tryParse(delivaryBoyDetails!.dob);

    if (delivaryBoyDetails != null) {
      firstNameController.text = delivaryBoyDetails!.firstName;
      lastNameController.text = delivaryBoyDetails!.lastName;
      nickNameController.text = delivaryBoyDetails!.niceName;
      emailController.text = delivaryBoyDetails!.email;

      phoneNoController.text = delivaryBoyDetails!.phoneNumber;
      dobController.text = delivaryBoyDetails!.dob;
    }
    ref.listen<DelivaryBoyState>(delivaryBoyProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(
              message:
                  delivaryBoyDetails != null ? 'item_updated' : 'item_added');

          // CherryToast.info(
          //   title: delivaryBoyDetails != null
          //       ? const Text('Delivary Boy Updated')
          //       : const Text('Delivary Boy Added'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: 'something_went_wrong'.tr());
          // CherryToast.info(
          //   title: const Text('Something went wrong'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
          // next.failure.showDialogue(context);
        }
      }
    });

    final status = useState(true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: delivaryBoyDetails != null
            ? const Text('Update Delivary Boy')
            : const Text('Add Delivary Boy'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              KTextField(
                  controller: firstNameController, lebelText: 'First Name'),
              SizedBox(height: 10.h),
              KTextField(
                  controller: lastNameController, lebelText: 'Last Name'),
              SizedBox(height: 10.h),
              KTextField(
                  controller: nickNameController, lebelText: 'Nick Name'),
              SizedBox(height: 10.h),
              KTextField(controller: emailController, lebelText: 'Email'),
              if (delivaryBoyDetails == null) SizedBox(height: 10.h),
              if (delivaryBoyDetails == null)
                KTextField(
                    controller: passwordController, lebelText: 'Password'),
              if (delivaryBoyDetails == null) SizedBox(height: 10.h),
              if (delivaryBoyDetails == null)
                KTextField(
                    controller: confirmPasswordController,
                    lebelText: 'Confirm Password'),
              SizedBox(height: 10.h),
              KTextField(
                  controller: phoneNoController, lebelText: 'Phone Number'),
              SizedBox(height: 10.h),
              SwitchListTile(
                value: status.value,
                onChanged: (value) => status.value = value,
                title: const Text('Active status'),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: dobController,
                style: const TextStyle(fontWeight: FontWeight.bold),
                readOnly: true,
                decoration: InputDecoration(
                  // prefixIcon: prefixIcon,
                  labelText: 'Date Of Birth',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),

                  // suffixIcon: suffixIcon,
                ),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1910),
                    lastDate: DateTime.now(),
                    currentDate: DateTime.now(),
                    helpText: 'Select a date',
                  ).then((value) {
                    dobController.text =
                        DateFormat('yyyy-MM-dd hh:mm a').format(value!);
                  });
                },
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
                    value: selectedGender.value,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: genderList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedGender.value = newValue!;
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      Logger.i(dobController.text);
                      if (firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          nickNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          phoneNoController.text.isNotEmpty) {
                        final delivaryBoy = CreateDelivaryBoyModel(
                          shopId: shopId,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          niceName: nickNameController.text,
                          phoneNumber: phoneNoController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                          sex: selectedGender.value,
                          dob: dobController.text,
                          status: status.value ? 1 : 0,
                        );
                        if (delivaryBoyDetails != null) {
                          ref
                              .read(delivaryBoyProvider.notifier)
                              .updateDelivaryBoy(
                                  delivaryBoy: delivaryBoy,
                                  delivaryBoyId: delivaryBoyDetails!.id);
                        } else {
                          ref
                              .read(delivaryBoyProvider.notifier)
                              .createDelivaryBoy(delivaryBoy: delivaryBoy);
                        }
                      } else {
                        NotificationHelper.info(
                            message: 'please_fill_all_fields'.tr());
                      }
                    },
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text('Add'),
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
