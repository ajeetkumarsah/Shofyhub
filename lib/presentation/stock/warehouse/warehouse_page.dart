import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/stocks/warehouse/warehouse_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/stock/warehouse/widgets/warehouse_list_tile.dart';

class WarehousePage extends HookConsumerWidget {
  const WarehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(warehouseProvider.notifier).getWarehouseItems();
      });
      return null;
    }, []);
    final warehouseList =
        ref.watch(warehouseProvider.select((value) => value.warehouseItemList));
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => CreateNewCategoryPage(
          //           categorySubgroupId: categorySubGroupId,
          //         )));
        },
        label: const Text('Add category'),
        icon: const Icon(Icons.add),
      ),
      body: warehouseList.isEmpty
          ? Center(
              child: Text(
                'No Category Available',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: warehouseList.length,
              itemBuilder: (context, index) => InkWell(
                child: WarehouseListTile(
                  warehouseItem: warehouseList[index],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
    );
  }
}
