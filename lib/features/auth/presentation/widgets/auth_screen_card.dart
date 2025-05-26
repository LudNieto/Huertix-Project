import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreenCard extends StatelessWidget {
  final String backgroundImagePath;
  final Widget cardChild;
  final double cardWidthFactor;
  final EdgeInsets? cardPadding;
  final Color cardBackgroundColor;
  final BorderRadius? cardBorderRadius;

  const AuthScreenCard.AuthScreenCard({
    super.key,
    required this.backgroundImagePath,
    required this.cardChild,
    this.cardWidthFactor = 0.9,
    this.cardPadding,
    this.cardBackgroundColor = const Color(0xC1EBEFEE),
    this.cardBorderRadius,
  }) : assert(
          cardWidthFactor > 0.0 && cardWidthFactor <= 1.0,
          'El factor de ancho debe estar entre 0.0 y 1.0',
        );

  @override
  Widget build(BuildContext context) {
    final effectiveCardPadding = cardPadding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h);
    final effectiveBorderRadius = cardBorderRadius ?? BorderRadius.circular(20.r);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[300]);
              },
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Card(
                margin: EdgeInsets.zero,
                color: cardBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: effectiveBorderRadius,
                ),
                elevation: 8.0,
                shadowColor: Colors.black.withOpacity(0.2),
                child: Container(
                  width: ScreenUtil().screenWidth * cardWidthFactor,
                  padding: effectiveCardPadding,
                  child: cardChild,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}