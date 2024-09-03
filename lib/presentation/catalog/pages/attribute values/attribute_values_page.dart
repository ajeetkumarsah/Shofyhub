import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/application/core/utility.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/attribute%20values/attribute_values_list_page.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/attribute%20values/trash_attribute_values_list_page.dart';

class AttributeValuesPage extends HookConsumerWidget {
  final String groupName;
  final int attributeId;
  const AttributeValuesPage(
      {Key? key, required this.attributeId, required this.groupName})
      : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      AttributeValueUtility.index.value = 0;
      return null;
    }, []);

    var screens = [
      AttributeValuesListPage(attributeId: attributeId, groupName: groupName),
      TrashAttributeValuesListPage(
          attributeId: attributeId, groupName: groupName),
    ];

    return ValueListenableBuilder(
        valueListenable: AttributeValueUtility.index,
        builder: (context, value, child) {
          return Scaffold(
            body: IndexedStack(
              index: AttributeValueUtility.index.value,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Constants.appbarColor,
                unselectedItemColor: Colors.grey,
                selectedFontSize: 12,
                currentIndex: AttributeValueUtility.index.value,
                onTap: (value) {
                  AttributeValueUtility.index.value = value;
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.list),
                      label: 'attribute_values'.tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.delete), label: 'trash'.tr()),
                ]),
          );
        });
  }
}
