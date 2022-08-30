import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/domain/app/Product/product_model.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/delete_product_dialog.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
          if (index == 1) {}
          if (index == 2) {
            showDialog(
                context: context,
                builder: (context) => DeleteProductDialog(
                      productId: product.id,
                    ));
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text("Edit"),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
