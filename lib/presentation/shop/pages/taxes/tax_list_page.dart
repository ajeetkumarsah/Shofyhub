import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/form/country_provider.dart';
import 'package:alpesportif_seller/application/app/shop/taxes/tax_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:alpesportif_seller/presentation/shop/pages/taxes/create_tax_page.dart';
import 'package:alpesportif_seller/presentation/shop/pages/taxes/widgets/tax_list_tile.dart';

class TaxListPage extends HookConsumerWidget {
  const TaxListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(taxProvider.notifier).getAllTax();
        ref.read(countryProvider.notifier).loadData();
      });

      return null;
    }, []);

    final loading = ref.watch(taxProvider.select((value) => value.loading));
    final taxList = ref.watch(taxProvider.select((value) => value.taxList));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateTaxPage()));
        },
        label: Text('add_tax'.tr()),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : taxList.isEmpty
              ? const NoItemFound()
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
                      return TaxListTile(
                        taxItem: taxList[index],
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
