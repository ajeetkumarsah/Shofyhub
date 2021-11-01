import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';

class SupportDeskPage extends StatelessWidget {
  const SupportDeskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Desk'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}
