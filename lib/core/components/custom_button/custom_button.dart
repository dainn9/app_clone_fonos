import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final IconData? icon;
  final bool isLoading;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor,
    this.icon,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: SizedBox(
        width: double.infinity,
        child:
        isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Row(
          mainAxisAlignment:
          icon != null
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(icon, color: iconColor ?? textColor ?? Colors.black, size: 25), // Dùng màu riêng cho icon
            if (icon != null) const SizedBox(width: 8),
            Text(text, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

//
/*
    CustomButton(
      text: 'Đăng nhập',
      onPressed: () => loginFunction(),
      icon: Icons.login,
    )
 */