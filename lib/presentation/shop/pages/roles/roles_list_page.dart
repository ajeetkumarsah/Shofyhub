import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/roles/role_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/add_role_page.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/role_list_tile.dart';

class RolesListPage extends HookConsumerWidget {
  const RolesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(roleProvider.notifier).getRoles();
        ref.read(roleProvider.notifier).getPermissions();
      });
      return null;
    }, []);

    final roleList = ref.watch(roleProvider.select((value) => value.roleList));

    final loading = ref.watch(roleProvider.select((value) => value.loading));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const AddRolePage());
        },
        label: Text('add_new'.tr()),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return ref.read(roleProvider.notifier).getRoles();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      itemCount: roleList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RoleListTile(role: roleList[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
