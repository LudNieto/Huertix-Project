import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/features/auth/config/auth_provider.dart';
import 'package:huertix_project/firebase_options.dart';
import 'package:huertix_project/injection_container.dart' as di;
import 'package:provider/provider.dart';
import 'features/auth/presentation/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const Size designScreenSize = Size(375, 812);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => di.sl<AuthProvider>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: designScreenSize,
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Huertix',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
