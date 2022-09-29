import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/application/app/product/product_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/create_product_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/product_tile.dart';

import '../../../../application/app/catalog/atributes/get_atributes_provider.dart';

class ProductListPage extends HookConsumerWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(productProvider.notifier).getProducts();
        ref.read(getAttributesProvider.notifier).getCategories();
        ref.read(productProvider.notifier).gtinType();
        ref.read(productProvider.notifier).tagList();
        ref.read(productProvider.notifier).manufacturer();
        ref.read(countryProvider.notifier).loadData();
      });

      return null;
    }, []);
    final products =
        ref.watch(productProvider.select((value) => value.productList));

    final loading = ref.watch(productProvider.select((value) => value.loading));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const AddProductPage());
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
                      return ref
                          .refresh(productProvider.notifier)
                          .getProducts();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                      physics: const BouncingScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) =>
                          ProductTile(product: products[index]),
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
