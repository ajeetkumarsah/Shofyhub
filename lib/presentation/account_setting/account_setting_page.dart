// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/account_setting/change_pass_popup.dart';
import 'package:alpesportif_seller/presentation/auth/sign_in_page.dart';
import 'package:alpesportif_seller/presentation/delivery_orders_page/delivery_orders_page.dart';
import 'package:alpesportif_seller/presentation/previously_completed_orders_page/previously_completed_orders_page.dart';

class AcountSettingsPage extends StatelessWidget {
  const AcountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Account Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1447005497901-b3e9ee359928?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 70.h),
                        height: 30.h,
                        width: 30.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF683CB7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              const AccountEditTextField(
                prefixText: 'Full name',
                prefixIcon: Icon(Icons.man_rounded),
              ),
              SizedBox(height: 10.h),
              const AccountEditTextField(
                prefixText: 'Mobile no',
                prefixIcon: Icon(Icons.call),
              ),
              SizedBox(height: 10.h),
              const AccountEditTextField(
                prefixText: 'Email address',
                prefixIcon: Icon(Icons.call),
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.zero,
                          content: const ChangePass(),
                        );
                      });
                },
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEA2264),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.key, size: 20.sp, color: Colors.white),
                      SizedBox(width: 10.w),
                      Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF683CB7),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Update Account Detail',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFFFFFF),
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveryOrdersPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const PreviouslyCompletedOrdersPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.timer_rounded),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AcountSettingsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_box),
              ),
              label: ''),
        ],
        currentIndex: 2,
      ),
    );
  }
}

class AccountEditTextField extends StatelessWidget {
  const AccountEditTextField({
    Key? key,
    required this.prefixText,
    required this.prefixIcon,
  }) : super(key: key);
  final String prefixText;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: TextField(
        decoration: InputDecoration(
          label: Text(
            prefixText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
