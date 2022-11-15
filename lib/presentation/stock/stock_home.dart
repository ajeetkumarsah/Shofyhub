import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/inventory/inventory_page.dart';
import 'package:zcart_seller/presentation/stock/suppliers/supplier_page.dart';
import 'package:zcart_seller/presentation/stock/warehouse/warehouse_page.dart';

class StockHome extends StatelessWidget {
  const StockHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: index,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Constants.appbarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22.r),
            ),
          ),
          title: Text('stock'.tr()),
          elevation: 0,
          bottom: TabBar(
            indicatorWeight: 4,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white10),
            tabs: const [
              Tab(
                text: 'Inventory',
              ),
              // Tab(
              //   text: 'Trash\nInventory',
              // ),
              Tab(
                text: 'Suppliers',
              ),
              Tab(
                text: 'Warehouse',
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          InventoryPage(),
          SupplierPage(),
          WarehousePage(),
        ]),
      ),
    );
  }
}
