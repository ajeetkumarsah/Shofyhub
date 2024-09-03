import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/domain/app/product/product_model.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/product/delete_product_dialog.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/product/restore_product_dialog.dart';

class TrashProductTile extends StatelessWidget {
  final ProductModel product;
  const TrashProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.trashColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Image(image: NetworkImage(product.image)),
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
              showDialog(
                  context: context,
                  builder: (context) => RestoreProductDialog(
                        productId: product.id,
                      ));
            }
            if (index == 2) {
              showDialog(
                  context: context,
                  builder: (context) => DeleteProductDialog(
                        productId: product.id,
                      ));
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("restore".tr()),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "delete".tr(),
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
