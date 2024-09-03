import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/shop/delivary%20boy/delivary_boy_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:alpesportif_seller/presentation/shop/pages/delivary%20boy/widgets/delete_delivery_boy_dialog.dart';
import 'package:alpesportif_seller/presentation/shop/pages/delivary%20boy/widgets/restore_delivery_boy_dialog.dart';

class TrashDelivaryBoyListPage extends HookConsumerWidget {
  const TrashDelivaryBoyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(delivaryBoyProvider.notifier).getTrashDelivaryBoy();
      });
      return null;
    }, []);
    final delivaryBoyList = ref.watch(
        delivaryBoyProvider.select((value) => value.trashDelivaryBoyList));
    final loading =
        ref.watch(delivaryBoyProvider.select((value) => value.loading));

    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : delivaryBoyList.isEmpty
              ? const NoItemFound()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemCount: delivaryBoyList.length,
                        itemBuilder: (context, index) => Card(
                          color: Constants.trashColor,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(delivaryBoyList[index].avatar),
                            ),
                            isThreeLine: true,
                            title: Text(
                              '${delivaryBoyList[index].firstName} ${delivaryBoyList[index].lastName}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                            ),
                            subtitle: Text(
                                '${delivaryBoyList[index].email}\n${delivaryBoyList[index].phoneNumber}'),
                            trailing: PopupMenuButton(
                              tooltip: '',
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp)),
                              icon: const Icon(Icons.more_horiz),
                              onSelected: (index2) {
                                if (index2 == 1) {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          RestoreDeliveryBoyDialog(
                                            id: delivaryBoyList[index].id,
                                          ));
                                }
                                if (index2 == 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DeleteDeliveryBoyDialog(
                                            id: delivaryBoyList[index].id,
                                          ));
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text("restore".tr()),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text(
                                    "delete".tr(),
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 3.h,
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
