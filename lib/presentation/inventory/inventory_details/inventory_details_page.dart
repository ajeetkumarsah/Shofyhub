import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/inventories/inventory_details_provider.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/widgets/description.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/widgets/left_side_text.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/widgets/listing.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/widgets/offer.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/widgets/product.dart';
import 'package:zcart_seller/presentation/inventory/inventory_details/widgets/right_side_text.dart';
import 'package:zcart_seller/presentation/widget_for_all/color.dart';

class InventoryDetailsPage extends HookConsumerWidget {
  final int id;

  const InventoryDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(inventoryDetailsProvider(id).notifier).inventoryDetails();
      });
      return null;
    }, []);

    final pageContoller = usePageController();
    final navigationSelect = useState(0);

    final productDetails = ref.watch(
        inventoryDetailsProvider(id).select((value) => value.inventoryDetails));
    final List<Widget> pages = [
      ListingTile(
        productDetails: productDetails,
      ),
      ProductTile(
        productDetails: productDetails,
      ),
      DescriptionTile(
        description: productDetails.description,
      ),
      OfferTile(
        productDetails: productDetails,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Inventory Details'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: ListView(
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(productDetails.product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LeftSideText(
                  title: 'Name:',
                ),
                RightSideText(
                  subTitle: productDetails.title,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LeftSideText(
                  title: 'Brand:',
                ),
                RightSideText(
                  subTitle: productDetails.product.brand,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LeftSideText(
                  title: 'Model No:',
                ),
                RightSideText(
                  subTitle: productDetails.product.modelNumber,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LeftSideText(
                  title: 'Status:',
                ),
                RightSideText(
                  subTitle: productDetails.active ? 'Active' : 'Inactive',
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LeftSideText(
                  title: 'Available Form:',
                ),
                RightSideText(
                  subTitle: productDetails.product.availableFrom,
                ),
              ],
            ),
            // SizedBox(height: 12.h),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     LeftSideText(
            //       title: 'Last Update:',
            //     ),
            //     RightSideText(
            //       subTitle: 'Sat, Jul 30,2022  6.57 PM',
            //     ),
            //   ],
            // ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 37.h,
                  width: 70.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: navigationSelect.value != 0
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF683CB7),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF683CB7),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 11.h),
                    ),
                    onPressed: () {
                      navigationSelect.value = 0;
                    },
                    child: Text(
                      'Listing',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: navigationSelect.value != 0
                            ? const Color(0xFF4D4D4D)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 37.h,
                  width: 70.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: navigationSelect.value != 1
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF683CB7),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF683CB7),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 11.h),
                    ),
                    onPressed: () {
                      navigationSelect.value = 1;
                    },
                    child: Text(
                      'Product',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: navigationSelect.value != 1
                            ? const Color(0xFF4D4D4D)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 37.h,
                  width: 70.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: navigationSelect.value != 2
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF683CB7),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF683CB7),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 11.h),
                    ),
                    onPressed: () {
                      navigationSelect.value = 2;
                    },
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: navigationSelect.value != 2
                            ? const Color(0xFF4D4D4D)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 37.h,
                  width: 70.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: navigationSelect.value != 3
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF683CB7),
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFF683CB7),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 11.h),
                    ),
                    onPressed: () {
                      navigationSelect.value = 3;
                    },
                    child: Text(
                      'Offer',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: navigationSelect.value != 3
                            ? const Color(0xFF4D4D4D)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              // width: double.infinity,
              height: 700.h,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageContoller,
                itemCount: pages.length,
                itemBuilder: (context, index) => pages[navigationSelect.value],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
