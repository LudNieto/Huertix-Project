import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:huertix_project/features/auth/domain/user_entity.dart';
import 'package:huertix_project/config/provider/auth_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onProfileTap;

  const CustomAppBar({super.key, this.title = "", this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final UserEntity? user = authProvider.user;

    const Color gradientStartColor = Color(0xFF37A73D);
    const Color gradientEndColor = Color(0xFF7EDF83);

    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, gradientEndColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      elevation: 4.0,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap:
                  onProfileTap ??
                  () {
                    Scaffold.of(context).openDrawer();
                  },
              child: CircleAvatar(
                radius: 26.r,
                backgroundColor: Colors.white.withOpacity(0.8),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/default_avatar.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hola,',
                        style: TextStyle(fontSize: 18.sp, color: Colors.white),
                      ),
                      if (user != null)
                        Text(
                          user.fullName.split(" ").first,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      else
                        Text(
                          'Usuario',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    "HUERTIX",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 25.h); // Un poco más alto si quieres
}
