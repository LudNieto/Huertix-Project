import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:huertix_project/features/auth/presentation/providers/auth_provider.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:huertix_project/features/auth/presentation/widgets/primary_auth_button.dart';
import 'package:provider/provider.dart';

class RegisterFormStepper extends StatelessWidget {
  final List<GlobalKey<FormState>> formKeys;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final TextEditingController zoneController;
  final TextEditingController experienceController;

  final bool obscurePassword;
  final bool obscureConfirmPassword;

  final VoidCallback toggleObscurePassword;
  final VoidCallback toggleObscureConfirmPassword;

  final List<String> allAvailableDays;
  final List<String> selectedDays;
  final Function(bool, String) onDaySelected;
  
  final VoidCallback onRegister;
  final Color primaryAuthColor;

  const RegisterFormStepper({
    super.key, 
    required this.formKeys,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.zoneController,
    required this.experienceController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.toggleObscurePassword,
    required this.toggleObscureConfirmPassword,
    required this.allAvailableDays,
    required this.selectedDays,
    required this.onDaySelected,
    required this.onRegister,
    required this.primaryAuthColor,
  });

  List<Step> _steps(BuildContext context) { 
    return [
      Step(
        title: Text('Cuenta', style: TextStyle(fontSize: 12.sp, color: context.read<AuthProvider>().currentStep >= 0 ? primaryAuthColor : Colors.grey)),
        content: Form(
          key: formKeys[0],
          child: Column(
            children: [
              AuthTextFormField(
                controller: fullNameController,
                labelText: 'Nombre completo',
                prefixIconData: Icons.person,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              SizedBox(height: 12.h),
              AuthTextFormField(
                controller: emailController,
                labelText: 'Correo electrónico',
                prefixIconData: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (!value.contains('@') || !value.contains('.')) return 'Correo inválido';
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              AuthTextFormField(
                controller: passwordController,
                labelText: 'Contraseña',
                prefixIconData: Icons.lock,
                obscureText: obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, color: primaryAuthColor),
                  onPressed: toggleObscurePassword,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value.length < 6) return 'Mínimo 6 caracteres';
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              AuthTextFormField(
                controller: confirmPasswordController,
                labelText: 'Confirmar contraseña',
                prefixIconData: Icons.lock_outline,
                obscureText: obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: primaryAuthColor),
                  onPressed: toggleObscureConfirmPassword,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (value != passwordController.text) return 'Las contraseñas no coinciden';
                  return null;
                },
              ),
            ],
          ),
        ),
        isActive: context.read<AuthProvider>().currentStep >= 0,
        state: context.read<AuthProvider>().currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Información', style: TextStyle(fontSize: 12.sp, color: context.read<AuthProvider>().currentStep >= 1 ? primaryAuthColor : Colors.grey)),
        content: Form(
          key: formKeys[1],
          child: Column(
            children: [
              AuthTextFormField(
                controller: phoneController,
                labelText: 'Teléfono',
                prefixIconData: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
              ),
              SizedBox(height: 12.h),
              AuthTextFormField(
                controller: zoneController,
                labelText: 'Zona residencial',
                prefixIconData: Icons.location_city,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              SizedBox(height: 12.h),
              AuthTextFormField(
                controller: experienceController,
                labelText: 'Experiencia previa (opcional)',
                prefixIconData: Icons.work_history,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 16.h),
              Text('Días de disponibilidad:', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: allAvailableDays.map((day) {
                  final isSelected = selectedDays.contains(day);
                  return ChoiceChip(
                    showCheckmark: false,
                    label: Text(day, style: TextStyle(color: isSelected ? Colors.white : primaryAuthColor, fontSize: 13.sp)),
                    selected: isSelected,
                    onSelected: (selected) => onDaySelected(selected, day),
                    selectedColor: primaryAuthColor,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(color: primaryAuthColor)
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        isActive: context.read<AuthProvider>().currentStep >= 1,
        state: context.read<AuthProvider>().currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final currentStepFromProvider = authProvider.currentStep;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            'Crear Cuenta',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: primaryAuthColor,
            ),
          ),
        ),
        SizedBox(
          height: 450.h,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStepFromProvider,
              steps: _steps(context),
              onStepTapped: (step) {
                // Solo valida el paso actual
                if (formKeys[currentStepFromProvider].currentState!.validate() || step < currentStepFromProvider) {
                  authProvider.goToStep(step);
                } else if (step > currentStepFromProvider) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Por favor, completa los campos del paso actual primero.'),
                      backgroundColor: Colors.orangeAccent,
                    ),
                  );
                }
              },
              onStepContinue: () {
                if (formKeys[currentStepFromProvider].currentState!.validate()) {
                  if (currentStepFromProvider == 1 && selectedDays.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Debes seleccionar al menos un día de disponibilidad.'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  if (currentStepFromProvider < _steps(context).length - 1) {
                    authProvider.nextStep();
                  } else {
                    onRegister();
                  }
                }
              },
              onStepCancel: () {
                if (currentStepFromProvider > 0) {
                  authProvider.previousStep();
                }
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: authProvider.isLoading
                      ? Center(child: CircularProgressIndicator(color: primaryAuthColor))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            if (currentStepFromProvider > 0)
                              PrimaryAuthButton(
                                text: 'Anterior', 
                                onPressed: details.onStepCancel, 
                                backgroundColor: Colors.grey, 
                                height: 45.h, 
                                fontSize: 16.sp, 
                                width: 120.w),
                            if (currentStepFromProvider == 0)
                              const SizedBox.shrink(),
                            PrimaryAuthButton(
                              text: currentStepFromProvider < _steps(context).length - 1 ? 'Siguiente' : 'Registrar',
                              onPressed: details.onStepContinue,
                              backgroundColor: primaryAuthColor,
                              height: 45.h,
                              fontSize: 16.sp,
                              width: currentStepFromProvider > 0 ? 120.w : 150.w,
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 14.sp)),
            TextButton(
              onPressed: context.watch<AuthProvider>().isLoading ? null : () {
                context.goNamed('login');
              },
              child: Text(
                'Inicia sesión',
                style: TextStyle(
                  color: primaryAuthColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}