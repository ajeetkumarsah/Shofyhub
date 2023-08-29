import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/product/detail_product/detail_product_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/update_product_page.dart';

class ProductDetailsPage extends HookConsumerWidget {
  const ProductDetailsPage({
    Key? key,
    required this.productId,
    required this.productTitle,
  }) : super(key: key);

  final int productId;
  final String productTitle;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(detailProcuctProvider(productId).notifier).getDetailProduct();
      });
      return null;
    }, []);

    final productDetails = ref.watch(detailProcuctProvider(productId)
        .select((value) => value.detailProduct));

    final loading = ref.watch(
        detailProcuctProvider(productId).select((value) => value.loading));

    CarouselController carouselController = CarouselController();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        elevation: 0,
        title: Text(productTitle),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 200,
                    child: CarouselSlider(
                      items: productDetails.images
                          .map((image) => SizedBox(
                                width: ScreenUtil().screenWidth,
                                // height: ScreenUtil().screenHeight *
                                //     0.35,
                                child: Image(
                                  image: NetworkImage(image.path),
                                  fit: BoxFit.cover,
                                ),
                              ))
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        height: 243,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          // reviewDetailsNotifier.setCarouselIndex(index);
                        },
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      productDetails.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: HtmlWidget(productDetails.description),
                  ),
                  ListTile(
                    title: Text(
                      "Category",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: productDetails.categories.isEmpty
                        ? Text(
                            "No category",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : Text(
                            productDetails.categories
                                .map((e) => e.name)
                                .join(", "),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                  ),
                  // Model Number
                  ListTile(
                    title: Text(
                      "Model Number",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      productDetails.modelNumber.isEmpty
                          ? "No model number"
                          : productDetails.modelNumber,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  // Brand
                  ListTile(
                    title: Text(
                      "Brand",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      productDetails.brand.isEmpty
                          ? "No brand"
                          : productDetails.brand,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  // GTIN
                  ListTile(
                    title: Text(
                      productDetails.gtinType.isEmpty
                          ? "No GTIN Type"
                          : productDetails.gtinType,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      productDetails.gtin.isEmpty
                          ? "No GTIN"
                          : productDetails.gtin,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "MPN",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      productDetails.mpn.isEmpty
                          ? "No MPN"
                          : productDetails.mpn,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  // Origin
                  ListTile(
                    title: Text(
                      "Origin",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      productDetails.origin.isEmpty
                          ? "No origin"
                          : productDetails.origin,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  // Manufacturer
                  ListTile(
                    title: Text(
                      "Manufacturer",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      productDetails.manufacturer.name.isEmpty
                          ? "No manufacturer"
                          : productDetails.manufacturer.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            UpdateProductPage(productId: productDetails.id),
                      ));
                    },
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text('update_product'.tr()),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
