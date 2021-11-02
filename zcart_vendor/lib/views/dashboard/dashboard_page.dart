import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/helper/navigator_helper.dart';
import 'package:zcart_vendor/views/custom/custom_headline.dart';
import 'package:zcart_vendor/views/custom/information_card.dart';
import 'package:zcart_vendor/views/custom/information_card_icon.dart';
import 'package:zcart_vendor/views/orders/orders_page.dart';
import 'package:zcart_vendor/views/account/account_page.dart';

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
              ExpansionTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Orders'),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Orders"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      MyNav.goTo(context, const OrdersPage());
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Pickup Orders"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement pickup orders
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Carts"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement carts
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Cancellations"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement cancellations
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(CupertinoIcons.rectangle_grid_2x2_fill),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                title: const Text('Catalog'),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Attributes"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement attributes
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Products"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement products
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Manufactures"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement manufacturers
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(CupertinoIcons.rectangle_3_offgrid_fill),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                title: const Text('Stock'),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Inventories"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement inventories
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Warehouses"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement warehouses
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Supplies"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement supplies
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.local_shipping),
                title: const Text('Shipping'),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Carriers"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement carriers
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Packaging"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement packaging
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Shipping zones"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement shipping zones
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.support),
                title: const Text('Support Desk'),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Chats"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement chats
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Messages"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement messages
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Disputes"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement disputes
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Refunds"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement refunds
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.local_offer),
                title: const Text('Promotions'),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Coupons"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement coupons
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Admin'),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Users"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement users
                    },
                  ),
                ],
              ),
              ExpansionTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                childrenPadding: const EdgeInsets.only(left: defaultPadding),
                children: [
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("User Roles"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement user roles
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Taxes"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement taxes
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("General Configs"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement general configs
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Configuration"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement configuration
                    },
                  ),
                  const Divider(height: 0, color: Colors.black12),
                  ListTile(
                    title: const Text("Payment Methods"),
                    leading: const Icon(Icons.double_arrow),
                    onTap: () {
                      //TODO: implement payment methods
                    },
                  ),
                ],
              ),
              const Divider(height: 0, color: Colors.black12),
              ListTile(
                leading: const Icon(CupertinoIcons.profile_circled),
                title: const Text('Account'),
                onTap: () {
                  MyNav.goTo(context, const AccountPage());
                },
              ),
              const Divider(height: 0, color: Colors.black12),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout'),
                onTap: () {},
              ),
              const Divider(height: 0, color: Colors.black12),
            ],
          ),
        )),
      );
}
