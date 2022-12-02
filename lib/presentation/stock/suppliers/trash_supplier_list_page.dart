import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/supplier/supplier_provider.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:zcart_seller/presentation/stock/suppliers/widgets/trash_supplier_list_tile.dart';

class TrashSupplierPage extends HookConsumerWidget {
  const TrashSupplierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(supplierProvider.notifier).getMoreTrashSuppliers();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(supplierProvider.notifier).getTrashSuppliers();
      });
      return null;
    }, []);
    final loading =
        ref.watch(supplierProvider.select((value) => value.loading));

    final supplierPaginationModel =
        ref.watch(supplierProvider.notifier).supplierPaginationModel;

    final supplierList = ref.watch(supplierProvider).trashSupplier;

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
                            .read(supplierProvider.notifier)
                            .getTrashSuppliers();
                      },
                      child: supplierList.isEmpty
                          ? const NoItemFound()
                          : ListView.separated(
                              controller: scrollController,
                              itemCount: supplierList.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if ((index == supplierList.length - 1) &&
                                    supplierList.length <
                                        supplierPaginationModel.meta.total!) {
                                  return const SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return TrashSupplierListTile(
                                  supplierItem: supplierList[index],
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
