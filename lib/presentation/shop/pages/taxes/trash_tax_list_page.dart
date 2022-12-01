import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/shop/taxes/tax_provider.dart';
import 'package:zcart_seller/presentation/shop/pages/taxes/widgets/trash_tax_list_tile.dart';

class TrashTaxListPage extends HookConsumerWidget {
  const TrashTaxListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(taxProvider.notifier).getTrashTax();
        ref.read(countryProvider.notifier).loadData();
      });

      return null;
    }, []);

    final loading = ref.watch(taxProvider.select((value) => value.loading));

    final taxList =
        ref.watch(taxProvider.select((value) => value.trashTaxlist));

    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : taxList.isEmpty
              ? Center(
                  child: Text(
                    'no_item_available'.tr(),
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return ref.read(taxProvider.notifier).getAllTax();
                  },
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    itemCount: taxList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: TrashTaxListTile(
                          taxItem: taxList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3.h,
                    ),
                  ),
                ),
    );
  }
}
