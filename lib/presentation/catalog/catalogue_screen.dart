import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/attributes/attributes_page.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/manufacturer/manufacturer_page.dart';
import 'package:alpesportif_seller/presentation/catalog/pages/product/product_page.dart';

import 'pages/category_group/category_group_home.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: index,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Constants.appbarColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22.r),
            ),
          ),
          title: const Text('Catalog'),
          elevation: 0,
          bottom: TabBar(
              indicatorWeight: 4,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white10),
              tabs: const [
                Tab(
                  text: 'Category\nGroups',
                ),
                Tab(
                  text: 'Attributes',
                ),
                Tab(
                  text: 'Products',
                ),
                Tab(
                  text: 'Manufacturer',
                ),
              ]),
        ),
        body: const TabBarView(children: [
          CategoryGroupHome(),
          AttributePage(),
          ProductPage(),
          ManufacrurerPage(),
        ]),
      ),
    );
  }
}
