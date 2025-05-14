import 'package:flutter/material.dart';

// Book components
import '../../components/book_components/book_cover.dart';
import '../../components/book_components/category_pill.dart';
import '../../components/book_components/chapter_item.dart';
import '../../components/book_components/rating_card.dart';
import '../../components/book_components/review_card.dart';
import '../../components/book_components/book_info_row.dart';
import '../../components/book_components/action_button.dart';

// Book lists
import '../../components/book_lists/related_book_card.dart';
import '../../components/book_lists/author_book_card.dart';
import '../../components/book_lists/narrator_book_card.dart';
import '../../components/book_lists/publisher_book_card.dart';

// Section headers
import '../../components/section_headers/section_header.dart';

// Models

class HomeDetail extends StatelessWidget {
  const HomeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A6EA9), Color(0xFF121212)],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top navigation and share buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // Book cover and title section
                Center(
                  child: Column(
                    children: [
                      const BookCover(
                        title: "TRÍ TUỆ\nDO THÁI",
                        author: "ERAN KATZ",
                        subtitle: "JEROME BECOMES A GENIUS",
                        imageUrl:
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Star_of_David.svg/1200px-Star_of_David.svg.png",
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Trí Tuệ Do Thái",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Eran Katz",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "4.4 (183 đánh giá)",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: ActionButton(
                          text: "Bắt đầu nghe",
                          icon: Icons.play_arrow,
                          color: Color(0xFFF87D63),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Related books section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: "Thường Được Mua Cùng Với",
                        onSeeAll: () {},
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            RelatedBookCard(
                              title: "Thiên Nga Đen",
                              author: "Nassim Nicholas Taleb",
                              color: Colors.white,
                            ),
                            RelatedBookCard(
                              title: "Lãnh Đạo",
                              author: "Henry Kissinger",
                              color: Color(0xFFADD8E6),
                            ),
                            RelatedBookCard(
                              title: "Aqua",
                              author: "Author",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Book description and details
                Container(
                  color: const Color(0xFF121212),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(title: "Giới thiệu nội dung"),
                      const SizedBox(height: 12),
                      const Text(
                        "Trí Tuệ Do Thái là một cuốn sách tư duy đầy tham vọng trong việc nâng cao khả năng tư học tập, ghi nhớ và phân tích - những điều đã khiến người Do Thái vượt trội lên, chiếm lĩnh những vị trí quan trọng trong ngành truyền thông, ngân hàng và những giải thưởng sáng tạo trên thế giới. ...",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Xem thêm",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFF87D63),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Book info
                      const BookInfoRow(
                        duration: "11 giờ 32 phút",
                        publisher: "Alphabooks",
                      ),

                      const SizedBox(height: 16),

                      // Categories
                      Row(
                        children: const [
                          CategoryPill(name: "Tư duy"),
                          SizedBox(width: 8),
                          CategoryPill(name: "Tư duy thành công"),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Ratings section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeader(title: "Hội viên nói gì"),
                          const SizedBox(height: 16),
                          const RatingCard(
                            rating: 4.4,
                            reviewCount: 183,
                            contentRating: 4.6,
                            narratorRating: 4.1,
                          ),
                          const SizedBox(height: 16),
                          const ReviewCard(
                            userName: "Đinh Quốc Bảo",
                            timeAgo: "8 tháng trước",
                            rating: 4.5,
                            comment: "Rất hay",
                          ),

                          const SizedBox(height: 24),

                          // Chapters section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SectionHeader(title: "Mục lục"),
                              const SizedBox(height: 16),
                              const ChapterItem(
                                title:
                                    "Lời giới thiệu - Chương 1. Một buổi tụ tập tại quán café Ladino",
                                duration: "39 phút",
                              ),
                              const SizedBox(height: 12),
                              const ChapterItem(
                                title:
                                    "Chương 2. Bí ẩn về sự thông thái của người Do Thái",
                                duration: "46 phút",
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 24,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  child: const Text("Xem tất cả 16 chương"),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Author section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Cùng tác giả",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey[800],
                                    backgroundImage: const NetworkImage(
                                      "https://example.com/author-image.jpg",
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Eran Katz",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const AuthorBookCard(
                                title: "Bí Mật Của Một Trí Nhớ Siêu Phàm",
                                author: "Eran Katz",
                                isPurchased: true,
                              ),

                              const SizedBox(height: 24),

                              // Similar narrators section
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 180,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    NarratorBookCard(
                                      title: "Thần Chết Đến Muộn Còn Đợi",
                                      color: Colors.lightBlue[100]!,
                                      isPurchased: true,
                                    ),
                                    NarratorBookCard(
                                      title: "Tự Tin",
                                      color: Colors.red[100]!,
                                      isPurchased: true,
                                    ),
                                    NarratorBookCard(
                                      title: "Cuộc Hành Trình",
                                      color: Colors.blue[100]!,
                                      isPurchased: true,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Publisher section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          "A",
                                          style: TextStyle(
                                            color: Colors.orange[800],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Cùng nhà xuất bản",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Alphabooks",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 180,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: const [
                                    PublisherBookCard(
                                      title: "NAPOLEON ĐẠI ĐẾ",
                                      author: "ANDREW ROBERTS",
                                      color: Colors.black,
                                      isPurchased: true,
                                      tokenInfo: "1 THẺ FONOS",
                                    ),
                                    PublisherBookCard(
                                      title:
                                          "21 PHẨM CHẤT VÀNG CỦA NHÀ LÃNH ĐẠO",
                                      author: "JOHN C. MAXWELL",
                                      color: Color(0xFFFFE082),
                                      isPurchased: true,
                                      tokenInfo: "1 THẺ FONOS",
                                    ),
                                    PublisherBookCard(
                                      title: "Nhà Việc",
                                      author: "Author",
                                      color: Color(0xFFBBDEFB),
                                      isPurchased: true,
                                      tokenInfo: "1 THẺ FONOS",
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 40),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
