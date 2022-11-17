import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/user/shop_user_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/shop/pages/user/widget/add_shop_user.dart';
import 'package:zcart_seller/presentation/shop/pages/user/widget/delete_shop_user_dialog.dart';
import 'package:zcart_seller/presentation/shop/pages/user/widget/restore_shop_user_dialog.dart';

class TrashUserListPage extends HookConsumerWidget {
  const TrashUserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(shopUserProvider.notifier).getTrashShopUser();
      });
      return null;
    }, []);

    final userList =
        ref.watch(shopUserProvider.select((value) => value.getTrashShopUser));
    final loading =
        ref.watch(shopUserProvider.select((value) => value.loading));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const AddShopUserPage());
        },
        label: const Text('Add new'),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : userList.isEmpty
              ? const NoItemFound()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemCount: userList.length,
                        itemBuilder: (context, index) => Card(
                          color: Constants.trashColor,
                          child: ListTile(
                            title: Text(
                              userList[index].name,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                            subtitle: Text(
                              'Email: ${userList[index].email}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
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
                                          RestoreShopUserDialog(
                                            id: userList[index].id,
                                          ));
                                }
                                if (index2 == 2) {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DeleteShopUserDialog(
                                            id: userList[index].id,
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
