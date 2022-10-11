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
  final bool readOnly;
  final String? hintText;

  const KTextField(
      {Key? key,
      required this.controller,
      required this.lebelText,
      this.prefixIcon,
      this.validator,
      this.onTap,
      this.suffixIcon,
      this.numberFormatters = false,
      this.obscureText = false,
      this.hintText,
      this.readOnly = false})
      : super(key: key);
  final bool obscureText, numberFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.bold),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        labelText: lebelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
      onTap: onTap,
      obscureText: obscureText,
      keyboardType:
          numberFormatters ? TextInputType.number : TextInputType.name,
      inputFormatters: [
        if (numberFormatters)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
    );
  }
}
