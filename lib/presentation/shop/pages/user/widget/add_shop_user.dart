import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_provider.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_state.dart';
import 'package:zcart_seller/application/auth/auth_provider.dart';
import 'package:zcart_seller/application/core/notification_helper.dart';
import 'package:zcart_seller/domain/app/shop/user/create_shop_user_model.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class AddShopUserPage extends HookConsumerWidget {
  const AddShopUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final List<String> genderList = ['Male', 'Female', 'Others'];
    final shopId =
        ref.watch(authProvider.select((value) => value.user.shop_id));
    final firstNameController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final nickNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final descController = useTextEditingController();
    final dobController = useTextEditingController();

    final ValueNotifier<String> selectedGender = useState('Male');

    final loading =
        ref.watch(shopUserProvider.select((value) => value.loading));

    ref.listen<ShopUserState>(shopUserProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          NotificationHelper.success(message: 'user_added'.tr());

          // CherryToast.info(
          //   title: const Text('User Added'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          NotificationHelper.error(message: 'something_went_wrong'.tr());
          // CherryToast.info(
          //   title: const Text('Something went wrong'),
          //   animationType: AnimationType.fromTop,
          // ).show(context);
          next.failure.showDialogue(context);
        }
      }
    });

    final active = useState(true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Add User'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              KTextField(controller: firstNameController, lebelText: 'Name'),
              SizedBox(height: 10.h),
              KTextField(
                  controller: nickNameController, lebelText: 'Nick Name'),
              SizedBox(height: 10.h),
              KTextField(controller: emailController, lebelText: 'Email'),
              SizedBox(height: 10.h),
              KTextField(
                controller: passwordController,
                lebelText: 'Password',
                hintText: 'Password must be 6 characters long',
              ),
              SizedBox(height: 10.h),
              KTextField(
                controller: confirmPasswordController,
                lebelText: 'Confirm Password',
              ),
              SizedBox(height: 10.h),
              KTextField(controller: descController, lebelText: 'Description'),
              SizedBox(height: 10.h),
              SwitchListTile(
                value: active.value,
                onChanged: (value) => active.value = value,
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
                  suffixIcon: const Icon(Icons.date_range),
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
                          confirmPasswordController.text.isNotEmpty &&
                          nickNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        final user = CreateShopUserModel(
                            shopId: shopId,
                            roleId: 4,
                            name: firstNameController.text,
                            niceName: nickNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            dob: dobController.text,
                            sex: selectedGender.value,
                            description: descController.text,
                            active: active.value ? 1 : 0);
                        ref
                            .read(shopUserProvider.notifier)
                            .createShopUser(createShopUser: user);
                      } else {
                        NotificationHelper.info(message: 'please_fill_all_fields'.tr());
                        // CherryToast.info(
                        //   title: const Text('Fillup all field'),
                        //   animationType: AnimationType.fromTop,
                        // ).show(context);
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
