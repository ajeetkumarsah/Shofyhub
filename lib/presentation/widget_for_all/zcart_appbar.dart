import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class ZcartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ZcartAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Constants.appbarColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                  constraints:
                      const BoxConstraints(maxHeight: 50, maxWidth: 50),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(left: 10, right: 40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(
                    'assets/zcart_logo/icon.png',
                    fit: BoxFit.contain,
                  )),
            ),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
