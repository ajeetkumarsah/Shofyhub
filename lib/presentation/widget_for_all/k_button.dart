import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class KButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final Color color;
  const KButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.color = Constants.appbarColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 45.h,
        child: child,
      ),
    );
  }
}
