import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/attribute%20values/attribute_values_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/attribute%20values/widgets/create_update_attribute_values_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/attribute%20values/widgets/attribute_values_tile.dart';

class AttributeValuesListPage extends HookConsumerWidget {
  final String groupName;
  final int attributeId;
  const AttributeValuesListPage(
      {Key? key, required this.attributeId, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref
            .read(attributeValuesProvider(attributeId).notifier)
            .getAttributeValues();
      });
      return null;
    }, []);
    final attributeValuesList = ref.watch(attributeValuesProvider(attributeId)
        .select((value) => value.attributeValues));

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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => CreateUpdateAttributeValuesDialog(
                    attributeId: attributeId,
                  ));
        },
        label: Text(
          'add_attribute_value'.tr(),
        ),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : attributeValuesList.isEmpty
              ? Center(
                  child: Text(
                    'no_item_available'.tr(),
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                )
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
                      child: AttributeValuesTile(
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
