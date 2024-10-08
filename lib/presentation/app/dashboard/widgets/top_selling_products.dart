import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/dashboard/dashboard_provider.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/product/product_details_page.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';

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
          'Top Selling Items',
          style: TextStyle(
            color: const Color(0xFF484848),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: topSellingItems.isEmpty
                ? const NoItemFound()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topSellingItems.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ProductDetailsPage(
                                  productId: topSellingItems[index].id,
                                  productTitle: topSellingItems[index].title),
                            ));
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 64.h,
                                width: 64.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        topSellingItems[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
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
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 12.h,
                      child: const Divider(),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
