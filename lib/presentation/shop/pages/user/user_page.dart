import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/shop/pages/user/widget/shop_user_tile.dart';

class UserPage extends HookConsumerWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.green[100],
                  ),
                  onPressed: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) =>);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.green[700],
                  ),
                  label: Text('Add Shop User',
                      style: TextStyle(color: Colors.green[700]))),
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 4,
              itemBuilder: (context, index) => const ShopUserTile(),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
