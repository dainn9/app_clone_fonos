import 'package:flutter/material.dart';

class CircleIconButtonBook extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double radius;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;

  const CircleIconButtonBook({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.radius = 15,
    this.iconSize = 18,
    this.backgroundColor = const Color(0x33000000), // grey with opacity
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: IconButton(
        icon: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
