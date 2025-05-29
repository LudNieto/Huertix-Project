import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/common/widgets/horizontal_card.dart';
import 'package:huertix_project/common/widgets/scaffold_listview.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';

class SearchPlots extends StatelessWidget {
  const SearchPlots({super.key});

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
      showFloatingBtn: /* isAdmin ??*/ true,
      onFloatingBtnPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return const _AddFieldForm();
          },
        );
      },
      title: 'Parcelas Disponibles',
      items: parcelas,
      itemBuilder: (context, parcela) {
        return HorizontalCard(
          width: size.width * 0.9,
          height: 150,
          name: parcela['name'],
          type: parcela['type'],
          cupos: parcela['cupos'],
          size: parcela['size'],
          state: parcela['state'],
          location: parcela['location'],
          buttonText: 'Registrar Horas', //Àgregar Participante si es admin
          onPressed: () {
            print('Botón presionado');
          },
        );
      },
    );
  }
}

class _AddFieldForm extends StatefulWidget {
  const _AddFieldForm({Key? key}) : super(key: key);

  @override
  State<_AddFieldForm> createState() => _AddFieldFormState();
}

class _AddFieldFormState extends State<_AddFieldForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _cuposController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedCropType;
  String? _selectedStatus;

  final List<String> cropTypes = [
    'Hortalizas',
    'Frutales',
    'Hierbas Aromáticas',
    'Verduras de Hoja',
    'Tubérculos',
  ];

  final List<String> statusTypes = [
    'disponible',
    'enProceso',
    'terminada',
    'sinCupos',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nueva Parcela', style: titleStyle),
              SizedBox(height: 6.h),
              AuthTextFormField(
                labelText: 'Nombre de la Parcela',
                controller: _nameController,
              ),
              SizedBox(height: 12.h),

              AuthTextFormField(
                prefixIconData: Icons.rule,
                labelText: 'Tamaño (ej. 50m²)',
                controller: _sizeController,
              ),
              SizedBox(height: 12.h),

              DropdownButtonFormField<String>(
                value: _selectedCropType,
                items:
                    cropTypes
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() => _selectedCropType = value);
                },
                decoration: const InputDecoration(labelText: 'Tipo de Cultivo'),
                validator:
                    (value) =>
                        value == null ? 'Selecciona un tipo de cultivo' : null,
              ),
              SizedBox(height: 12.h),

              AuthTextFormField(
                labelText: 'Cupos disponibles',
                controller: _cuposController,
                prefixIconData: Icons.people, // ← icono agregado
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12.h),

              DropdownButtonFormField<String>(
                value: _selectedStatus,
                items:
                    statusTypes
                        .map(
                          (status) => DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() => _selectedStatus = value);
                },
                decoration: const InputDecoration(labelText: 'Estado'),
                validator:
                    (value) => value == null ? 'Selecciona un estado' : null,
              ),
              SizedBox(height: 12.h),

              AuthTextFormField(
                prefixIconData: Icons.location_on,
                labelText: 'Ubicación',
                controller: _locationController,
              ),
              SizedBox(height: 16.h),

              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Agregar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // o primaryAuthColor
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Simular agregar la parcela
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Parcela agregada')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
