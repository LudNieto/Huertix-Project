import 'package:flutter/material.dart';

class OverlayColumnScaffold extends StatelessWidget {
  final double topColumnHeightFactor;
  final List<Widget> topColumnChildren;
  final List<Widget> bottomColumnChildren;
  final BorderRadiusGeometry? bottomColumnBorderRadius;
  final Color bottomColumnColor;

  final String? topBackgroundImage;
  final Color? topBackgroundColor;
  final String? topBackgroundText;
  final TextStyle? topBackgroundTextStyle;
  final BoxFit? backgroundImageFit;

  const OverlayColumnScaffold({
    super.key,
    required this.topColumnHeightFactor,
    required this.topColumnChildren,
    required this.bottomColumnChildren,
    this.bottomColumnBorderRadius,
    this.bottomColumnColor = Colors.white,
    this.topBackgroundImage,
    this.topBackgroundColor,
    this.topBackgroundText,
    this.topBackgroundTextStyle,
    this.backgroundImageFit = BoxFit.cover,
  })  : assert(topColumnHeightFactor >= 0.0 && topColumnHeightFactor <= 1.0,
            'El factor de altura debe estar entre 0.0 y 1.0'),
        assert(topBackgroundImage == null || topBackgroundColor == null,
            'No se puede especificar imagen y color de fondo simultáneamente');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height * topColumnHeightFactor,
            width: double.infinity,
            child: _buildTopBackground(),
          ),

          SizedBox(
            height: size.height * topColumnHeightFactor,
            child: Column(
              children: topColumnChildren,
            ),
          ),

          // Columna inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * (1.0 - topColumnHeightFactor),
              decoration: BoxDecoration(
                color: bottomColumnColor,
                borderRadius: bottomColumnBorderRadius ??
                    const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
              ),
              child: Column(
                children: bottomColumnChildren,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBackground() {
    if (topBackgroundImage != null) {
      return Image.asset(
        topBackgroundImage!,
        fit: backgroundImageFit,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (topBackgroundColor != null) {
      return Container(color: topBackgroundColor);
    } else if (topBackgroundText != null) {
      return Container(
        color: Colors.blue, // Color por defecto si no se especifica
        alignment: Alignment.center,
        child: Text(
          topBackgroundText!,
          style: topBackgroundTextStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    } else {
      return Container(color: Colors.blue); // Color por defecto
    }
  }
}
