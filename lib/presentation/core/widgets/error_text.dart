import 'package:flutter/material.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'No tax found. Please add a Tax',
          style: TextStyle(color: Constants.kRedColor),
        ),
      ),
    );
  }
}
