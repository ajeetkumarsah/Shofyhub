import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/shop/delivary%20boy/delivary_boy_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/widgets/add_delivary_boy_page.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/widgets/delete_delivary_dialog.dart';

class DelivaryBoyPage extends HookConsumerWidget {
  const DelivaryBoyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(delivaryBoyProvider.notifier).getAllDelivaryBoy();
      });
      return null;
    }, []);
    final delivaryBoyList =
        ref.watch(delivaryBoyProvider.select((value) => value.delivaryBoyList));
    final loading =
        ref.watch(delivaryBoyProvider.select((value) => value.loading));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const AddUpdateDelivaryBoyPage());
        },
        label: const Text('Add new'),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    itemCount: delivaryBoyList.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(delivaryBoyList[index].avatar),
                        ),
                        isThreeLine: true,
                        title: Text(
                          '${delivaryBoyList[index].firstName} ${delivaryBoyList[index].lastName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.sp),
                        ),
                        subtitle: Text(
                            '${delivaryBoyList[index].email}\n${delivaryBoyList[index].phoneNumber}'),
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
                                      builder: (context) =>
                                          AddUpdateDelivaryBoyPage(
                                            delivaryBoyDetails:
                                                delivaryBoyList[index],
                                          )));
                            }
                            if (index2 == 2) {
                              showDialog(
                                  context: context,
                                  builder: (context) => DeleteDelivaryDialog(
                                        delivaryBoyId:
                                            delivaryBoyList[index].id,
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
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3.h,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
