import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/stock/suppliers/create_supplier_page.dart';
import 'package:zcart_seller/presentation/stock/suppliers/widgets/supplier_list_tile.dart';

import '../../../application/app/stocks/supplier/supplier_provider.dart';

class SupplierListPage extends HookConsumerWidget {
  const SupplierListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(supplierProvider.notifier).getMoreSuppliers();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(supplierProvider.notifier).getAllSuppliers();
      });
      return null;
    }, []);

    final supplierPaginationModel =
        ref.watch(supplierProvider.notifier).supplierPaginationModel;

    final loading =
        ref.watch(supplierProvider.select((value) => value.loading));

    final supplierList = ref.watch(supplierProvider).allSuppliers;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateSupplierPage()));
        },
        label: Text('add_suppliers'.tr()),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                return ref.read(supplierProvider.notifier).getAllSuppliers();
              },
              child: ListView.separated(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: supplierList.length,
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
                  return InkWell(
                    child: SupplierListTile(
                      supplierItem: supplierList[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 3.h,
                ),
              ),
            ),
    );
  }
}
