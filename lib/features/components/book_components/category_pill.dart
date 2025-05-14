import 'package:flutter/material.dart';

class CategoryPill extends StatelessWidget {
  final String name;

  const CategoryPill({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
