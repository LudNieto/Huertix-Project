import 'package:flutter/material.dart';
import 'package:huertix_project/features/profile/presentation/widgets/userInfo.dart';
import 'package:huertix_project/features/profile/presentation/widgets/cifras_text.dart';
import 'package:huertix_project/common/widgets/horizontal_card.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatelessWidget {
  final String? email;

  const UserProfile({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> parcelas = [
      {
        'name': 'Parcela El Paraíso',
        'cupos': 10,
        'size': '500 m²',
        'state': StatusType.disponible,
        'location': 'Vereda El Roble',
      },
      {
        'name': 'Parcela La Esperanza',
        'cupos': 5,
        'size': '300 m²',
        'state': StatusType.sinCupos,
        'location': 'Vereda La Cumbre',
      },
      {
        'name': 'Parcela Los Pinos',
        'cupos': 8,
        'size': '450 m²',
        'state': StatusType.noDisponible,
        'location': 'Finca Los Álamos',
      },
    ];

    final List<String> availableDays = [
      'Lunes',
      'miercoles',
      'viernes',
      'sabadete',
      'domingo',
      'martes',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFB1E9BA),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: UserInfo(
                  username: 'MElix',
                  location: 'Barranquilla, Colombia',
                  phone: '12345567890',
                  profilePicRoute: 'assets/images/register_bg.jpeg',
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CifrasText(
                              endedFields: 40,
                              endedActs: 1550,
                              hours: 140,
                              availableDays: availableDays,
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: primaryAuthColor,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Experiencia Previa',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Hervir awita, podar el cesped, ser pendja, tomar awa, regar las plantas',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Parcelas en las que participa',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                //navegar al historial de Parcelas;
                              },
                              child: Text(
                                'Ver más parcelas',
                                style: TextStyle(
                                  color: primaryAuthColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Column(
                              spacing: 8,
                              children:
                                  parcelas.map((parcela) {
                                    return HorizontalCard(
                                      color: Colors.green,
                                      name: parcela['name'],
                                      cupos: parcela['cupos'],
                                      size: parcela['size'],
                                      state: parcela['state'],
                                      location: parcela['location'],
                                      imageRoute: 'assets/images/login_bg.jpg',
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
