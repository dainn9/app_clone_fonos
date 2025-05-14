import 'package:flutter/material.dart';

class PublisherBookCard extends StatelessWidget {
  final String title;
  final String author;
  final Color color;
  final bool isPurchased;
  final String? tokenInfo;
  final VoidCallback? onTap;

  const PublisherBookCard({
    super.key,
    required this.title,
    required this.author,
    required this.color,
    this.isPurchased = false,
    this.tokenInfo,
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color:
                          color == Colors.black ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    author,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          color == Colors.black
                              ? Colors.white70
                              : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            if (tokenInfo != null)
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tokenInfo!,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
