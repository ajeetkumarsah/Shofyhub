import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequiredFieldText extends StatelessWidget {
  const RequiredFieldText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'required_fields'.tr(),
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).hintColor,
      ),
    );
  }
}
