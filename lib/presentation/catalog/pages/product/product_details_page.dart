import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/product/detail_product/detail_product_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

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
              child: Column(
                children: [
                  productDetails.images.isEmpty
                      ? Container()
                      : SizedBox(
                          height: ScreenUtil().screenHeight * 0.35,
                          child: Column(
                            children: [
                              Expanded(
                                child: CarouselSlider(
                                  items: productDetails.images
                                      .map((image) => SizedBox(
                                            width: ScreenUtil().screenWidth,
                                            height: ScreenUtil().screenHeight *
                                                0.35,
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
                              // productDetails.images.isNotEmpty
                              //     ? Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: reviewDetailsNotifier.reviewData!.gallery!
                              //             .asMap()
                              //             .entries
                              //             .map(
                              //           (entry) {
                              //             return GestureDetector(
                              //               onTap: () => reviewDetailsNotifier.controller
                              //                   .animateToPage(entry.key),
                              //               child: Container(
                              //                 width: 5.0,
                              //                 height: 5.0,
                              //                 margin: EdgeInsets.symmetric(
                              //                     vertical: 8.0, horizontal: 4.0),
                              //                 decoration: BoxDecoration(
                              //                   shape: BoxShape.circle,
                              //                   color: Theme.of(context).brightness ==
                              //                           Brightness.dark
                              //                       ? Colors.white
                              //                       : Colors.black.withOpacity(
                              //                           reviewDetailsNotifier.current ==
                              //                                   entry.key
                              //                               ? 0.9
                              //                               : 0.4,
                              //                         ),
                              //                 ),
                              //               ),
                              //             );
                              //           },
                              //         ).toList(),
                              //       )
                              //     : Container(),
                            ],
                          ),
                        ),
                  ListTile(
                    title: Text(
                      productDetails.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: HtmlWidget(productDetails.description),
                  )),
                ],
              ),
            ),
    );
  }
}
