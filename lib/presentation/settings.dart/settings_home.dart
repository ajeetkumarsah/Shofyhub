import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/app/dashboard/widgets/logout_dialog.dart';
import 'package:zcart_seller/presentation/settings.dart/advance_shop_settings_page.dart';
import 'package:zcart_seller/presentation/settings.dart/basic_shop_settings_page.dart';
import 'package:zcart_seller/presentation/widget_for_all/zcart_appbar.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZcartAppBar(
        title: 'settings'.tr(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const LogoutDialog());
        },
        label: Text(
          'logout'.tr(),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(15), children: [
        Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShopSettingsPage()),
              );
            },
            leading: const Icon(Icons.settings_applications),
            title: Text('basic_shop_settings'.tr()),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdvanceShopSettingsPage()),
              );
            },
            leading: const Icon(Icons.settings_applications_outlined),
            title: Text('advance_shop_settings'.tr()),
          ),
        ),
      ]),
    );
  }
}
