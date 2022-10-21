import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_details_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/stock/suppliers/widgets/supplier_info_tile.dart';

class SupplierDetailsPage extends HookConsumerWidget {
  const SupplierDetailsPage({Key? key, required this.supplierId})
      : super(key: key);

  final int supplierId;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(supplierDetailsProvider.notifier)
            .getSupplierDetails(supplierId: supplierId);
      });
      return null;
    }, []);

    final supplierDetails = ref.watch(
        supplierDetailsProvider.select((value) => value.supplierDetails));
    final loading =
        ref.watch(supplierDetailsProvider.select((value) => value.loading));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: loading ? const SizedBox() : Text(supplierDetails.name),
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
                    backgroundImage: NetworkImage(supplierDetails.image),
                    radius: 100,
                  ),
                ),
                SizedBox(height: 20.h),
                InfoTile(title: 'name'.tr(), value: supplierDetails.name),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'contact_person'.tr(),
                    value: supplierDetails.contactPerson),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'status'.tr(),
                    value: supplierDetails.active
                        ? 'active'.tr()
                        : 'inactive'.tr()),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'description'.tr(),
                    value: supplierDetails.description),
                SizedBox(height: 10.h),
                InfoTile(title: 'email'.tr(), value: supplierDetails.email),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'address'.tr(),
                    value:
                        '${supplierDetails.primaryAddress.addressLine1},\n ${supplierDetails.primaryAddress.addressLine2} \n ${supplierDetails.primaryAddress.country.name}'),
              ],
            ),
    );
  }
}
