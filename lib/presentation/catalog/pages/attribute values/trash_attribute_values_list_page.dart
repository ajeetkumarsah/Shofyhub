import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/app/catalog/attribute%20values/attribute_values_provider.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/attribute%20values/widgets/trash_attribute_values_tile.dart';
import 'package:alpesportif_seller/presentation/core/widgets/no_item_found_widget.dart';

class TrashAttributeValuesListPage extends HookConsumerWidget {
  final String groupName;
  final int attributeId;
  const TrashAttributeValuesListPage(
      {Key? key, required this.attributeId, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(attributeValuesProvider(attributeId).notifier)
            .getTrashAttributeValues();
      });
      return null;
    }, []);
    final attributeValuesList = ref.watch(attributeValuesProvider(attributeId)
        .select((value) => value.trashAttributeValues));

    final loading = ref.watch(
        attributeValuesProvider(attributeId).select((value) => value.loading));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: Constants.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: Text(groupName),
        elevation: 0,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : attributeValuesList.isEmpty
              ? const NoItemFound()
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .refresh(attributeValuesProvider(attributeId).notifier)
                        .getAttributeValues();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    itemCount: attributeValuesList.length,
                    itemBuilder: (context, index) => InkWell(
                      child: TrashAttributeValuesTile(
                        attributeId: attributeId,
                        atrributeValue: attributeValuesList[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 3.h,
                    ),
                  ),
                ),
    );
  }
}
