import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/domain/app/shop/delivery%20boy/delivary_boy_model.dart';
import 'package:zcart_seller/presentation/core/widgets/info_tile.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/widgets/create_update_delivary_boy_page.dart';
import 'package:zcart_seller/presentation/shop/pages/delivary%20boy/widgets/delete_delivery_boy_dialog.dart';

class DeliveryBoyDetailsPage extends HookConsumerWidget {
  final DelivaryBoyModel deliveryBoyData;
  const DeliveryBoyDetailsPage({Key? key, required this.deliveryBoyData})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${deliveryBoyData.firstName} ${deliveryBoyData.lastName}'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => CreateUpdateDelivaryBoyPage(
                        delivaryBoyDetails: deliveryBoyData,
                      ));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteDeliveryBoyDialog(
                  id: deliveryBoyData.id,
                ),
              );
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: ListView(children: [
        Container(
          height: ScreenUtil().screenHeight * 0.35,
          color: Colors.grey.shade200,
          child: Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(deliveryBoyData.avatar),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        InfoTile(
            title: 'name'.tr(),
            value: '${deliveryBoyData.firstName} ${deliveryBoyData.lastName}'),
        SizedBox(height: 10.h),
        InfoTile(
            title: 'member_since'.tr(), value: deliveryBoyData.memberSince),
        SizedBox(height: 10.h),
        InfoTile(title: 'gender'.tr(), value: deliveryBoyData.sex),
        SizedBox(height: 10.h),
        InfoTile(title: 'date_of_birth'.tr(), value: deliveryBoyData.dob),
        SizedBox(height: 10.h),
        InfoTile(title: 'email'.tr(), value: deliveryBoyData.email),
        SizedBox(height: 10.h),
        InfoTile(
            title: 'status'.tr(),
            value:
                deliveryBoyData.active == 1 ? 'active'.tr() : 'inactive'.tr()),
      ]),
    );
  }
}
