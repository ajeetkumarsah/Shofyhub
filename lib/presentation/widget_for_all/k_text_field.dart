import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final String lebelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final String? hintText;
  final TextInputAction? inputAction;
  final bool obscureText, numberFormatters, decimalFormatters;

  const KTextField({
    Key? key,
    required this.controller,
    required this.lebelText,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.name,
    this.onTap,
    this.suffixIcon,
    this.numberFormatters = false,
    this.obscureText = false,
    this.hintText,
    this.inputAction,
    this.readOnly = false,
    this.decimalFormatters = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 16),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        labelText: lebelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
      onTap: onTap,
      obscureText: obscureText,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      inputFormatters: [
        if (numberFormatters)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        if (decimalFormatters)
          FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
      ],
    );
  }
}
