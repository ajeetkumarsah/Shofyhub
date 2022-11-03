import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/manufacturer/manufacturer_provider.dart';
import 'package:zcart_seller/application/app/form/country_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/create_manufactuerer_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/manufacturer/widgets/manufacturer_list_tile.dart';

class ManufacturerListPage extends HookConsumerWidget {
  const ManufacturerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(manufacturerProvider.notifier).getMoreManufacturerList();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(manufacturerProvider.notifier).getManufacturerList();
        ref.read(countryProvider.notifier).loadData();
      });
      return null;
    }, []);
    final loading =
        ref.watch(manufacturerProvider.select((value) => value.loading));
    final manufacturerList = ref
        .watch(manufacturerProvider.select((value) => value.manufacturerList));

    final manufacturerPaginationModel =
        ref.watch(manufacturerProvider.notifier).manufacturerPaginationModel;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateManufactuererPage()));
        },
        label: Text('add_new'.tr()),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return ref
                          .refresh(manufacturerProvider.notifier)
                          .getManufacturerList();
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                      physics: const BouncingScrollPhysics(),
                      itemCount: manufacturerList.length,
                      itemBuilder: (context, index) {
                        if ((index == manufacturerList.length - 1) &&
                            manufacturerList.length <
                                manufacturerPaginationModel.meta.total!) {
                          return const SizedBox(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return ManufacturerListTile(
                          manufacturer: manufacturerList[index],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
