import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Enum para manejar los estados
enum StatusType { disponible, noDisponible, sinCupos }

class HorizontalCard extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String nombre;
  final int cupos;
  final String tamano;
  final StatusType estado;
  final String ubicacion;
  final String imageRoute;
  final double fontSize;

  const HorizontalCard({
    super.key,
    this.width = 320,
    this.height = 140,
    this.color = const Color(0xFF1E1E1E),
    required this.nombre,
    required this.cupos,
    required this.tamano,
    required this.estado,
    required this.ubicacion,
    required this.imageRoute,
    this.fontSize = 16,
  });

  // Método para obtener el color del estado
  Color _getEstadoColor(BuildContext context) {
    switch (estado) {
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
    switch (estado) {
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Sección de texto
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nombre
                  Text(
                    nombre,
                    style: GoogleFonts.jua(
                      fontSize: fontSize * 1.2,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Detalles
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(Icons.group, '$cupos Cupos'),
                      _buildDetailRow(Icons.aspect_ratio, tamano),
                      _buildDetailRow(Icons.location_on, ubicacion),
                    ],
                  ),

                  // Estado
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getEstadoColor(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getEstadoText(),
                      style: GoogleFonts.jua(
                        fontSize: fontSize * 0.7,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sección de imagen
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                imageRoute,
                fit: BoxFit.cover,
                height: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para construir filas de detalles
  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: fontSize * 0.8, color: Colors.white70),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.jua(
              fontSize: fontSize * 0.7,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
