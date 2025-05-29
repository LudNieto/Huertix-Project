import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/common/widgets/scaffold_listview.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:huertix_project/features/auth/presentation/widgets/primary_auth_button.dart';
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
        'activityName': 'Sembrar',
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

    return ScaffoldListView(
      showFloatingBtn: /* isAdmin ??*/ true,
      onFloatingBtnPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: _ActivityForm(),
            );
          },
        );
      },
      title: 'Actividades',
      items: activities,
      itemBuilder: (context, activity) {
        return NextActivityCard(
          date: activity['date'],
          plotName: activity['plotName'],
          cropType: activity['cropType'],
          activityName: activity['activityName'],
          activityTime: activity['activityTime'],
          activityStatus: activity['activityStatus'],
          activityDotColor: activity['activityDotColor'],
          location: activity['location'],
          locationDotColor: activity['locationDotColor'],
          onPlotTap: () {
            print('Tocaste ${activity['plotName']}');
          },
        );
      },
    );
  }
}

class _ActivityForm extends StatefulWidget {
  @override
  State<_ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<_ActivityForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedParcela;
  String? selectedTipoActividad;
  String encargado = '';

  final List<String> parcelas = ['Parcela 1', 'Parcela 2', 'Parcela 3'];
  final List<String> tiposActividad = ['Riego', 'Podar', 'Limpieza', 'Sembrar'];
  final List<String> encargados = ['Ana', 'Luis', 'Carlos', 'Valeria'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 16,
          children: [
            Text('Nueva Actividad', style: titleStyle),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Parcela'),
              items:
                  parcelas
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
              onChanged: (value) => setState(() => selectedParcela = value),
              validator:
                  (value) => value == null ? 'Seleccione una parcela' : null,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Tipo de Actividad'),
              items:
                  tiposActividad
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
              onChanged:
                  (value) => setState(() => selectedTipoActividad = value),
              validator: (value) => value == null ? 'Seleccione un tipo' : null,
            ),
            Autocomplete<String>(
              optionsBuilder: (textEditingValue) {
                return encargados.where(
                  (e) => e.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
                );
              },
              onSelected: (value) => encargado = value,
              fieldViewBuilder: (
                context,
                controller,
                focusNode,
                onFieldSubmitted,
              ) {
                return TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(labelText: 'Encargado'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingrese o seleccione un encargado'
                              : null,
                );
              },
            ),
            SizedBox(height: 20),
            PrimaryAuthButton(
              text: 'Agregar',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Actividad agregada')));
                }
              },
              backgroundColor: primaryAuthColor,
            ),
          ],
        ),
      ),
    );
  }
}
