import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/product/product_provider.dart';
import 'package:zcart_seller/presentation/catalog/pages/product/trash_product_list_tile.dart';

class TrashProductPage extends HookConsumerWidget {
  const TrashProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // final scrollController = useScrollController();

    useEffect(() {
      // scrollController.addListener(
      //   () {
      //     if (scrollController.position.pixels ==
      //         scrollController.position.maxScrollExtent) {
      //       ref.read(productProvider.notifier).getMoreTrashProducts();
      //     }
      //   },
      // );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(productProvider.notifier).getTrashProducts();
      });
      return null;
    }, []);
    final loading = ref.watch(productProvider.select((value) => value.loading));

    // final productPaginationModel =
    //     ref.watch(productProvider.notifier).productPaginationModel;

    final productList = ref.watch(productProvider).trashProductList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        return ref
                            .read(productProvider.notifier)
                            .getTrashProducts();
                      },
                      child: productList.isEmpty
                          ? Center(child: Text('no_item_found'.tr()))
                          : ListView.separated(
                              // controller: scrollController,
                              itemCount: productList.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                // if ((index == productList.length - 1) &&
                                //     productList.length <
                                //         productPaginationModel.meta.total!) {
                                //   return const SizedBox(
                                //     height: 100,
                                //     child: Center(
                                //       child: CircularProgressIndicator(),
                                //     ),
                                //   );
                                // }
                                return TrashProductTile(
                                  product: productList[index],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 3.h),
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
