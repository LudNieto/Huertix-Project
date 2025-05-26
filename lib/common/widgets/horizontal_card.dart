import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Enum para manejar los estados
enum StatusType { disponible, noDisponible, sinCupos }

class HorizontalCard extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String name;
  final int cupos;
  final String size;
  final StatusType state;
  final String location;
  final String imageRoute;
  final double fontSize;

  const HorizontalCard({
    super.key,
    this.width = 320,
    this.height = 140,
    this.color = const Color(0xFF1E1E1E),
    required this.name,
    required this.cupos,
    required this.size,
    required this.state,
    required this.location,
    required this.imageRoute,
    this.fontSize = 16.2,
  });

  // Método para obtener el color del estado
  Color _getEstadoColor(BuildContext context) {
    switch (state) {
      case StatusType.disponible:
        return Colors.green;
      case StatusType.noDisponible:
        return Colors.red;
      case StatusType.sinCupos:
        return Colors.orange;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  // Método para obtener el texto del estado
  String _getEstadoText() {
    switch (state) {
      case StatusType.disponible:
        return 'Disponible';
      case StatusType.noDisponible:
        return 'No Disponible';
      case StatusType.sinCupos:
        return 'Sin Cupos';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: GoogleFonts.jua(fontSize: fontSize, color: Colors.white),
              ),

              SizedBox(height: height * 0.15),

              Text(
                location,
                style: GoogleFonts.jua(
                  fontSize: fontSize * 0.66,
                  color: Colors.white,
                ),
              ),

              Text(
                '$cupos cupos',
                style: GoogleFonts.jua(
                  fontSize: fontSize * 0.66,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(width: width * 0.5, child: Image.asset(imageRoute)),
            ],
          ),
        ],
      ),
    );
  }
}
