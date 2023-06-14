import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/description.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/left_side_text.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/listing.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/offer.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/product.dart';
import 'package:zcart_seller/presentation/stock/inventory/widgets/right_side_text.dart';
import 'package:zcart_seller/providers/stocks/inventories_provider.dart';

class InventoryDetailsPage extends ConsumerStatefulWidget {
  final int id;
  const InventoryDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<InventoryDetailsPage> createState() =>
      _InventoryDetailsPageState();
}

class _InventoryDetailsPageState extends ConsumerState<InventoryDetailsPage> {
  int navigationSelect = 0;
  @override
  Widget build(BuildContext context) {
    final detailsRef = ref.watch(inventoryDetailsFutureProvider(widget.id));

    // int navigationSelect = use

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Inventory Details'),
        elevation: 0,
      ),
      body: detailsRef.when(
        data: (data) {
          final productDetails = data.data;

          if (productDetails == null) {
            return const Center(child: Text('No data found'));
          } else {
            final List<Widget> pages = [
              ListingTile(productDetails: data),
              ProductTile(productDetails: data),
              DescriptionTile(description: productDetails.description ?? ""),
              OfferTile(productDetails: data),
            ];

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              children: [
                Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(productDetails.product?.image ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(title: 'Name:'),
                    RightSideText(subTitle: productDetails.title ?? "N/A"),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(title: 'Brand:'),
                    RightSideText(
                        subTitle: productDetails.product?.brand ?? "N/A"),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(title: 'Model No:'),
                    RightSideText(
                        subTitle: productDetails.product?.modelNumber ?? "N/A"),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(title: 'Status:'),
                    RightSideText(
                      subTitle: (productDetails.active ?? false)
                          ? 'Active'
                          : 'Inactive',
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LeftSideText(title: 'Available Form:'),
                    RightSideText(
                      subTitle: productDetails.product?.availableFrom ?? "N/A",
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 37.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: navigationSelect != 0
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF683CB7),
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF683CB7),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 11.h),
                        ),
                        onPressed: () {
                          setState(() {
                            navigationSelect = 0;
                          });
                        },
                        child: Text(
                          'Listing',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: navigationSelect != 0
                                ? const Color(0xFF4D4D4D)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 37.h,
                      // width: 70.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: navigationSelect != 1
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF683CB7),
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF683CB7),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 11.h),
                        ),
                        onPressed: () {
                          setState(() {
                            navigationSelect = 1;
                          });
                        },
                        child: Text(
                          'Product',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: navigationSelect != 1
                                ? const Color(0xFF4D4D4D)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 37.h,
                      // width: 70.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: navigationSelect != 2
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF683CB7),
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF683CB7),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 11.h),
                        ),
                        onPressed: () {
                          setState(() {
                            navigationSelect = 2;
                          });
                        },
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: navigationSelect != 2
                                ? const Color(0xFF4D4D4D)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 37.h,
                      // width: 70.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: navigationSelect != 3
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFF683CB7),
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF683CB7),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 11.h),
                        ),
                        onPressed: () {
                          setState(() {
                            navigationSelect = 3;
                          });
                        },
                        child: Text(
                          'Offer',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: navigationSelect != 3
                                ? const Color(0xFF4D4D4D)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 450.h,
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pages.length,
                    itemBuilder: (context, index) => pages[navigationSelect],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor),
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return UpdateInventoryPage(
                    //       inventoryId: productDetails.id);
                    // }));
                  },
                  child: SizedBox(
                      height: 60,
                      child: Center(child: Text('update_inventory'.tr()))),
                ),
              ],
            );
          }
        },
        error: (error, stack) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
