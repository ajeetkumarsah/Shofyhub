import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:alpesportif_seller/application/auth/auth_provider.dart';
import 'package:alpesportif_seller/providers/stocks/inventories_provider.dart';

class TrashInventory extends ConsumerWidget {
  final int inventoryId;

  const TrashInventory({
    Key? key,
    required this.inventoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trash Inventory',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.h,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text('Are you sure you want to trash this Inventory?'),
      ),
      actions: [
        const Divider(
          height: 1,
          thickness: 1,
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.h,
                      width: 85.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        border: Border.all(
                          color: Theme.of(context).shadowColor.withOpacity(.5),
                        ),
                      ),
                      child: const Center(
                        child: Text('Cancel'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 85.w,
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      onPressed: () async {
                        final authRef = ref.read(authProvider);

                        toast('Moving to trash...');
                        await InventoryProvider.trashItem(
                          id: inventoryId,
                          apiKey: authRef.user.api_token,
                        ).then((value) {
                          toast('Moved to trash successfully');
                          ref.invalidate(inventoriesFutureProvider("active"));
                          ref.invalidate(inventoriesFutureProvider("trash"));

                          Navigator.of(context).pop();
                        }).onError((error, stackTrace) {
                          toast(error.toString());
                        });
                      },
                      child: Text(
                        "Trash",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
