import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/application/app/catalog/atributes/atributes_provider.dart';
import 'package:zcart_seller/application/app/catalog/atributes/get_atributes_provider.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/catalog/pages/attribute%20values/attribute_values_page.dart';
import 'package:zcart_seller/presentation/catalog/pages/attributes/widgets/attritbute_tile.dart';
import 'package:zcart_seller/presentation/core/widgets/no_item_found_widget.dart';

import 'widgets/create_attributes_page.dart';

class AttributeListPage extends HookConsumerWidget {
  const AttributeListPage({
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
    final loading =
        ref.watch(atributesProvider.select((value) => value.loading));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Constants.buttonColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateAttributesPage(),
              ));
        },
        label: Text(
          'add_attribute'.tr(),
        ),
        icon: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : attributeList.isEmpty
              ? const NoItemFound()
              : RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .refresh(atributesProvider.notifier)
                        .getAtributes();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                    itemCount: attributeList.length,
                    physics: const BouncingScrollPhysics(),
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
                      height: 3.h,
                    ),
                  ),
                ),
    );
  }
}
