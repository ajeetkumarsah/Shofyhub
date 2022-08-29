import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/views/custom/custom_container.dart';

class InformationCardWithIcon extends StatelessWidget {
  final String number;
  final String title;
  final IconData icon;
  final Color iconColor;
  const InformationCardWithIcon({
    Key? key,
    required this.number,
    required this.title,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: defaultPadding / 2),
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: defaultPadding),
          CircleAvatar(
            radius: defaultPadding * 2,
            backgroundColor: iconColor.withOpacity(0.2),
            child: Icon(
              icon,
              color: iconColor,
              size: defaultPadding * 2,
            ),
          ),
        ],
      ),
    );
  }
}
