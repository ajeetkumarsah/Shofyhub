import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
import 'package:zcart_seller/presentation/catalog/catalogue_screen.dart';
import 'package:zcart_seller/presentation/inventory/inventory_page.dart';
import 'package:zcart_seller/presentation/new_dashboard/widgets/more_option_item.dart';
import 'package:zcart_seller/presentation/new_dashboard/widgets/store_report_item.dart';
import 'package:zcart_seller/presentation/order/order_main_page.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderProvider(null).notifier).getOrders();
        ref.read(orderProvider(OrderFilter.unfullfill).notifier).getOrders();
        ref.read(orderProvider(OrderFilter.archived).notifier).getOrders();
        ref
            .read(inventoryProvider.notifier)
            .getAllInventories(inventoryFilter: 'active');
        ref.read(categoryGroupProvider.notifier).getAllCategoryGroup();
      });
      return null;
    }, []);
    final totalUnfullfilledOrder = ref.watch(
        orderProvider(OrderFilter.unfullfill)
            .select((value) => value.orderList.length));
    final totalArchivedOrder = ref.watch(orderProvider(OrderFilter.archived)
        .select((value) => value.orderList.length));
    final totalOrders = ref
        .watch(orderProvider(null).select((value) => value.orderList.length));
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 60.h,
        backgroundColor: const Color(0xff683CB7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            "Dashboard",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const OrderMainPage(
                                  index: 0,
                                )));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        height: 75.h,
                        // width: 150.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3C72B7),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: const [
                                ImageIcon(
                                  AssetImage("assets/images/noteboard.png"),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Total Order',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '$totalOrders',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      height: 75.h,
                      // width: 150.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A5080),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: const [
                              ImageIcon(
                                AssetImage("assets/images/percent.png"),
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Total sale',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '\$1200',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Store Reports',
                style: TextStyle(
                  color: const Color(0xFF484848),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                height: 220.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const OrderMainPage(
                                  index: 1,
                                )));
                      },
                      child: StoreReportItems(
                        itemIcon: 'assets/images/stock.png',
                        itemValues: totalUnfullfilledOrder.toString(),
                        itemName: 'UNFULFILLED ORDERS',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const OrderMainPage(
                                  index: 2,
                                )));
                      },
                      child: StoreReportItems(
                        itemIcon: 'assets/images/order.png',
                        itemValues: '$totalArchivedOrder',
                        itemName: 'ARCHIVED ORDERS',
                      ),
                    ),
                    const StoreReportItems(
                      itemIcon: 'assets/images/stock.png',
                      itemValues: '1200',
                      itemName: 'TODAY\'S TOTAL',
                    ),
                    const StoreReportItems(
                      itemIcon: 'assets/images/shipping.png',
                      itemValues: '1200',
                      itemName: 'STOCK OUTS',
                    ),
                    const StoreReportItems(
                      itemIcon: 'assets/images/admin.png',
                      itemValues: '1200',
                      itemName: 'DISPUTES',
                    ),
                    const StoreReportItems(
                      itemIcon: 'assets/images/setting.png',
                      itemValues: '1200',
                      itemName: 'REFUND REQUESTS',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                'More Option:',
                style: TextStyle(
                  color: const Color(0xFF484848),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                height: 230.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const CatalogueScreen()));
                          },
                          child: const MoreOptionItems(
                            itemIcon: 'assets/images/catelog.png',
                            itemName: 'Catalog',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const OrderMainPage(
                                      index: 0,
                                    )));
                          },
                          child: const MoreOptionItems(
                            itemIcon: 'assets/images/order.png',
                            itemName: 'Order',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const InventoryPage()));
                          },
                          child: const MoreOptionItems(
                            itemIcon: 'assets/images/stock.png',
                            itemName: 'Stock',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MoreOptionItems(
                          itemIcon: 'assets/images/shipping.png',
                          itemName: 'Shipping',
                        ),
                        MoreOptionItems(
                          itemIcon: 'assets/images/admin.png',
                          itemName: 'admin',
                        ),
                        MoreOptionItems(
                          itemIcon: 'assets/images/setting.png',
                          itemName: 'Setting',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                'Top Selling Items:',
                style: TextStyle(
                  color: const Color(0xFF484848),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 64.h,
                          width: 64.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/car.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SKU:',
                              style: TextStyle(
                                color: const Color(0xFF484848),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Product Name',
                              style: TextStyle(
                                color: const Color(0xFF484848),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '117',
                          style: TextStyle(
                            color: const Color(0xFF484848),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Units',
                          style: TextStyle(
                            color: const Color(0xFF484848),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 12.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
