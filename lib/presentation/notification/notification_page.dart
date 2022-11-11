import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/notification/notification_provider.dart';
import 'package:zcart_seller/domain/app/notification/notification_model.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {});

      return null;
    }, []);

    List<NotificationModel> notificationList =
        ref.read(notificationProvider).notifications;

    return Scaffold(
      appBar: AppBar(
        title: Text('notification'.tr()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
      ),
      body: notificationList.isEmpty
          ? Center(
              child: Text('no_item_found'.tr()),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 4.h,
              ),
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 13),
                  child: Container(
                    padding: const EdgeInsets.only(top: 15),
                    height: 85.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Order #09876543",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            notificationList[index].title,
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            DateFormat('dd MMM yyyy hh:mm a')
                                .format(notificationList[index].dateTime),
                            style: const TextStyle(
                              color: Color(0xffB0B0B0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
