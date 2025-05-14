import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  final VoidCallback? onPressed;

  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Define the highlight orange color for active state
    const Color highlightOrange = Color(0xFFFF9800); // Light orange color

    // Use the provided color, fall back to theme's primary color
    final Color baseColor = color ?? Theme.of(context).primaryColor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          // When button is pressed, use the highlight orange color
          if (states.contains(WidgetState.pressed)) {
            return highlightOrange;
          }
          // Otherwise use the base color
          return baseColor;
        }),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 16),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        // Add overlay color for hover/focus states
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return highlightOrange.withOpacity(0.2);
          }
          return null;
        }),
        // Add elevation changes for pressed state
        elevation: WidgetStateProperty.resolveWith<double>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return 8.0; // Higher elevation when pressed
          }
          return 2.0; // Default elevation
        }),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
