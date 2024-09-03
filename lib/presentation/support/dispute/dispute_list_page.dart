import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/order%20management/dispute/dispute_provider.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';
import 'package:alpesportif_seller/presentation/support/dispute/dispute_list_tile.dart';

class DisputeListPage extends HookConsumerWidget {
  const DisputeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(
        () {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            ref.read(disputeProvider.notifier).getMoreDisputes();
          }
        },
      );
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(disputeProvider.notifier).getDisputes();
      });
      return null;
    }, []);

    final disputePaginationModel =
        ref.watch(disputeProvider.notifier).disputePaginationModel;

    final disputeList =
        ref.watch(disputeProvider.select((value) => value.allDisputes));

    final loading = ref.watch(disputeProvider.select((value) => value.loading));

    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : disputeList.isEmpty
              ? const NoItemFound()
              : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () {
                          return ref
                              .read(disputeProvider.notifier)
                              .getDisputes();
                        },
                        child: ListView.separated(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemCount: disputeList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            if ((index == disputeList.length - 1) &&
                                disputeList.length <
                                    disputePaginationModel.meta.total!) {
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return DisputeListTile(dispute: disputeList[index]);
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
