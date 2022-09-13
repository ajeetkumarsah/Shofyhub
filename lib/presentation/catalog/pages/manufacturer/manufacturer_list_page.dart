import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_provider.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/create_manufactuerer_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/delete_manufacturer_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/edit_manufactuer_page.dart';

class ManufacturerListPage extends HookConsumerWidget {
  const ManufacturerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(manufacturerProvider.notifier).getManufacturerList();
        ref.read(countryProvider.notifier).loadData();
      });
      return null;
    }, []);
    final manufacturerList = ref
        .watch(manufacturerProvider.select((value) => value.manufacturerList));
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateManufactuererPage()));
        },
        label: const Text('Add new'),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 50.h),
              itemCount: manufacturerList.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(manufacturerList[index].image),
                ),
                isThreeLine: true,
                title: Text(
                  manufacturerList[index].name,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ),
                subtitle:
                    Text('available: ${manufacturerList[index].availableFrom}'),
                trailing: PopupMenuButton(
                  tooltip: '',
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp)),
                  icon: const Icon(Icons.more_horiz),
                  onSelected: (index2) {
                    if (index2 == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditManufactuererPage(
                                  manufacturerId: manufacturerList[index].id)));
                    }
                    if (index2 == 2) {
                      showDialog(
                          context: context,
                          builder: (context) => DeleteManufactuerDialog(
                              manufactuerId: manufacturerList[index].id));
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
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 5.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
