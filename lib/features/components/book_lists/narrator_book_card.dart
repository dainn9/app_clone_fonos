import 'package:flutter/material.dart';

class NarratorBookCard extends StatelessWidget {
  final String title;
  final Color color;
  final bool isPurchased;
  final VoidCallback? onTap;

  const NarratorBookCard({
    super.key,
    required this.title,
    required this.color,
    this.isPurchased = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (isPurchased)
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "ĐÃ MUA",
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
