import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'widget_for_all/color.dart';
import 'widget_for_all/my_text_field.dart';

class AddCupon extends StatefulWidget {
  const AddCupon({Key? key}) : super(key: key);

  @override
  State<AddCupon> createState() => _AddCuponState();
}

class _AddCuponState extends State<AddCupon> {
  String dropdownValue = 'Limited Time Cupone';
  bool isSwitch = true;
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
        title: const Text('Add Cupon'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const MyTextField(
                  icone: Icons.text_format_rounded, hintText: "Cupon Code"),
              SizedBox(height: 15.h),
              //DropDown Botton
              SizedBox(
                height: 50.h,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Select Type',
                      labelStyle: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.w),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    style: TextStyle(color: Colors.grey.shade800),
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: ['Limited Time Cupone', '2', '3', '4', '5']
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
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Note: ',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'This will Have a limited activated Time period',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: const EdgeInsets.all(5),
                height: 60.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'From Date: 28 Jul 2022',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const InkWell(
                          child: Text(
                            'Change Date',
                            style: TextStyle(
                              color: MyColor.appbarColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To Date: 30 Jul 2022',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const InkWell(
                          child: Text(
                            'Change Date',
                            style: TextStyle(
                              color: MyColor.appbarColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              const MyTextField(
                  icone: Icons.border_horizontal_outlined,
                  hintText: 'Discount Persent'),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Do you want to set minimum cart amount \n to apply this cupone',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlutterSwitch(
                    width: 50.w,
                    height: 25.h,
                    valueFontSize: 25.sp,
                    toggleSize: 15.0,
                    value: isSwitch,
                    borderRadius: 30.r,
                    activeColor: MyColor.appbarColor,
                    padding: 8.0,
                    onToggle: (val) {
                      setState(() {
                        isSwitch = val;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              const MyTextField(
                icone: Icons.shopping_cart,
                hintText: 'Minimum cart amount',
              ),
              SizedBox(height: 20.h),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: MyColor.appbarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: SizedBox(
                  height: 35.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Add coupon',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
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
