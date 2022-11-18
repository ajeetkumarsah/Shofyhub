import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/roles/permission_provider.dart';
import 'package:zcart_seller/application/app/shop/roles/role_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/roles/update_role_page.dart';
import 'package:zcart_seller/presentation/stock/suppliers/widgets/supplier_info_tile.dart';

class RoleDetailsPage extends HookConsumerWidget {
  final int roleId;

  const RoleDetailsPage({Key? key, required this.roleId}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final permissionNotifier = ref.watch(permissionProvider);

    final permissionList =
        ref.watch(roleProvider.select((value) => value.permissionList));

    final roleDetails =
        ref.watch(roleProvider.select((value) => value.roleDetails));
    final loading = ref.watch(roleProvider.select((value) => value.loading));

    final permissionIds = roleDetails.permissions.map((e) => e.id).toList();

    final permissions = permissionList
        .where((permission) => permissionIds.contains(permission.id))
        .toList();

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        permissionNotifier.selectedPermissionIds.clear();
        ref.read(roleProvider.notifier).getRoleDetails(roleId: roleId);
      });
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? '...' : roleDetails.name),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => UpdateRolePage(
                          roleId: roleId,
                        ));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.h),
          InfoTile(title: 'role'.tr(), value: roleDetails.name),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'description'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h),
                Text(
                  roleDetails.description,
                ),
                SizedBox(width: 20.h),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          InfoTile(
              title: 'role_level'.tr(), value: roleDetails.level.toString()),
          SizedBox(height: 20.h),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'permissions'.tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Constants.kGreenColor),
            ),
          ),
          const Divider(),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: permissions
                  .map((e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: e.permissions
                                .map(
                                  (p) => Row(
                                    children: [
                                      Text(p.name),
                                      const Checkbox(
                                        value: true,
                                        onChanged: null,
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                          const Divider(),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
