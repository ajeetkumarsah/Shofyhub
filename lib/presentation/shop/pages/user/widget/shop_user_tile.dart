import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/presentation/shop/pages/user/widget/delete_shop_user.dart';
import 'package:zcart_seller/presentation/shop/pages/user/widget/edit_shop_user.dart';

class ShopUserTile extends StatelessWidget {
  // final CreateShopUserModel createShopUser;

  const ShopUserTile({
    Key? key,
    // required this.createShopUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        'createShopUser.name',
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
      ),
      // trailing: IconButton(
      //   onPressed: onPressed,
      //   icon: const Icon(Icons.create),
      // ),
      subtitle: Text(
        'Shop Id: ',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      trailing: PopupMenuButton(
        tooltip: '',
        padding: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
        icon: const Icon(Icons.more_horiz),
        onSelected: (index) {
          if (index == 1) {
            showDialog(
                context: context, builder: (context) => const EditShopUser());
          }
          if (index == 2) {
            showDialog(
                context: context, builder: (context) => const DeleteShopUser());
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 1,
            child: Text("Edit"),
          ),
          const PopupMenuItem(
            value: 2,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
