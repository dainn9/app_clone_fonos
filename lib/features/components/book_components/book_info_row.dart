import 'package:flutter/material.dart';

class BookInfoRow extends StatelessWidget {
  final String duration;
  final String publisher;
  final VoidCallback? onPublisherTap;

  const BookInfoRow({
    super.key,
    required this.duration,
    required this.publisher,
    this.onPublisherTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: Colors.blueGrey, size: 16),
          const SizedBox(width: 8),
          Text(
            duration,
            style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.home_outlined, color: Colors.blueGrey, size: 22),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onPublisherTap,
            child: Text(
              publisher,
              style: const TextStyle(fontSize: 14, color: Color(0xFFF87D63), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
