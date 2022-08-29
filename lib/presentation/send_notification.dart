import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_vendor/presentation/widget_for_all/color.dart';

import 'order/manage_order_page.dart';
import 'widget_for_all/my_text_field.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({Key? key}) : super(key: key);

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  String dropdownValue = 'Select Type';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Send Notification'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: Icon(
                    Icons.image,
                    size: 45,
                    color: Colors.grey.shade800,
                  ),
                ),
                Container(
                  height: 200.h,
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: MyColor.appbarColor),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManageOrderPage(
                              id: 2,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            const MyTextField(
                icone: Icons.text_fields_rounded, hintText: 'Title'),
            SizedBox(height: 15.h),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.h),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.w,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  style: TextStyle(color: Colors.grey.shade800),
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: ['Select Type', '2pc', '3pc', '4pc', '5pc']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        dropdownValue = newValue!;
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15.h),
            const MyTextField(icone: Icons.email, hintText: 'Description'),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: MyColor.appbarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: SizedBox(
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send_outlined),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Send Notification',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
