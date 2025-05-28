import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const PrimaryAuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 50.0,
    this.fontSize,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveHeight = height.h;
    final double effectiveFontSize = fontSize ?? 20.sp;
    final BorderRadius effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(10.r);

    return SizedBox(
      width: width,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: Text(
          text,
          style:
              textStyle ??
              TextStyle(fontSize: effectiveFontSize, color: textColor),
        ),
      ),
    );
  }
}
