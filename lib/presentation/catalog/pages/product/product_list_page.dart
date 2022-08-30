import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/Product/product_provider.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/add_product_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/product_tile.dart';

class ProductListPage extends HookConsumerWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(productProvider.notifier).getProducts();
      });

      return null;
    }, []);
    final products =
        ref.watch(productProvider.select((value) => value.productList));
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.green[100],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddProductPage()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.green[700],
                ),
                label: Text(
                  'Add product',
                  style: TextStyle(
                    color: Colors.green[700],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  ProductTile(product: products[index]),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
