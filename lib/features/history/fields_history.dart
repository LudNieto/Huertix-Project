import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/common/widgets/custom_appbar.dart';
import 'package:huertix_project/common/widgets/horizontal_card.dart';
import 'package:huertix_project/common/widgets/scaffold_listview.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';

class FieldsHistory extends StatelessWidget {
  const FieldsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Lista de parcelas simulada
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

    return ScaffoldListView<Map<String, dynamic>>(
      title: 'Historial de Parcelas',
      items: parcelas,
      itemBuilder: (context, parcela) {
        return HorizontalCard(
          width: size.width * 0.9,
          height: 150.h,
          name: parcela['name'],
          type: parcela['type'],
          cupos: parcela['cupos'],
          size: parcela['size'],
          state: parcela['state'],
          location: parcela['location'],
        );
      },
    );
  }
}
