import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_details_provider.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_details_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/stock/suppliers/widgets/supplier_info_tile.dart';

class WarehouseDetailsPage extends HookConsumerWidget {
  const WarehouseDetailsPage({Key? key, required this.warehouseId})
      : super(key: key);

  final int warehouseId;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(warehouseDetailsProvider.notifier)
            .getWarehouseDetails(warehouseId: warehouseId);
      });
      return null;
    }, []);

    final warehouseDetails = ref.watch(
        warehouseDetailsProvider.select((value) => value.warehouseDetails));

    final loading =
        ref.watch(warehouseDetailsProvider.select((value) => value.loading));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: loading ? const SizedBox() : Text(warehouseDetails.name),
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(warehouseDetails.image),
                    radius: 100,
                  ),
                ),
                SizedBox(height: 20.h),
                InfoTile(title: 'name'.tr(), value: warehouseDetails.name),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'status'.tr(),
                    value: warehouseDetails.active
                        ? 'active'.tr()
                        : 'inactive'.tr()),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'description'.tr(),
                    value: warehouseDetails.description),
                SizedBox(height: 10.h),
                InfoTile(title: 'email'.tr(), value: warehouseDetails.email),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'address'.tr(),
                    value:
                        '${warehouseDetails.primaryAddress.addressLine1},\n${warehouseDetails.primaryAddress.addressLine2}\n${warehouseDetails.primaryAddress.country.name}'),
              ],
            ),
    );
  }
}
