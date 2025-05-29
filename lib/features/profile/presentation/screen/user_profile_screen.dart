import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        'name': 'Parcela A',
        'type': 'Hortalizas',
        'cupos': 5,
        'size': '50m²',
        'state': StatusType.terminada,
        'location': 'Barranquilla',
      },
      {
        'name': 'Parcela B',
        'type': 'Frutales',
        'cupos': 0,
        'size': '80m²',
        'state': StatusType.enProceso,
        'location': 'Bogotá',
      },
      {
        'name': 'Parcela C',
        'type': 'Hierbas Aromáticas',
        'cupos': 3,
        'size': '60m²',
        'state': StatusType.terminada,
        'location': 'Bucaramanga',
      },
      {
        'name': 'Parcela D',
        'type': 'Verduras de Hoja',
        'cupos': 2,
        'size': '45m²',
        'state': StatusType.disponible,
        'location': 'Medellín',
      },
      {
        'name': 'Parcela E',
        'type': 'Tubérculos',
        'cupos': 4,
        'size': '70m²',
        'state': StatusType.sinCupos,
        'location': 'Cali',
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
                            Text('Experiencia Previa', style: titleStyle),
                            Text(
                              'Hervir awita, podar el cesped, ser pendja, tomar awa, regar las plantas',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Parcelas en las que participa',
                              style: titleStyle,
                            ),
                            TextButton(
                              onPressed: () => context.goNamed('fieldsHistory'),
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
                                      type: parcela['type'],
                                      name: parcela['name'],
                                      cupos: parcela['cupos'],
                                      size: parcela['size'],
                                      state: parcela['state'],
                                      location: parcela['location'],
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
