import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  static const Color drawerBackgroundColor = Color(0xFF191414);
  static const Color headerBackgroundColor = Color(0xFF0F0F0F);
  static const Color activeItemColor = Color(0xFF085430);
  static const Color inactiveItemColor = Colors.white70;
  static const Color iconColor = Colors.white54;
  static const Color headerTextColor = Colors.white;
  static const Color dividerColor = Colors.white24;

  static const TextStyle textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: headerTextColor,
  );

  Widget _buildDrawerHeader(UserEntity? user) {
    return Container(
      height: 180.h,
      width: double.infinity,
      padding: EdgeInsets.only(left: 12.w, top: 8.h),
      decoration: BoxDecoration(color: Colors.grey.shade600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 38.r,
            backgroundColor: Colors.grey[700],
            child: ClipOval(
              child: Image.asset(
                'assets/images/default_avatar.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            user?.fullName ?? 'Nombre de Usuario',
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            user?.email ?? 'usuario@example.com',
            style: TextStyle(
              fontSize: 13.sp,
              color: headerTextColor.withOpacity(0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    bool isActive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.sp,
        color: isActive ? activeItemColor : iconColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: isActive ? activeItemColor : inactiveItemColor,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final UserEntity? user = authProvider.user;

    final String currentRouteName =
        ModalRoute.of(context)?.settings.name ?? '/home';

    return Drawer(
      backgroundColor: drawerBackgroundColor,
      child: Column(
        children: <Widget>[
          _buildDrawerHeader(user),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 8.h),
              children: <Widget>[
                _buildDrawerItem(
                  icon: Icons.home_filled,
                  text: 'Inicio',
                  isActive: currentRouteName == '/home',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName != '/home') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ir a Inicio (TODO)")),
                      );
                    }
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.event_note_outlined,
                  text: 'Eventos',
                  isActive: currentRouteName == '/events',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ir a Eventos (TODO)")),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.grass_rounded,
                  text: 'Parcelas',
                  isActive: currentRouteName == '/plots',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ir a Parcelas (TODO)")),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.school_outlined,
                  text: 'Educación',
                  isActive: currentRouteName == '/education',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ir a Educación (TODO)")),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history_toggle_off_outlined,
                  text: 'Historial',
                  isActive: currentRouteName == '/history',
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ir a Historial (TODO)")),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.account_circle_outlined,
                  text: 'Perfil',
                  isActive: currentRouteName == '/profile',
                  onTap: () {
                    Navigator.pop(context);
                    Future.microtask(() {
                      context.go('/profile');
                    });
                  },
                ),
              ],
            ),
          ),
          const Divider(color: dividerColor, height: 1, thickness: 0.5),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: _buildDrawerItem(
              icon: Icons.logout,
              text: 'Cerrar sesión',
              onTap: () {
                Navigator.pop(context);
                context.go('/login');
                Future.microtask(() {
                  context.read<AuthProvider>().logoutUser();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
