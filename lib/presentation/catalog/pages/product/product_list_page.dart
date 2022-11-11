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
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(productProvider.notifier).getMoreProducts();
          }
        },
      );
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

    final productPaginationModel =
        ref.watch(productProvider.notifier).productPaginationModel;

    final products = ref.watch(productProvider).productList;

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
          : ListView.separated(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
              itemCount: products.length,
              itemBuilder: (context, index) {
                if ((index == products.length - 1) &&
                    products.length < productPaginationModel.meta.total!) {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ProductTile(product: products[index]);
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 3.h,
              ),
            ),
    );
  }
}
