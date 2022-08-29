import 'package:flutter/material.dart';
import 'package:zcart_vendor/config/config.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/helper/navigator_helper.dart';
import 'package:zcart_vendor/views/account/address_page.dart';
import 'package:zcart_vendor/views/account/billing_page.dart';
import 'package:zcart_vendor/views/account/change_password_page.dart';
import 'package:zcart_vendor/views/account/profile_page.dart';
import 'package:zcart_vendor/views/account/support_ticket_page.dart';
import 'package:zcart_vendor/views/account/verification_status_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _menuItems = [
      "Addresses",
      "Change Password",
      "Verification Status"
    ];

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius)),
              onSelected: (value) {
                switch (value) {
                  case 0:
                    MyNav.goTo(context, const AddressPage());
                    break;
                  case 1:
                    MyNav.goTo(context, const ChangePasswordPage());
                    break;
                  case 2:
                    MyNav.goTo(context, const VerificationStatusPage());
                    break;
                  default:
                    break;
                }
              },
              itemBuilder: (context) {
                return _menuItems
                    .map((e) => PopupMenuItem(
                          child: Text(e),
                          value: _menuItems.indexOf(e),
                        ))
                    .toList();
              },
            )
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: TabBar(
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black38,
            indicatorColor: MyConfig.primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
              Tab(
                icon: Icon(Icons.credit_card),
                text: 'Billing',
              ),
              Tab(
                icon: Icon(Icons.contact_support),
                text: 'Support Ticket',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProfilePage(),
            BillingPage(),
            SupportTicketPage(),
          ],
        ),
      ),
    );
  }
}
