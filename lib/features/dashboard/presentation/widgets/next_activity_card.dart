import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:intl/intl.dart';

enum ActivityStatus { pendiente, sinResponsable, completada }

class NextActivityCard extends StatelessWidget {
  final DateTime date;
  final String plotName;
  final String cropType;
  final String activityName;
  final String activityTime;
  final Color activityDotColor;
  final String location;
  final Color locationDotColor;
  final ActivityStatus activityStatus;
  final VoidCallback? onPlotTap;

  const NextActivityCard({
    super.key,
    required this.date,
    required this.plotName,
    required this.cropType,
    required this.activityName,
    required this.activityTime,
    required this.activityStatus,
    this.activityDotColor = const Color(0xFFE53935), // Rojo por defecto
    required this.location,
    this.locationDotColor = const Color(0xFF43A047), // Verde por defecto
    this.onPlotTap,
  });

  Color _getActivityStatusColor() {
    switch (activityStatus) {
      case ActivityStatus.pendiente:
        return Colors.orange;
      case ActivityStatus.sinResponsable:
        return Colors.red;
      case ActivityStatus.completada:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getActivityStatusText() {
    switch (activityStatus) {
      case ActivityStatus.pendiente:
        return 'Pendiente';
      case ActivityStatus.sinResponsable:
        return 'Sin Responsable';
      case ActivityStatus.completada:
        return 'Completada';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String weekday =
        DateFormat('EEEE', 'es_ES').format(date).toUpperCase();
    final String day = DateFormat('d').format(date);
    final String month = DateFormat('MMMM', 'es_ES').format(date).toUpperCase();

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              color: primaryAuthColor.withOpacity(0.3),
              child: InkWell(
                onTap: onPlotTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "$plotName - $cropType",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (onPlotTap != null)
                        Icon(
                          Icons.grass_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekday,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          day,
                          style: TextStyle(
                            color: primaryAuthColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 36.sp,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          month,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getActivityStatusColor().withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            _getActivityStatusText(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: _getActivityStatusColor(),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.w),
                        _buildDetailItem(
                          dotColor: activityDotColor,
                          title: activityName,
                          subtitle: activityTime,
                        ),
                        SizedBox(height: 12.h),
                        _buildDetailItem(
                          dotColor: locationDotColor,
                          title: location,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required Color dotColor,
    required String title,
    String? subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Container(
            width: 9.w,
            height: 9.w,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
              ),
              if (subtitle != null && subtitle.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    subtitle,
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
