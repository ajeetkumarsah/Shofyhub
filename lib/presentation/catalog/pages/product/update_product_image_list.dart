import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/Product/product_image_provider.dart';

class UpdateProductImageList extends ConsumerWidget {
  const UpdateProductImageList({
    Key? key,
    required this.productImages,
  }) : super(key: key);

  final List<CustomImageModel> productImages;

  @override
  Widget build(BuildContext context, ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productImages.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.file(
                productImages[index].image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: -10,
              top: -10,
              child: IconButton(
                onPressed: () {
                  ref
                      .read(productImagePickerProvider)
                      .removeImage(index, productImages[index].imageId);
                  // Logger.i('Image Id: ${productImages[index].imageId}');
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
