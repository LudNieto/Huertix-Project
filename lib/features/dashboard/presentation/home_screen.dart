import 'package:flutter/material.dart';
import 'package:huertix_project/common/widgets/custom_appbar.dart';
import 'package:huertix_project/common/widgets/custom_drawer.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contenido Principal de la Página de Inicio',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Text("Bienvenido/a ${user!.fullName}"),
              SizedBox(height: 10.h),
              Text("Tu rol es: ${userRoleToString(user.role)}"),
              SizedBox(height: 20.h),
              if (user.role == UserRole.admin)
                Text("Eres Administrador", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold))
              else if (user.role == UserRole.volunteer)
                Text("Eres Voluntario", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}