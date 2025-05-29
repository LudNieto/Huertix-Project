import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huertix_project/common/widgets/custom_appbar.dart';
import 'package:huertix_project/common/widgets/custom_drawer.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:huertix_project/features/dashboard/presentation/widgets/event_card.dart';
import 'package:huertix_project/features/dashboard/presentation/widgets/next_activity_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/features/dashboard/presentation/widgets/dashboard_button.dart';

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
              style: titleStyle,
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
            Text("DashBoard", textAlign: TextAlign.start, style: titleStyle),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DashboardButton(
                  icon: Icons.person,
                  label: 'Mis Perfil',
                  onPressed: () => context.goNamed('profile'),
                ),
                DashboardButton(
                  icon: Icons.history,
                  label: 'Historial',
                  onPressed: () => context.goNamed('fieldsHistory'),
                ),
                DashboardButton(
                  icon: Icons.search,
                  label: 'Explorar',
                  onPressed: () => context.goNamed('login'),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text('Eventos:', style: titleStyle),
            EventsListView(),
          ],
        ),
      ),
    );
  }
}

// Modelo de datos para un evento
typedef Event = Map<String, dynamic>;

class EventsListView extends StatelessWidget {
  const EventsListView({Key? key}) : super(key: key);

  // Lista dinámica de eventos
  final List<Event> events = const [
    {
      'imageUrl':
          'https://www.lifeisagarden.co.za/wp-content/uploads/2021/10/Life_is_a_garden_plant_cover-633x426.jpg',
      'title': 'Día de la Tierra',
      'dateTimeString': '22 de abril, 10:00 AM - 4:00 PM',
      'locationAddress': 'Parque Alegra',
      'buttonText': 'Más Información',
    },
    {
      'imageUrl':
          'https://www.lifeisagarden.co.za/wp-content/uploads/2025/01/Life-is-a-garden-Trend-wrap-up-The-best-of-2024-gardening-ideas-and-whats-next-02.jpg',
      'title': 'Cómo cuidar tus Dahlias durante el verano',
      'dateTimeString': '15 de abril, 1:00 PM - 4:00 PM',
      'locationAddress': 'Buena Vista',
      'buttonText': 'Más Información',
    },
    {
      'imageUrl':
          'https://www.lifeisagarden.co.za/wp-content/uploads/2024/10/Life-is-a-Garden-Your-home-is-begging-for-these-patio-plants-08.jpg',
      'title': '¿Por qué es importante tener plantas en casa?',
      'dateTimeString': '30 de Mayo, 2:00 PM - 6:00 PM',
      'locationAddress': 'Buena Vista',
      'buttonText': 'Más Información',
    },
    {
      'imageUrl':
          'https://www.lifeisagarden.co.za/wp-content/uploads/2025/03/Life-is-a-Garden-What-your-plants-wish-they-could-tell-you-about-pruning-04.jpg',
      'title': '10 Tips Rápidos Para Podar Tus Flores',
      'dateTimeString': '15 de abril, 1:00 PM - 3:00 PM',
      'locationAddress': 'Portal del Prado',
      'buttonText': 'Más Información',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SizedBox(
              width: 300.w, // Ajusta el ancho según tus necesidades
              child: EventCard(
                imageUrl: event['imageUrl'],
                title: event['title'],
                dateTimeString: event['dateTimeString'],
                locationAddress: event['locationAddress'],
                buttonText: event['buttonText'],
                cardHeight: 220.h,
                onButtonPressed: () {
                  // Acción específica para este evento
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
