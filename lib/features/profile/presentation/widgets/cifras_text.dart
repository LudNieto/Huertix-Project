import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';

class CifrasText extends StatelessWidget {
  final double hours;
  final double endedFields;
  final double endedActs;
  final double spacing;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;
  final List<String> availableDays;

  const CifrasText({
    super.key,
    required this.endedFields,
    required this.endedActs,
    required this.hours,
    required this.availableDays,
    this.spacing = 8,
    this.textStyle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: spacing,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$hours h',
                  style:
                      textStyle ??
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Horas de\nServicio',
                  style:
                      titleStyle ??
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              spacing: spacing,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$endedFields',
                  style:
                      textStyle ??
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'parcelas\nterminadas',
                  style:
                      titleStyle ??
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              spacing: spacing,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$endedActs',
                  style:
                      textStyle ??
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Actividades\nCompletadas',
                  style:
                      titleStyle ??
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.sp),
        Text(
          'Días Disponibles',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: primaryAuthColor,
          ),
        ),
        SizedBox(height: spacing),
        Wrap(
          spacing: spacing / 2,
          runSpacing: spacing / 2,
          children:
              availableDays.map((day) {
                return Chip(
                  label: Text(day),
                  labelStyle: const TextStyle(color: Colors.green),
                  backgroundColor: Colors.green.withOpacity(0.2),
                  side: BorderSide(color: Colors.green, width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 2.h,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
