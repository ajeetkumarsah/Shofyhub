import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/core/shared_prefs.dart';
import 'package:zcart_seller/infrastructure/app/notification/notification_model.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    List<NotificationModel> notificationList = [];
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        final data = await SharedPref.getNotifications();
        notificationList.addAll(data);
      });

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: Text('notification'.tr())),
      body: notificationList.isEmpty
          ? Center(
              child: Text('no_item_found'.tr()),
            )
          : ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(notificationList[index].title),
                    subtitle: Text(notificationList[index].description),
                  ),
                );
              }),
    );
  }
}
