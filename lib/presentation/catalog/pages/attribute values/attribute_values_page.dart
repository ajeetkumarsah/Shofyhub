import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/attribute%20values/attribute_values_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/attribute%20values/widgets/add_update_attribute_values_dialog.dart';
import 'package:zcart_seller/presentation/catalog/pages/attribute%20values/widgets/attribute_values_tile.dart';

class AttributeValuesPage extends HookConsumerWidget {
  final String groupName;
  final int attributeId;
  const AttributeValuesPage(
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
              builder: (context) => AddUpdateAttributeValuesDialog(
                    attributeId: attributeId,
                  ));
        },
        label: const Text(
          'Add attribute value',
        ),
        icon: const Icon(Icons.add),
      ),
      body: attributeValuesList.isEmpty
          ? const Center(
              child: Text('No data available'),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: attributeValuesList.length,
              itemBuilder: (context, index) => InkWell(
                child: AttributeValuesTile(
                  attributeId: attributeId,
                  atrributeValue: attributeValuesList[index],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
    );
  }
}
