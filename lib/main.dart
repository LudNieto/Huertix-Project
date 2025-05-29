import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huertix_project/config/router/app_router.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:huertix_project/firebase_options.dart';
import 'package:huertix_project/injection_container.dart' as di;
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  final AuthProvider authProvider = di.sl<AuthProvider>();
  await authProvider.checkFirebaseSession();
  await initializeDateFormatting('es_ES', null);
  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;
  const MyApp({super.key, required this.authProvider});
  static const Size designScreenSize = Size(375, 812);

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(authProvider);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
      ],
      child: ScreenUtilInit(
        designSize: designScreenSize,
        minTextAdapt: true,
        builder: (context, _) {
          return MaterialApp.router(
            routerConfig: appRouter.router,
            title: 'Huertix',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
          );
        },
      ),
    );
  }
}
