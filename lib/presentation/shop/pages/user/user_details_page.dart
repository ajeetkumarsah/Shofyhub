import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alpesportif_seller/domain/app/shop/user/get_shop_users_model.dart';
import 'package:alpesportif_seller/presentation/core/widgets/info_tile.dart';
import 'package:alpesportif_seller/presentation/shop/pages/user/widget/edit_shop_user.dart';

class UserDetailsPage extends HookConsumerWidget {
  final ShopUsersModel userData;
  const UserDetailsPage({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userData.name),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => EditShopUser(
                    userData: userData,
                  ),
                );
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: ListView(children: [
        Container(
          height: ScreenUtil().screenHeight * 0.35,
          color: Colors.grey.shade200,
          child: Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(userData.avatar),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        InfoTile(title: 'name'.tr(), value: userData.name),
        SizedBox(height: 10.h),
        InfoTile(title: 'member_since'.tr(), value: userData.memberSince),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'description'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                userData.description,
              ),
              SizedBox(width: 20.h),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        InfoTile(title: 'email'.tr(), value: userData.email),
        SizedBox(height: 10.h),
        InfoTile(
            title: 'status'.tr(),
            value: userData.active == true ? 'active'.tr() : 'inactive'.tr()),
      ]),
    );
  }
}
