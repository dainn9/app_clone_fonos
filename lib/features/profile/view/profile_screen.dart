import 'package:app_clone_fonos/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/design_systems/design_system_export.dart';
import '../components/profile_header.dart';
import '../components/listening_statistics.dart';
import '../components/review_section.dart';
import '../components/book_review_item.dart';
import '../components/support_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewmodel>(context);
    // Fake data
    final userData = {
      'name': authProvider.user!.displayName,
      'username': '@khsmdh60',
      'joinDate': 'Tham gia từ tháng 07, 2023',
      'isPremium': false,
      'avatar': authProvider.user!.photoURL, // Thay bằng đường dẫn thực tế
      'level': 27,
      'progress': 38,
      'listeningHours': 361,
      'purchasedContent': 165,
      'topPercentage': 7,
      'reviewCount': 64,
      'likeCount': 14,
    };

    final bookReviews = [
      {
        'bookTitle': 'Điểm Dối Lừa',
        'author': 'Dan Brown',
        'rating': 5,
        'content': 'Không thể ngừng mê sách của Dan Brown được 🥰',
        'contentRating': '5/5',
        'narrationRating': '5/5',
        'overallRating': '4.8',
        'totalReviews': '(120 đánh giá)',
        'bookColor': Colors.deepOrange[300],
        'timeAgo': '',
        'likes': 2,
      },
      {
        'bookTitle': 'Hỏa Ngục',
        'author': 'Dan Brown',
        'rating': 5,
        'content': 'High Recommend nha cả nhà',
        'contentRating': '5/5',
        'narrationRating': '5/5',
        'overallRating': '4.9',
        'totalReviews': '(179 đánh giá)',
        'bookColor': Colors.brown[400],
        'timeAgo': '1 năm trước',
        'likes': 2,
      },
      {
        'bookTitle': 'Biểu Tượng Thất Truyền',
        'author': 'Dan Brown',
        'rating': 5,
        'content': 'Sách hay, đáng đọc',
        'contentRating': '5/5',
        'narrationRating': '4/5',
        'overallRating': '4.7',
        'totalReviews': '(98 đánh giá)',
        'bookColor': Colors.blueGrey[400],
        'timeAgo': '2 năm trước',
        'likes': 1,
      },
      {
        'bookTitle': 'Thiên Thần Và Ác Quỷ',
        'author': 'Dan Brown',
        'rating': 5,
        'content': 'Cuốn sách mở đầu series Robert Langdon hay tuyệt',
        'contentRating': '5/5',
        'narrationRating': '5/5',
        'overallRating': '4.9',
        'totalReviews': '(205 đánh giá)',
        'bookColor': Colors.red[400],
        'timeAgo': '2 năm trước',
        'likes': 3,
      },
    ];

    // Chỉ hiển thị tối đa 3 đánh giá
    final visibleReviews = bookReviews.take(3).toList();
    final hasMoreReviews = bookReviews.length > 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B3A5C),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () => Navigator.pop(context),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/profile_setting');
            },
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(userData: userData),
            const SizedBox(height: 16),
            ListeningStatistics(userData: userData),
            const SizedBox(height: 16),
            ReviewSection(
              reviewCount: userData['reviewCount'] as int,
              likeCount: userData['likeCount'] as int,
            ),
            ...visibleReviews.map((review) => BookReviewItem(review: review)).toList(),
            if (hasMoreReviews)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextButton(
                  onPressed: () {
                    // Xử lý sự kiện xem tất cả đánh giá
                    print("Xem tất cả ${bookReviews.length} đánh giá");
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'Xem tất cả',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            SupportSection(),
          ],
        ),
      ),
    );
  }
}
