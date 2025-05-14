import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget {
  final int reviewCount;
  final int likeCount;

  const ReviewSection({
    Key? key,
    required this.reviewCount,
    required this.likeCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Đánh giá',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '$reviewCount đánh giá',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$likeCount lượt thích',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              const Spacer(),
              Text(
                '"',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
