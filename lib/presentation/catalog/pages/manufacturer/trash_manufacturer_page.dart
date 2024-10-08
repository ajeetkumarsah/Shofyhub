import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/catalog/manufacturer/manufacturer_provider.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/manufacturer/widgets/trash_manufacturer_list_tile.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';

class TrashManufacturerPage extends HookConsumerWidget {
  const TrashManufacturerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref
                .read(manufacturerProvider.notifier)
                .getMoreTrashManufacturerList();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(manufacturerProvider.notifier).getTrashManufacturerList();
      });
      return null;
    }, []);
    final loading =
        ref.watch(manufacturerProvider.select((value) => value.loading));

    final manufacturerList =
        ref.watch(manufacturerProvider).trashManufacturerList;

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
                            .read(manufacturerProvider.notifier)
                            .getTrashManufacturerList();
                      },
                      child: manufacturerList.isEmpty
                          ? const NoItemFound()
                          : ListView.separated(
                              controller: scrollController,
                              itemCount: manufacturerList.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                // if ((index == manufacturerList.length - 1) &&
                                //     manufacturerList.length <
                                //         manufacturerPaginationModel
                                //             .meta.total!) {
                                //   return const SizedBox(
                                //     height: 100,
                                //     child: Center(
                                //       child: CircularProgressIndicator(),
                                //     ),
                                //   );
                                // }
                                return TrashManufacturerListTile(
                                  manufacturer: manufacturerList[index],
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
