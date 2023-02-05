import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/app/dashboard/widgets/logout_dialog.dart';
import 'package:zcart_seller/presentation/settings.dart/shop_config_page.dart';
import 'package:zcart_seller/presentation/settings.dart/shop_settings_page.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({Key? key, this.hasBackButton = false}) : super(key: key);

  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
        automaticallyImplyLeading: hasBackButton,
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
            title: Text('shop_settings'.tr()),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShopConfigPage()),
              );
            },
            leading: const Icon(Icons.settings_applications_outlined),
            title: Text('shop_configuration'.tr()),
          ),
        ),
      ]),
    );
  }
}
