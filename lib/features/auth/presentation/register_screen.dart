import 'package:flutter/material.dart';
import 'package:huertix_project/features/auth/config/auth_provider.dart';
import 'package:huertix_project/features/auth/presentation/auth_screen_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _zoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _experienceController = TextEditingController();

  final List<String> _allAvailableDays = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
  List<String> _selectedDays = [];

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const Color primaryAuthColor = Color(0xFF085430);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).resetError();
    });
  }

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, selecciona al menos un día de disponibilidad.')),
        );
        return;
      }
      context.read<AuthProvider>().registerUser(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            fullName: _fullNameController.text.trim(),
            phone: _phoneController.text.trim(),
            residentialZone: _zoneController.text.trim(),
            availabilityDays: _selectedDays,
            previousExperience: _experienceController.text.trim().isNotEmpty 
                                ? _experienceController.text.trim() 
                                : null,
          );
    }
  }

  InputDecoration _buildInputDecoration(String labelText, IconData prefixIconData) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(prefixIconData, color: primaryAuthColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: primaryAuthColor, width: 2.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.status == AuthStatus.failure && authProvider.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage!), backgroundColor: Colors.redAccent),
        );
        context.read<AuthProvider>().resetError();
      });
    }
     if (authProvider.status == AuthStatus.authenticated) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
             ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('¡Registro exitoso! Iniciando sesión...'), backgroundColor: Colors.green),
            );
            // AuthWrapper se encargará de la navegación
         });
    }

    Widget formContent = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Crear Cuenta',
            style: GoogleFonts.jua(fontSize: 28.sp, fontWeight: FontWeight.bold, color: primaryAuthColor),
          ),
          SizedBox(height: 20.h),
          TextFormField(
            controller: _fullNameController,
            decoration: _buildInputDecoration('Nombre completo', Icons.person),
            style: TextStyle(fontSize: 15.sp),
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _emailController,
            decoration: _buildInputDecoration('Correo electrónico', Icons.email),
            style: TextStyle(fontSize: 15.sp),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (!value.contains('@') || !value.contains('.')) return 'Correo inválido';
              return null;
            },
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _phoneController,
            decoration: _buildInputDecoration('Teléfono', Icons.phone),
            style: TextStyle(fontSize: 15.sp),
            keyboardType: TextInputType.phone,
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _zoneController,
            decoration: _buildInputDecoration('Zona de residencia/cercanía', Icons.location_city),
            style: TextStyle(fontSize: 15.sp),
            validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _buildInputDecoration('Contraseña', Icons.lock).copyWith(
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: primaryAuthColor),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            style: TextStyle(fontSize: 15.sp),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Mínimo 6 caracteres';
              return null;
            },
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: _buildInputDecoration('Confirmar contraseña', Icons.lock_outline).copyWith(
              suffixIcon: IconButton(
                icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: primaryAuthColor),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
            ),
            style: TextStyle(fontSize: 15.sp),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value != _passwordController.text) return 'Las contraseñas no coinciden';
              return null;
            },
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top:8.h, bottom: 4.h, left: 4.w),
              child: Text('Días de Disponibilidad:', style: TextStyle(fontSize: 15.sp, color: Colors.black54, fontWeight: FontWeight.w500)),
            )
          ),
          Wrap(
            spacing: 5.w, runSpacing: 0,
            children: _allAvailableDays.map((day) => ChoiceChip(
              label: Text(day, style: TextStyle(fontSize: 12.sp)),
              selected: _selectedDays.contains(day),
              selectedColor: primaryAuthColor.withOpacity(0.8),
              labelStyle: TextStyle(color: _selectedDays.contains(day) ? Colors.white : Colors.black54),
              checkmarkColor: Colors.white,
              onSelected: (selected) => setState(() => selected ? _selectedDays.add(day) : _selectedDays.remove(day)),
            )).toList(),
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _experienceController,
            decoration: _buildInputDecoration('Experiencia Previa (Opcional)', Icons.eco),
            style: TextStyle(fontSize: 15.sp), maxLines: 2,
          ),
          SizedBox(height: 20.h),
          authProvider.isLoading
              ? const CircularProgressIndicator(color: primaryAuthColor)
              : SizedBox(
                  width: double.infinity, height: 50.h,
                  child: ElevatedButton(
                    onPressed: () => _register(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryAuthColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: Text('Registrarse', style: GoogleFonts.jua(fontSize: 20.sp, color: Colors.white)),
                  ),
                ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Ya tienes una cuenta?', style: TextStyle(fontSize: 14.sp)),
              TextButton(
                onPressed: authProvider.isLoading ? null : () => Navigator.pop(context),
                child: Text('Inicia sesión', style: TextStyle(color: primaryAuthColor, fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ],
          ),
        ],
      ),
    );

    return AuthScreenCard.AuthScreenCard(
      backgroundImagePath: 'assets/images/register_bg.jpeg', // Tu imagen de fondo para registro
      cardChild: formContent,
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _zoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _experienceController.dispose();
    super.dispose();
  }
}