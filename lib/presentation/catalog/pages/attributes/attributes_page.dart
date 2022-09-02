import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/atributes/atributes_provider.dart';
import 'package:zcart_seller/application/app/catalog/atributes/get_atributes_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/attribute%20values/attribute_values_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/attritbute_tile.dart';

import 'widgets/add_attributes_page.dart';

class AttributePage extends HookConsumerWidget {
  const AttributePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(atributesProvider.notifier).getAtributes();
        ref.read(getAttributesProvider.notifier).getAttributesTypes();
      });
      return null;
    }, []);
    final attributeList =
        ref.watch(atributesProvider.select((value) => value.atributes));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddAttributesPage(),
              ));
        },
        label: const Text(
          'Add attribute',
        ),
        icon: const Icon(Icons.add),
      ),
      body: attributeList.isEmpty
          ? const Center(
              child: Text('No data available'),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: attributeList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AttributeValuesPage(
                          groupName: attributeList[index].name,
                          attributeId: attributeList[index].id)));
                },
                child: AttributeTile(
                  attribute: attributeList[index],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
    );
  }
}
