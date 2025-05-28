import 'package:flutter/material.dart';
import 'package:huertix_project/features/profile/user_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryThemeColor = Color(0xFF085430);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final UserEntity? user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi Huerto (${userRoleToString(user!.role)})', // Muestra el rol
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: primaryThemeColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Para el botón de atrás si viniera de otra pantalla
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: "Cerrar Sesión",
            onPressed: () {
              context.read<AuthProvider>().logoutUser();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.sp,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '¡Bienvenid@, ${user.fullName}!',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryThemeColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildUserInfoRow(Icons.email, 'Correo:', user.email),
                    _buildUserInfoRow(Icons.phone, 'Teléfono:', user.phone),
                    _buildUserInfoRow(
                      Icons.location_city,
                      'Zona:',
                      user.residentialZone,
                    ),
                    _buildUserInfoRow(
                      Icons.calendar_today,
                      'Disponibilidad:',
                      user.availabilityDays.join(', '),
                    ),
                    if (user.previousExperience != null &&
                        user.previousExperience!.isNotEmpty)
                      _buildUserInfoRow(
                        Icons.eco,
                        'Experiencia:',
                        user.previousExperience!,
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            if (user.role == UserRole.admin) ...[
              Text(
                "Panel de Administrador",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              ElevatedButton.icon(
                icon: const Icon(Icons.settings_applications),
                label: const Text("Gestionar Zonas de Cultivo (TODO)"),
                onPressed: () {
                  /* Navegar a gestión de zonas */
                },
              ),
              SizedBox(height: 10.h),
              ElevatedButton.icon(
                icon: const Icon(Icons.assignment),
                label: const Text("Gestionar Tareas (TODO)"),
                onPressed: () {
                  /* Navegar a gestión de tareas */
                },
              ),
            ] else if (user.role == UserRole.volunteer) ...[
              Text(
                "Panel de Voluntario",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              ElevatedButton.icon(
                icon: const Icon(Icons.grass),
                label: const Text("Ver Zonas de Cultivo (TODO)"),
                onPressed: () {
                  /* Navegar a Zonas de Cultivo */
                },
              ),
              SizedBox(height: 10.h),
              ElevatedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text("Mi Participación (TODO)"),
                onPressed: () {
                  /* Navegar a Bitácora */
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text("Mi Perfil"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfile(),
                    ),
                  );
                },
              ),
            ],
            SizedBox(height: 20.h),
            Center(
              child: Text(
                "Más funcionalidades próximamente...",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp, color: primaryThemeColor),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 15.sp, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
