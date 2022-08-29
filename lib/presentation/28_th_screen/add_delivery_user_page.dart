import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';
import 'package:zcart_vendor/presentation/widget_for_all/k_text_field.dart';

class AddDeliveryUserPage extends HookConsumerWidget {
  const AddDeliveryUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isSwitch = useState(false);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        leading: const Icon(Icons.arrow_back),
        title: const Text('Add Delivery User'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                        height: 80.r,
                        width: 80.r,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 35.r,
                        )),
                    Positioned(
                      left: -3.w,
                      bottom: 0.h,
                      child: Container(
                        height: 23.h,
                        width: 23.h,
                        decoration: const BoxDecoration(
                            color: MyColor.appbarColor, shape: BoxShape.circle),
                        child: Icon(
                          Icons.add,
                          size: 14.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              KTextField(
                controller: nameController,
                lebelText: 'Name',
                prefixIcon: const Icon(Icons.person),
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: phoneController,
                lebelText: 'Mobile no.',
                prefixIcon: const Icon(Icons.phone),
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: emailController,
                lebelText: 'Email',
                prefixIcon: const Icon(Icons.email),
              ),
              SizedBox(
                height: 10.h,
              ),
              KTextField(
                controller: passwordController,
                lebelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Activate User',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp),
                  ),
                  FlutterSwitch(
                    width: 60.0.w,
                    height: 30.0.h,
                    valueFontSize: 25.0.sp,
                    toggleSize: 15.0,
                    value: isSwitch.value,
                    borderRadius: 20.0,
                    activeColor: MyColor.appbarColor,
                    padding: 8.0,
                    onToggle: (val) {
                      isSwitch.value = val;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const MyAccount(),
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  primary: MyColor.appbarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: SizedBox(
                  height: 45.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_add),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Add Delivery User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
