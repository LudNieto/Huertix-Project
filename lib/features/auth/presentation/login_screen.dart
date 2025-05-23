import 'package:flutter/material.dart';
import 'package:huertix_project/features/auth/config/auth_provider.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_screen_card.dart';
import 'package:huertix_project/features/auth/presentation/register_screen.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:huertix_project/features/auth/presentation/widgets/primary_auth_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  static const Color primaryAuthColor = Color(0xFF085430);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).resetError();
    });
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthProvider>().loginUser(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.status == AuthStatus.failure && authProvider.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
        context.read<AuthProvider>().resetError();
      });
    }
    
    Widget formContent = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Iniciar Sesión',
            style: GoogleFonts.jua(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: primaryAuthColor,
            ),
          ),

          SizedBox(height: 24.h),

          AuthTextFormField(
            controller: _emailController,
            labelText: 'Correo electrónico',
            prefixIconData: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Por favor, ingresa tu correo';
              if (!value.contains('@') || !value.contains('.')) return 'Ingresa un correo válido';
              return null;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(height: 16.h),

          AuthTextFormField(
            controller: _passwordController,
            labelText: 'Contraseña',
            prefixIconData: Icons.lock,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: primaryAuthColor),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (value) => (value == null || value.isEmpty) ? 'Por favor, ingresa tu contraseña' : null,
          ),

          SizedBox(height: 24.h),

          authProvider.isLoading
              ? const CircularProgressIndicator(color: primaryAuthColor)
              : PrimaryAuthButton(
                  text: 'Ingresar',
                  onPressed: () => _login(context),
                  backgroundColor: primaryAuthColor,
                ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿No tienes una cuenta?', style: TextStyle(fontSize: 14.sp)),
              TextButton(
                onPressed: authProvider.isLoading ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: Text('Regístrate', style: TextStyle(color: primaryAuthColor, fontWeight: FontWeight.bold, fontSize: 14.sp)),
              ),
            ],
          ),
        ],
      ),
    );

    return AuthScreenCard.AuthScreenCard(
      backgroundImagePath: 'assets/images/login_bg.jpg', 
      cardChild: formContent,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}