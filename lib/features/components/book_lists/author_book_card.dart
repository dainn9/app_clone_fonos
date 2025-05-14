import 'package:flutter/material.dart';

class AuthorBookCard extends StatelessWidget {
  final String title;
  final String author;
  final bool isPurchased;

  const AuthorBookCard({
    super.key,
    required this.title,
    required this.author,
    this.isPurchased = false,
  });

  @override
  Widget build(BuildContext context) {
    // Tạo màu ngẫu nhiên dựa trên title
    final List<Color> colors = [
      const Color(0xFFE3F2FD), // Xanh nhạt
      const Color(0xFFFFF9C4), // Vàng nhạt
      const Color(0xFFE8F5E9), // Xanh lá nhạt
      const Color(0xFFF3E5F5), // Tím nhạt
      const Color(0xFFFFEBEE), // Đỏ nhạt
    ];
    final Color backgroundColor = colors[title.length % colors.length];
    final Color textColor = Colors.black87;

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 160,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    title.split(' ').take(2).join('\n'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '1 THẺ FONOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            author,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
