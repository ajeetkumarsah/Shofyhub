import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/views/catalog/catalog_page.dart';
import 'package:zcart_vendor/views/custom/custom_headline.dart';
import 'package:zcart_vendor/views/custom/information_card.dart';
import 'package:zcart_vendor/views/custom/information_card_icon.dart';
import 'package:zcart_vendor/views/orders/orders_page.dart';
import 'package:zcart_vendor/views/profile/profile_page.dart';
import 'package:zcart_vendor/views/promotions/promotion_page.dart';
import 'package:zcart_vendor/views/settings/settings_page.dart';
import 'package:zcart_vendor/views/shipping/shipping_page.dart';
import 'package:zcart_vendor/views/stock/stock_page.dart';
import 'package:zcart_vendor/views/support_desk/support_desk_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      drawer: _drawer(context),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InformationCardWithIcon(
              icon: Icons.shopping_bag,
              iconColor: Colors.orange,
              number: 45.toString(),
              title: 'New Orders',
            ),
            const SizedBox(height: defaultPadding),
            InformationCardWithIcon(
              icon: CupertinoIcons.rectangle_grid_2x2_fill,
              iconColor: Colors.green,
              number: 34.toString(),
              title: 'Total Products',
            ),
            const SizedBox(height: defaultPadding),
            InformationCardWithIcon(
              icon: CupertinoIcons.chat_bubble_2_fill,
              iconColor: Colors.blue,
              number: 3.toString(),
              title: 'Unread Messages',
            ),
            const SizedBox(height: defaultPadding),
            InformationCardWithIcon(
              icon: CupertinoIcons.info_circle_fill,
              iconColor: Colors.red,
              number: 12.toString(),
              title: 'Disputes',
            ),
            const SizedBox(height: defaultPadding),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: CustomHeadLine(title: "Summary"),
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                const Expanded(
                    child: InformationCard(
                        number: "Rs.1034.21", title: 'Last sale')),
                const SizedBox(width: defaultPadding),
                InformationCard(number: 3.toString(), title: 'Stock outs'),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                InformationCard(number: 78.toString(), title: 'Total Orders'),
                const SizedBox(width: defaultPadding),
                const Expanded(
                    child: InformationCard(
                        number: "Rs.7435.73", title: 'Total Sales')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: const Text('Dashboard'),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            //showSearch(context: context, delegate: SearchBarDelegate());
          },
        ),
      ],
    );
  }

  Drawer _drawer(BuildContext context) => Drawer(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      SizedBox(height: 8),
                      Text('Big Shop'),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Orders'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrdersPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.rectangle_grid_2x2_fill),
                title: const Text('Catalog'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CatalogPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.rectangle_3_offgrid_fill),
                title: const Text('Stock'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StockPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_shipping),
                title: const Text('Shipping'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShippingPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.chat_bubble_2_fill),
                title: const Text('Support Desk'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportDeskPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_offer),
                title: const Text('Promotions'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PromotionPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.profile_circled),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        )),
      );
}
