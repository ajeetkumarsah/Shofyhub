import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/shop/delivary%20boy/delivary_boy_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:alpesportif_seller/presentation/shop/pages/delivary%20boy/delivery_boy_details_page.dart';
import 'package:alpesportif_seller/presentation/shop/pages/delivary%20boy/widgets/create_update_delivary_boy_page.dart';
import 'package:alpesportif_seller/presentation/shop/pages/delivary%20boy/widgets/trash_delivary_dialog.dart';

class DelivaryBoyListPage extends HookConsumerWidget {
  const DelivaryBoyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(delivaryBoyProvider.notifier).getAllDelivaryBoy();
      });
      return null;
    }, []);
    final delivaryBoyList =
        ref.watch(delivaryBoyProvider.select((value) => value.delivaryBoyList));
    final loading =
        ref.watch(delivaryBoyProvider.select((value) => value.loading));

    return Scaffold(
      floatingActionButton: loading
          ? null
          : FloatingActionButton.extended(
              backgroundColor: Constants.buttonColor,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const CreateUpdateDelivaryBoyPage());
              },
              label: const Text('Add new'),
              icon: const Icon(Icons.add),
            ),
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
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeliveryBoyDetailsPage(
                                    deliveryBoyData: delivaryBoyList[index],
                                  ),
                                ),
                              );
                            },
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateUpdateDelivaryBoyPage(
                                                delivaryBoyDetails:
                                                    delivaryBoyList[index],
                                              )));
                                }
                                if (index2 == 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => TrashDelivaryDialog(
                                            delivaryBoyId:
                                                delivaryBoyList[index].id,
                                          ));
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text("edit".tr()),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text(
                                    "trash".tr(),
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
