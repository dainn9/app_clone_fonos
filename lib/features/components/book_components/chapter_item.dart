import 'package:flutter/material.dart';

class ChapterItem extends StatelessWidget {
  final String title;
  final String duration;
  final VoidCallback? onPlay;

  const ChapterItem({
    super.key,
    required this.title,
    required this.duration,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                duration,
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onPlay,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFF87D63),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }
}
