import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/attribute%20values/attribute_values_provider.dart';
import 'package:zcart_seller/application/app/catalog/attribute%20values/attribute_values_state.dart';

class DeleteAttributeValuesDialog extends HookConsumerWidget {
  final int attributeId;
  final int attributeValueId;
  const DeleteAttributeValuesDialog(
      {Key? key, required this.attributeId, required this.attributeValueId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    ref.listen<AttributeValuesState>(attributeValuesProvider(attributeId),
        (previous, next) {
      if (previous != next && !next.loading) {
        Navigator.of(context).pop();
        if (next.failure == CleanFailure.none()) {
          CherryToast.info(
            title: Text('attribute_deleted'.tr()),
            animationType: AnimationType.fromTop,
          ).show(context);
        } else if (next.failure != CleanFailure.none()) {
          CherryToast.error(
            title: Text(
              next.failure.error,
            ),
            toastPosition: Position.bottom,
          ).show(context);
        }
      }
    });
    final loading = ref.watch(
        attributeValuesProvider(attributeId).select((value) => value.loading));
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'delete_attribute'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text('are_sure_delete_attribute'.tr()),
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
                      child: Center(
                        child: Text('cancel'.tr()),
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
                            .read(attributeValuesProvider(attributeId).notifier)
                            .trashAttributeValue(attributeValueId);
                      },
                      child: loading
                          ? const Center(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            )
                          : Text(
                              "delete".tr(),
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
