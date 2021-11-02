import 'package:flutter/material.dart';

class VerificationStatusPage extends StatelessWidget {
  const VerificationStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Status'),
      ),
      body: const Center(
        child: Text('Verification Status'),
      ),
    );
  }
}
