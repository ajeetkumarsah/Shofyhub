import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KMultiLineTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final String lebelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextEditingController controller;
  final bool readOnly;
  final int? maxLines;

  const KMultiLineTextField({
    Key? key,
    required this.controller,
    required this.lebelText,
    this.prefixIcon,
    this.validator,
    this.onTap,
    this.suffixIcon,
    this.readOnly = false,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 16),
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: lebelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        suffixIcon: suffixIcon,
      ),
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
    );
  }
}
