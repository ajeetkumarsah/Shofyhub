import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/catalog/manufacturer/manufacturer_details_provider.dart';
import 'package:alpesportif_seller/presentation/core/widgets/info_tile.dart';
import 'package:alpesportif_seller/presentation/core/widgets/loading_widget.dart';

class ManufacturerDetails extends HookConsumerWidget {
  final int manufacturerId;
  const ManufacturerDetails({Key? key, required this.manufacturerId})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref
            .read(manufacturerDetailsProvider(manufacturerId).notifier)
            .getManufacturerDetails();
      });
      return null;
    }, []);

    final loading = ref.watch(manufacturerDetailsProvider(manufacturerId)
        .select((value) => value.loading));
    final manufactuererDetails = ref.watch(
        manufacturerDetailsProvider(manufacturerId)
            .select((value) => value.manufacturerDetails));
    return Scaffold(
      appBar: AppBar(title: Text(loading ? '...' : manufactuererDetails.name)),
      body: loading
          ? const LoadingWidget()
          : ListView(
              children: [
                Container(
                  height: ScreenUtil().screenHeight * 0.35,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(manufactuererDetails.image),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                InfoTile(title: 'name'.tr(), value: manufactuererDetails.name),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'country'.tr(), value: manufactuererDetails.origin),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'available_from'.tr(),
                    value: manufactuererDetails.availableFrom),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'email'.tr(), value: manufactuererDetails.email),
                SizedBox(height: 10.h),
                InfoTile(
                    title: 'phone'.tr(), value: manufactuererDetails.phone),
                SizedBox(height: 10.h),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'description'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        manufactuererDetails.description,
                      ),
                      SizedBox(width: 20.h),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
