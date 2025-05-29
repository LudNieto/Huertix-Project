import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:huertix_project/features/dashboard/presentation/screens/home_screen.dart';
import 'package:huertix_project/features/auth/presentation/screens/login_screen.dart';
import 'package:huertix_project/features/auth/presentation/screens/register_screen.dart';
import 'package:huertix_project/features/history/fields_history.dart';
import 'package:huertix_project/features/profile/presentation/screen/user_profile_screen.dart';

class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    refreshListenable: authProvider,
    initialLocation: '/login',
    redirect: (context, state) {
      final bool loggedIn = authProvider.status == AuthStatus.authenticated;
      final String currentLocation = state.matchedLocation;
      final bool logginIn =
          currentLocation == '/login' || currentLocation == '/register';
      //final userRole = authProvider.user?.role;

      if (authProvider.status == AuthStatus.loading ||
          authProvider.status == AuthStatus.initial) {
        return null;
      }

      if (!loggedIn && !logginIn) {
        return '/login';
      }

      if (loggedIn && logginIn) {
        return '/home';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (BuildContext contex, GoRouterState state) {
          return const UserProfile();
        },
      ),
      GoRoute(
        path: '/fieldsHistory',
        name: 'fieldsHistory',
        builder: (BuildContext contex, GoRouterState state) {
          return const FieldsHistory();
        },
      ),
    ],
  );
}
