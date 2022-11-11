import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/my_account_page.dart';
import 'package:zcart_seller/presentation/notification/notification_page.dart';
import 'package:zcart_seller/presentation/widget_for_all/k_text_field.dart';

class ZipCodeRestriction extends HookConsumerWidget {
  const ZipCodeRestriction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final isSwitch = useState(true);
    final zipCodeController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        leading:
            //MenuButton
            IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu_rounded,
            size: 28.sp,
          ),
        ),
        actions: [
          //Notification Button
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationPage()));
            },
            icon: Icon(
              Icons.notifications,
              size: 28.sp,
            ),
          ),
        ],
        title: Text(
          'Zipcode Resctriction',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Do you want to restric the zipcodes that\n can place order',
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
                  activeColor: Constants.appbarColor,
                  padding: 8.0,
                  onToggle: (val) {
                    isSwitch.value = val;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              'Allowed Zipcodes',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            ),
            SizedBox(height: 30.h),
            KTextField(
              controller: zipCodeController,
              lebelText: 'Input Zipcode',
              suffixIcon: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.redo,
                  // color:  Constants.appbarColor,
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey.shade300,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          '    45963',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Icon(
                          Icons.delete,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey.shade300,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          '    45963',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyAccount(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Constants.appbarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: SizedBox(
                height: 45.h,
                child: Center(
                  child: Text(
                    'Update Zipcodes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
