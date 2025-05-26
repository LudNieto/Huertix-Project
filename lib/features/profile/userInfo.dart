import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String username;
  final String phone;
  final String location;
  final double spacing;
  final double fontsize;
  final double? circleSize;
  final TextStyle? textStyle;
  final String profilePicRoute;

  const UserInfo({
    super.key,
    required this.username,
    required this.location,
    required this.phone,
    this.circleSize = 50,
    this.fontsize = 25,
    this.spacing = 8,
    this.textStyle,
    required this.profilePicRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: circleSize,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: circleSize! - 4,
            backgroundImage: AssetImage(
              profilePicRoute,
            ), // Reemplaza con tu imagen
          ),
        ),
        Text(
          username, //userName
          style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          spacing: spacing,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.phone, size: 20, color: Colors.green),
            Text(
              phone,
              style:
                  textStyle ??
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          spacing: spacing,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, size: 20, color: Colors.green),
            Text(
              'Barranquilla, Colombia',
              style:
                  textStyle ??
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
