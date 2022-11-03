import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/order%20management/cancellation/cancellation_provider.dart';
import 'package:zcart_seller/presentation/support/cancellation/cancellation_list_tile.dart';

class CancellationListPage extends HookConsumerWidget {
  const CancellationListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(cancellationProvider.notifier).getMorecancellation();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(cancellationProvider.notifier).getCancellations();
      });
      return null;
    }, []);

    final cancellationPaginationModel =
        ref.watch(cancellationProvider.notifier).cancellationPaginationModel;

    final cancellationList = ref
        .watch(cancellationProvider.select((value) => value.allCancellations));

    final loading =
        ref.watch(cancellationProvider.select((value) => value.loading));

    return Scaffold(
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
                          .read(cancellationProvider.notifier)
                          .getCancellations();
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      itemCount: cancellationList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if ((index == cancellationList.length - 1) &&
                            cancellationList.length <
                                cancellationPaginationModel.meta.total!) {
                          return const SizedBox(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return CancellationListTile(
                            cancellation: cancellationList[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
