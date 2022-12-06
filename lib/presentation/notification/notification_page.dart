import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/notification/notification_data_provider.dart';
import 'package:zcart_seller/application/app/notification/notification_provider.dart';
import 'package:zcart_seller/application/core/utils.dart';
import 'package:zcart_seller/domain/app/notification/notification_model.dart';
import 'package:zcart_seller/presentation/core/widgets/loading_widget.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/order_details_page/order_details_screen.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(notificationDataProvider.notifier).getNotifications();
        ref.read(notificationProvider).clearNotificationCount();
      });

      return null;
    }, []);

    List<NotificationModel> notificationList = ref.watch(
        notificationDataProvider.select((value) => value.notificationList));

    bool loading =
        ref.watch(notificationDataProvider.select((value) => value.loading));

    return Scaffold(
      appBar: AppBar(
        title: Text('notification'.tr()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
      ),
      body: loading
          ? const LoadingWidget()
          : notificationList.isEmpty
              ? const NoItemFound()
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 4.h,
                  ),
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    NotificationModel notification = notificationList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => OrderDetailsScreen(
                                id: notification.data.orderId)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
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
                              Text(
                                "Order ${notification.data.order}",
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                notification.data.subject,
                                style: const TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                notification.data.message,
                                style: const TextStyle(
                                  color: Color(0xffB0B0B0),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                Utils.dateTimeFormat(notification.createdAt),
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
