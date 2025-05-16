import 'package:flutter/material.dart';

class BookReviewItem extends StatelessWidget {
  final Map<String, dynamic> review;

  const BookReviewItem({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                '${review['rating']}/5',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text('Rất hay', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(review['content']),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nội dung: ${review['contentRating']}'),
                    Text('Giọng đọc: ${review['narrationRating']}'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 150,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // Thay thế Image.asset bằng Container với màu
                    Container(
                      width: 40,
                      height: 60,
                      color: review['bookColor'] ?? Colors.brown[300],
                      child: Center(
                        child: Text(
                          review['bookTitle'].substring(0, 1),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review['bookTitle'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            review['author'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              // Icon(Icons.star, color: Colors.amber, size: 12),
                              // Text(
                              //   ' ${review['overallRating']} ${review['totalReviews']}',
                              //   style: TextStyle(
                              //     fontSize: 10,
                              //     color: Colors.grey[600],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (review['timeAgo'] != '')
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage(userData['avatar']),
                ),
                const SizedBox(width: 8),
                Text(
                  "Đinh Quốc Bảo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Spacer(),
                Text(
                  review['timeAgo'],
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          const Divider(),
          Row(
            children: [
              Icon(Icons.thumb_up_outlined, size: 16),
              const SizedBox(width: 4),
              Text('${review['likes']}'),
              const Spacer(),
              Icon(Icons.more_horiz, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  // Placeholder for userData - in real app, this would be handled differently
  Map<String, dynamic> get userData => {
    'avatar': 'assets/images/avatar.jpg',
  };
}
