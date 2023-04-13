import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/application/app/dashboard/dashboard_provider.dart';
import 'package:zcart_seller/application/app/form/business_days_provider.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/order%20management/refunds/refund_provider.dart';
import 'package:zcart_seller/application/app/order/order_provider.dart';
import 'package:zcart_seller/application/app/settings/shop_settings_provider.dart';
import 'package:zcart_seller/application/app/shop/taxes/tax_provider.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_provider.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventories_provider.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_provider.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_provider.dart';
import 'package:zcart_seller/presentation/catalog/catalogue_screen.dart';
import 'package:zcart_seller/presentation/order/order_main_page.dart';
import 'package:zcart_seller/presentation/settings.dart/settings_home.dart';
import 'package:zcart_seller/presentation/shop/shop_home.dart';
import 'package:zcart_seller/presentation/stock/stock_home.dart';
import 'package:zcart_seller/presentation/support/support_home_page.dart';
import 'package:zcart_seller/presentation/widget_for_all/zcart_appbar.dart';
import 'widgets/more_option_item.dart';
import 'widgets/order_grid.dart';
import 'widgets/top_selling_products.dart';
import 'widgets/total_info_widget.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(shopSettingsProvider.notifier).getSystemConfigs();
        ref.read(shopSettingsProvider.notifier).getShopSettings();
        ref.read(shopSettingsProvider.notifier).getShopConfigs();
        ref.read(shopUserProvider.notifier).getShopUser();

        ref.read(orderProvider.notifier).getOrders();
        ref.read(orderProvider.notifier).getFullFilledOrders();
        // ref.read(orderProvider.notifier).getUnFullFilledOrders();
        // ref.read(orderProvider.notifier).getArchivedOrders();

        ref
            .read(stockeInventoryProvider.notifier)
            .getAllInventories(inventoryFilter: 'active');
        ref.read(categoryGroupProvider.notifier).getAllCategoryGroup();
        ref.read(refundProvider.notifier).getOpenRefunds();
        ref.read(dashboardProvider.notifier).getStatistics();
        ref.read(warehouseProvider.notifier).getWarehouseItems();
        ref.read(taxProvider.notifier).getAllTax();
        ref.read(supplierProvider.notifier).getAllSuppliers();
        ref.read(countryProvider.notifier).loadData();
        ref.read(businessDaysProvider.notifier).loadData();
      });
      return null;
    }, []);

    final totalOrders =
        ref.watch(orderProvider.select((value) => value.orderModel.meta.total));

    final statistics =
        ref.watch(dashboardProvider.select((value) => value.statistics));

    final shopData =
        ref.watch(shopSettingsProvider.select((value) => value.shopSettings));

    // final shopDataLoading =
    //     ref.watch(shopSettingsProvider.select((value) => value.loading));

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: ZcartAppBar(title: shopData.name),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 100), () async {
            ref.read(shopSettingsProvider.notifier).getSystemConfigs();
            ref.read(shopSettingsProvider.notifier).getShopSettings();
            ref.read(shopSettingsProvider.notifier).getShopConfigs();
            ref.read(orderProvider.notifier).getOrders();
            ref.read(orderProvider.notifier).getFullFilledOrders();
            ref.read(orderProvider.notifier).getUnFullFilledOrders();
            ref.read(orderProvider.notifier).getArchivedOrders();

            ref
                .read(stockeInventoryProvider.notifier)
                .getAllInventories(inventoryFilter: 'active');
            ref.read(categoryGroupProvider.notifier).getAllCategoryGroup();
            ref.read(categoryGroupProvider.notifier).getTrashCategoryGroup();
            ref.read(refundProvider.notifier).getOpenRefunds();
            ref.read(dashboardProvider.notifier).getStatistics();
          });
        },
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TotalInfoWidget(
                    icon: FontAwesomeIcons.clipboard,
                    title: 'Total Order',
                    color: Colors.blue,
                    value: totalOrders.toString(),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const OrderMainPage(
                                index: 0,
                              )));
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TotalInfoWidget(
                    icon: FontAwesomeIcons.percent,
                    title: 'Today\'s Sale',
                    color: Colors.teal,
                    value: statistics.todaysSaleAmount,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const OrderMainPage(
                                index: 0,
                              )));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TotalInfoWidget(
                    icon: FontAwesomeIcons.clipboardList,
                    title: 'Total Latest Order',
                    color: Colors.purple,
                    value: statistics.latestOrderCount.toString(),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => const LatesOrderListPage()));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const OrderMainPage(
                                index: 0,
                              )));
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TotalInfoWidget(
                    icon: FontAwesomeIcons.boxOpen,
                    title: 'YESTERDAY\'S TOTAL',
                    color: Colors.pink,
                    value: statistics.yesterdaysSaleAmount,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const OrderMainPage(
                                index: 0,
                              )));
                    },
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
            // Store Reports Icon Data
            OrderGrid(
              statistics: statistics,
            ),
            SizedBox(height: 25.h),
            Text(
              'More Option',
              style: TextStyle(
                color: const Color(0xFF484848),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              height: 240.h,
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
                      MoreOptionItems(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const CatalogueScreen()));
                        },
                        icon: FontAwesomeIcons.bookBookmark,
                        title: 'Catalog',
                      ),
                      MoreOptionItems(
                        icon: FontAwesomeIcons.file,
                        title: 'Order',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const OrderMainPage(
                                    index: 0,
                                  )));
                        },
                      ),
                      MoreOptionItems(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const StockHome()));
                        },
                        icon: FontAwesomeIcons.store,
                        title: 'Stock',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MoreOptionItems(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const SupportHome()));
                        },
                        icon: FontAwesomeIcons.firstOrder,
                        title: 'Support',
                      ),
                      MoreOptionItems(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ShopHome()));
                        },
                        icon: FontAwesomeIcons.personDotsFromLine,
                        title: 'Admin',
                      ),
                      MoreOptionItems(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const SettingsHome(
                                    hasBackButton: true,
                                  )));
                        },
                        icon: FontAwesomeIcons.gear,
                        title: 'Setting',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            const TopSellingProducts(),
          ],
        ),
      ),
    );
  }
}
