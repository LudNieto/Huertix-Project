import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primaryAuthColor = Color(0xFF085430);
final TextStyle titleStyle = TextStyle(
  fontSize: 24.sp,
  fontWeight: FontWeight.bold,
  color: primaryAuthColor,
);

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIconData;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextStyle? style;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;

  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIconData,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.style,
    this.decoration,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      labelText: labelText,
      prefixIcon:
          prefixIconData != null
              ? Icon(prefixIconData, color: primaryAuthColor)
              : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: primaryAuthColor, width: 2.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
    );

    return TextFormField(
      controller: controller,
      decoration: decoration ?? defaultDecoration,
      style: style ?? TextStyle(fontSize: 16.sp),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
