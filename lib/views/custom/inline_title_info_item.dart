import 'package:flutter/material.dart';

class InlineTitleInfoItem extends StatelessWidget {
  final String title;
  final String info;
  const InlineTitleInfoItem({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      text: '$title: ',
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(color: Colors.black54),
      children: [
        TextSpan(
          text: info,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ],
    ));
  }
}
