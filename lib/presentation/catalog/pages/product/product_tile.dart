import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/domain/app/product/product_model.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/product/product_details_page.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/product/trash_product_dialog.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/product/update_product_page.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductDetailsPage(
                productId: product.id, productTitle: product.name),
          ));
        },
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(product.image),
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('model: ${product.modelNumber}'),
            Text('brand: ${product.brand}')
          ],
        ),
        trailing: PopupMenuButton(
          tooltip: '',
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
          icon: const Icon(Icons.more_horiz),
          onSelected: (index) {
            if (index == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => UpdateProductPage(productId: product.id)));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) => TrashProductDialog(product.id));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("edit".tr()),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "trash".tr(),
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
