import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_provider.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_state.dart';

class DeleteShopUser extends HookConsumerWidget {
  final int userId;
  const DeleteShopUser({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<ShopUserState>(shopUserProvider, (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: const Text('User Deleted'),
            animationType: AnimationType.fromTop,
          ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.info(
            title: const Text('Something went wrong'),
            animationType: AnimationType.fromTop,
          ).show(context);
          next.failure.showDialogue(context);
        }
      }
    });
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delete User',
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
        padding: EdgeInsets.all(8.0),
        child: Text('Are you sure you want to delete this user?'),
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
                      onPressed: () {
                        ref
                            .read(shopUserProvider.notifier)
                            .trashShopUser(userId: userId);
                      },
                      child: Text(
                        "Delete",
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
