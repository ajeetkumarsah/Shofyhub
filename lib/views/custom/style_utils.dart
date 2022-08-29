import 'package:flutter/material.dart';
import 'package:zcart_vendor/helper/constants.dart';

InputDecoration textFieldDecoration(
        {required String label, required String hint, IconData? prefixIcon}) =>
    InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
      contentPadding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
    );
