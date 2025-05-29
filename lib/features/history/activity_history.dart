import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/common/widgets/custom_appbar.dart';
import 'package:huertix_project/common/widgets/horizontal_card.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:huertix_project/features/dashboard/presentation/widgets/next_activity_card.dart';

class ActivityHistory extends StatelessWidget {
  const ActivityHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de parcelas simulada
    final List<Map<String, dynamic>> activities = [
      {
        'date': DateTime(2025, 5, 28),
        'plotName': 'Parcela 1',
        'cropType': 'Tomates',
        'activityName': 'Riego',
        'activityTime': '10 AM - 11 AM',
        'activityStatus': ActivityStatus.completada,
        'activityDotColor': Colors.green,
        'location': 'Huerto Urbano',
        'locationDotColor': Colors.blueAccent,
      },
      {
        'date': DateTime(2025, 5, 27),
        'plotName': 'Parcela 2',
        'cropType': 'Lechuga',
        'activityName': 'Fertilización',
        'activityTime': '9 AM - 10 AM',
        'activityStatus': ActivityStatus.completada,
        'activityDotColor': Colors.orange,
        'location': 'Huerto Norte',
        'locationDotColor': Colors.cyan,
      },
      {
        'date': DateTime(2025, 5, 26),
        'plotName': 'Parcela 3',
        'cropType': 'Zanahorias',
        'activityName': 'Cosecha',
        'activityTime': '7 AM - 9 AM',
        'activityStatus': ActivityStatus.pendiente,
        'activityDotColor': Colors.red,
        'location': 'Huerto Sur',
        'locationDotColor': Colors.purple,
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Historial de Actividades', style: titleStyle),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.separated(
                itemCount: activities.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  return NextActivityCard(
                    date: DateTime.now(),
                    plotName: "Parcela 1",
                    cropType: "Tomates",
                    activityName: "Riego",
                    activityTime: "10 AM - 11 AM",
                    activityStatus: ActivityStatus.completada,
                    activityDotColor: Colors.green,
                    location: "Huerto Urbano",
                    locationDotColor: Colors.blueAccent,
                    onPlotTap: () {
                      print("Parcela tocada");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
