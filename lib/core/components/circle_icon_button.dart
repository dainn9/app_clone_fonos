import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color iconColor;
  final Color backgroundColor;
  final IconData icon;
  final double top;
  final double? left;
  final double? right;
  final double? bottom;

  const CircleIconButton({
    Key? key,
    this.onPressed,
    this.iconColor = Colors.white,
    this.backgroundColor = const Color.fromRGBO(158, 158, 158, 0.3),
    this.icon = Icons.arrow_back_ios_new,
    this.top = 10,
    this.left,
    this.right,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onPressed ?? () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: iconColor, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
