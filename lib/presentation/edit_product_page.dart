import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:zcart_seller/presentation/widget_for_all/color.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String dropdownValue = 'Chocolate Biscute & Snacks';
  String dropdownValuesub = 'Chocolate';
  bool isSwitch = false;
  bool isActiveproduct = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.sm),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                //textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  labelText: 'Product name',
                  focusColor: Colors.grey.shade600,
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 50.h,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Select catagory',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: TextStyle(color: Colors.grey.shade800),
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: [
                        'Chocolate Biscute & Snacks',
                        '2pc',
                        '3pc',
                        '4pc',
                        '5pc'
                      ].map<DropdownMenuItem<String>>((String value) {
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
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 50.h,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Select a sub-catagory',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: TextStyle(color: Colors.grey.shade800),
                      isExpanded: true,
                      value: dropdownValuesub,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      items: ['Chocolate', '2pc', '3pc', '4pc', '5pc']
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
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '''SKU's''',
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: MyColor.appbarColor),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1, 1pcs',
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 13),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '    price:Rs.25',
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 13),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '    Quantity:99',
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 13),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color: Colors.green),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.create,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color: Colors.red),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2, 1pcs',
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 13),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '    price:Rs.95',
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 13),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '    Quantity:99',
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 13),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color: Colors.green),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.create,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color: Colors.red),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Text(
                'Keywords',
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15.h),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 1.5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.redo,
                          color: MyColor.appbarColor,
                        ),
                        border: InputBorder.none,
                        hintText: 'Input Zipcode',
                        hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                        alignLabelWithHint: true),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Container(
                      height: 40.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              '   Cadbury',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Icon(
                              Icons.delete,
                              color: Colors.black,
                              size: 20,
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                      height: 40.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              '  dairy milk',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Icon(
                              Icons.delete,
                              color: Colors.black,
                              size: 20,
                            )
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 90.h,
                width: double.infinity,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
                      when an unknown printer took a galley''',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Product Images',
                style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 80,
                    child: Image.asset('assets/images/c1.png'),
                  ),
                  Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        color: Colors.red),
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: SizedBox(
                    height: 45,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo),
                          SizedBox(width: 5.w),
                          const Text(
                            'Add Image',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(height: 15.h),
              Text(
                'Do you want to discount this product?',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Is discount?',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  FlutterSwitch(
                    width: 60.0.w,
                    height: 28.0.h,
                    valueFontSize: 25.0.sp,
                    toggleSize: 15.0,
                    value: isSwitch,
                    borderRadius: 30.0,
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
              SizedBox(height: 15.h),
              Text(
                'Additional information(optional)',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.h),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  labelText: 'Boost Before',
                  focusColor: Colors.grey.shade600,
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  labelText: 'Brand',
                  focusColor: Colors.grey.shade600,
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  hintText: 'Manufacture Date',
                  focusColor: Colors.grey.shade600,
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  labelText: 'Shelf life',
                  focusColor: Colors.grey.shade600,
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Product',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  FlutterSwitch(
                    width: 60.0.w,
                    height: 28.0.h,
                    valueFontSize: 25.0.sp,
                    toggleSize: 15.0,
                    value: isActiveproduct,
                    borderRadius: 30.0,
                    activeColor: MyColor.appbarColor,
                    padding: 8.0,
                    onToggle: (val) {
                      setState(() {
                        isActiveproduct = val;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: MyColor.appbarColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: SizedBox(
                    height: 45,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.restore),
                          SizedBox(width: 5.w),
                          const Text(
                            'Update product',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )),
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5.w),
                      const Text(
                        'Delete Product',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
