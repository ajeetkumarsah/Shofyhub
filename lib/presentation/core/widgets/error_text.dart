import 'package:flutter/material.dart';
import 'package:alpesportif_seller/infrastructure/app/constants.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: Constants.kRedColor),
        ),
      ),
    );
  }
}
