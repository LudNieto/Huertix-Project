import 'package:flutter/material.dart';
import 'package:huertix_project/common/widgets/custom_appbar.dart';
import 'package:huertix_project/common/widgets/custom_drawer.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/dashboard/presentation/widgets/event_card.dart';
import 'package:huertix_project/features/dashboard/presentation/widgets/next_activity_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final UserEntity? user = authProvider.user;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Próxima Actividad",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            NextActivityCard(
              date: DateTime.now(),
              plotName: "Parcela 1",
              cropType: "Tomates",
              activityName: "Riego",
              activityTime: "10 AM - 11 AM",
              activityDotColor: Colors.green,
              location: "Huerto Urbano",
              locationDotColor: Colors.blueAccent,
              onPlotTap: () {
                print("Parcela tocada");
              },
            ),
            SizedBox(height: 16.h),
            Text('Eventos:',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            EventCard(imageUrl: "https://www.lifeisagarden.co.za/wp-content/uploads/2021/10/Life_is_a_garden_plant_cover-633x426.jpg", 
            title: "Día de la Tierra",
            dateTimeString: "22 de abril, 10:00 AM - 4:00 PM",
            locationAddress: "Parque Alegra",
            buttonText: "Más Información",
            cardHeight: 220.h,
            onButtonPressed: () {}),

          ],
        ),
      ),
    );
  }
}