import 'package:flutter/material.dart';

class AuthScreenWithCard extends StatelessWidget {
  final String backgroundImagePath;
  final Widget cardChild;
  final double cardWidthFactor;
  final EdgeInsets? cardPadding;
  final Color cardColor;
  final BorderRadius? cardBorderRadius;
  final List<BoxShadow>? cardShadow;

  const AuthScreenWithCard({
    super.key,
    required this.backgroundImagePath,
    required this.cardChild,
    this.cardWidthFactor = 0.9,
    this.cardPadding,
    this.cardColor = Colors.white,
    this.cardBorderRadius,
    this.cardShadow,
  }) : assert(cardWidthFactor > 0.0 && cardWidthFactor <= 1.0,
            'El factor de ancho debe estar entre 0.0 y 1.0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Fondo de imagen
          Positioned.fill(
            child: Image.asset(
              backgroundImagePath,
              fit: BoxFit.cover,
            ),
          ),

          // Capa semitransparente para mejorar legibilidad
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          // Contenido principal
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: cardBorderRadius ?? BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: Container(
                    width: MediaQuery.of(context).size.width * cardWidthFactor,
                    padding: cardPadding ?? const EdgeInsets.all(24.0),
                    child: cardChild,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
