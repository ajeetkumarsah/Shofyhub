import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: const [
            SizedBox(height: defaultPadding * 2),
            Text(
              'Billing',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
