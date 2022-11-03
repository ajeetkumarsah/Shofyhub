import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/dashboard/dashboard_provider.dart';

class TopSellingProducts extends HookConsumerWidget {
  const TopSellingProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(dashboardProvider.notifier).getTopSellingItems();
      });
      return null;
    }, []);
    final topSellingItems =
        ref.watch(dashboardProvider.select((value) => value.topSellingItems));
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Selling Items:',
          style: TextStyle(
            color: const Color(0xFF484848),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20.h),
        topSellingItems.isEmpty
            ? Center(child: Text('no_item_found'.tr()))
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topSellingItems.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 64.h,
                          width: 64.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(topSellingItems[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text(
                                topSellingItems[index].title,
                                style: TextStyle(
                                    color: const Color(0xFF484848),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.fade),
                              ),
                            ),
                            SizedBox(height: 2.w),
                            Text(
                              topSellingItems[index].sku,
                              style: TextStyle(
                                color: const Color(0xFF484848),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.w),
                            Text(
                              topSellingItems[index].price,
                              style: TextStyle(
                                color: const Color(0xFF484848),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 12.h,
                ),
              ),
      ],
    );
  }
}
