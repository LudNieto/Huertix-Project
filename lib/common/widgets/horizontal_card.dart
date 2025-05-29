import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';

// Enum para manejar los estados
enum StatusType { disponible, noDisponible, sinCupos, terminada, enProceso }

class HorizontalCard extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String name;
  final String type;
  final int cupos;
  final String size;
  final StatusType state;
  final String location;
  final double fontSize;
  final String? buttonText;
  final VoidCallback? onPressed;

  const HorizontalCard({
    super.key,
    this.width = 320,
    this.height = 140,
    this.color = Colors.grey,
    required this.name,
    required this.type,
    required this.cupos,
    required this.size,
    required this.state,
    required this.location,
    this.fontSize = 16.2,
    this.buttonText,
    this.onPressed,
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
      case StatusType.terminada:
        return Color(0xF666AD5D);
      case StatusType.enProceso:
        return Color(0xC055B0CC);
      default:
        return Colors.grey;
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
      case StatusType.terminada:
        return 'Terminada';
      case StatusType.enProceso:
        return 'En Proceso';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color estadoColor = _getEstadoColor(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: color.withOpacity(0.5), // Aquí pones el color del borde
          width: 1.0, // Grosor del borde en píxeles
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8.w,
                  children: [
                    Text(
                      '$name •',
                      style: TextStyle(
                        fontSize: fontSize,
                        color: estadoColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: estadoColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        _getEstadoText(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: estadoColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: estadoColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  '$cupos cupos',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black12.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.straighten, color: estadoColor),
                    Text(
                      size,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black12.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_city, color: estadoColor),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black12.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (buttonText != null && onPressed != null)
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.add,
                      color: primaryAuthColor.withOpacity(0.9),
                    ),
                    tooltip: buttonText,
                  ),
                Row(
                  children: [
                    Icon(Icons.grass, size: 20.w, color: estadoColor),
                    Icon(Icons.agriculture, size: 80.w, color: estadoColor),
                    Icon(Icons.grass, size: 20.w, color: estadoColor),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
