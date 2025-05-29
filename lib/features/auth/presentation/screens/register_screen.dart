import 'package:flutter/material.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:huertix_project/features/auth/presentation/widgets/auth_screen_card.dart';
import 'package:huertix_project/features/auth/presentation/widgets/register_form_stepper.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _zoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _experienceController = TextEditingController();

  final List<String> _allAvailableDays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];
  final List<String> _selectedDays = [];

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleObscureConfirmPassword() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _onDaySelected(bool selected, String day) {
    setState(() {
      if (selected) {
        _selectedDays.add(day);
      } else {
        _selectedDays.remove(day);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().resetError();
      context.read<AuthProvider>().resetStepper();
    });
  }

  void _register(BuildContext context) {
    bool allValid = _formKeys.every(
      (key) => key.currentState?.validate() ?? false,
    );

    if (!allValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
          content: Text('Por favor, completa correctamente todos los campos.'),
        ),
      );
      return;
    }

    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.redAccent,
          content: Text(
            'Por favor, selecciona al menos un día de disponibilidad.',
          ),
        ),
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
      previousExperience:
          _experienceController.text.trim().isNotEmpty
              ? _experienceController.text.trim()
              : null,
    );
  }

  static const Color primaryAuthColor = Color(0xFF085430);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    if (authProvider.status == AuthStatus.failure &&
        authProvider.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(authProvider.errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
        context.read<AuthProvider>().resetError();
      });
    }

    if (authProvider.status == AuthStatus.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('¡Registro exitoso! Iniciando sesión...'),
            backgroundColor: Colors.green,
          ),
        );
      });
    }

    Widget formContent = RegisterFormStepper(
      formKeys: _formKeys,
      primaryAuthColor: primaryAuthColor,
      fullNameController: _fullNameController,
      emailController: _emailController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      phoneController: _phoneController,
      zoneController: _zoneController,
      experienceController: _experienceController,
      allAvailableDays: _allAvailableDays,
      selectedDays: _selectedDays,
      obscurePassword: _obscurePassword,
      obscureConfirmPassword: _obscureConfirmPassword,
      toggleObscurePassword: _toggleObscurePassword,
      toggleObscureConfirmPassword: _toggleObscureConfirmPassword,
      onRegister: () => _register(context),
      onDaySelected: _onDaySelected,
    );

    return AuthScreenCard.AuthScreenCard(
      backgroundImagePath: 'assets/images/register_bg.jpeg',
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
