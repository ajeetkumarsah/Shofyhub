import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/all_products/widget/product_container.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('All Products'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Icon(
                  Icons.search,
                  color: Colors.grey.shade800,
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    ProductContainer(
                        title: 'Cadbury Dark Milk',
                        price: 'Rs.25.00',
                        image: 'assets/images/c1.png'),
                    SizedBox(height: 15),
                    ProductContainer(
                        title: 'Pampers',
                        price: 'Rs.153.00',
                        image: 'assets/images/p1.png'),
                    SizedBox(height: 15),
                    ProductContainer(
                        title: 'Nivea Men facewash',
                        price: 'Rs.50.00',
                        image: 'assets/images/f1.png'),
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
