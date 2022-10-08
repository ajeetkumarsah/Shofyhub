import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/support/cancellation/cancalletion_list_page.dart';
import 'package:zcart_seller/presentation/support/dispute/dispute_list_page.dart';
import 'package:zcart_seller/presentation/support/refund/refund_home.dart';

class SupportHome extends StatelessWidget {
  const SupportHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Constants.appbarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22.r),
            ),
          ),
          title: Text('support'.tr()),
          elevation: 0,
          bottom: TabBar(
            indicatorWeight: 4,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white10),
            tabs: [
              Tab(
                text: 'refund'.tr(),
              ),
              Tab(
                text: 'dispute'.tr(),
              ),
              Tab(
                text: 'cancellation'.tr(),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          RefundHome(),
          DisputeListPage(),
          CancellationListPage(),
        ]),
      ),
    );
  }
}
