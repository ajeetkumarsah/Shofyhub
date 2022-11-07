import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/category/caegory%20group/category_group_provider.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_group/widget/trash_category_group_tile.dart';
import 'package:zcart_seller/presentation/catalog/pages/category_sub_group/category_sub_group_page.dart';

import 'widget/category_group_tile.dart';

class TrashCategoryGroupPage extends HookConsumerWidget {
  const TrashCategoryGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(categoryGroupProvider.notifier).getTrashCategoryGroup();
      });

      return null;
    }, []);

    final categoryGroupList = ref.watch(categoryGroupProvider);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .refresh(categoryGroupProvider.notifier)
              .getTrashCategoryGroup();
        },
        child: categoryGroupList.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                      itemCount: categoryGroupList.trashCategoryGroups.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CategorySubgroupPage(
                                  groupName: categoryGroupList
                                      .trashCategoryGroups[index].name,
                                  id: categoryGroupList
                                      .trashCategoryGroups[index].id)));
                        },
                        child: TrashCategoryGroupTile(
                          categoryGroup:
                              categoryGroupList.trashCategoryGroups[index],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 3.h,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
