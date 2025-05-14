import 'package:app_clone_fonos/features/home/component/book_carousel.dart';
import 'package:flutter/material.dart';
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

import '../models/book.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    // Add this at the top of your HomeScreen class
    final List<Color> colorPalette = [
      const Color(0xFF8875C7), // Purple
      const Color(0xFF5E97F6), // Blue
      const Color(0xFFFF8A65), // Orange
      const Color(0xFF4CAF50), // Green
      const Color(0xFFFF5252), // Red
      const Color(0xFFFFCA28), // Amber
    ];

    // Sample data - replace with API data
    final List<Book> topBooks = [
      Book(
        title: 'Trí tuệ xúc cảm',
        author: 'Daniel Goleman',
        color: Colors.blue[100]!,
      ),
      Book(
        title: 'CHÌA TAI LẮNG NGHE',
        author: 'Bác sĩ Nguyễn Chí Công',
        color: Colors.grey[300]!,
      ),
      Book(title: 'Cuộc sống', author: 'Tác giả', color: Colors.orange[100]!),
    ];

    final List<Podcast> podcourses = [
      Podcast(
        title: '5 Sai Lầm Đặt Giá Khi Triển Khai Trải Nghiệm Khách Hàng',
        number: '1',
      ),
      Podcast(title: 'Giao Tiếp Hiệu Quả', number: '2'),
    ];

    final List<Book> collectionBooks = [
      Book(title: '100 NGỌC SÁNG TRONG CUỘC SỐNG', author: ''),
      Book(title: 'MỘT CUỐN SÁCH HAY', author: ''),
      Book(title: 'MÃ THẦN THOẠI', author: ''),
      Book(title: 'CUỘC SỐNG TƯƠI ĐẸP', author: ''),
      Book(title: 'BÁC GIỐNG CUỘC ĐỜI', author: ''),
      Book(title: 'SỨC MẠNH TIỀM THỨC', author: ''),
    ];

    final List<Book> crmBooks = [
      Book(title: 'CỦA ĐỂ CRM', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'KHÁM PHÁ BÍ MẬT CỦA TÂM HỒN', author: '', tag: 'MIỄN PHÍ'),
      Book(title: 'PHONG CÁCH', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'XUÂN PHƯƠNG', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'PHẨM CHẤT CHÍNH MINH', author: '', tag: '1 THẺ FONOS'),
      Book(title: 'TÂM HỒN CAO THƯỢNG', author: '', tag: '1 THẺ FONOS'),
    ];

    final List<Book> newBooks = [
      Book(title: 'SƯ TRÀ THƯ CỦA ĐỊA LÝ', author: 'Robert D. Kaplan'),
      Book(
        title: 'CHUYỆN CON MÈO LÓP KÉO CẦU SÁCH',
        author: 'Natsukawa Sosuke',
      ),
      Book(title: 'THẦN AI NẤY LO', author: 'Eric Barker'),
    ];

    final List<Review> reviews = [
      Review(
        bookTitle: 'Ông Trăm Tuổi Trèo Qua Cửa Sổ và Biến Mất',
        author: 'Jonas Jonasson',
        reviewerName: 'Đỗ Hoa',
        timeAgo: '3 ngày trước',
        rating: 5,
        comment:
            'Dù câu chuyện thú vị nhưng không phải gu của mình. Dù cuốn sách khá thú vị khi kể về chuyện phiêu lưu của cụ Alan, khá đáng để đọc, nhưng nó không phải gu của mình.',
      ),
      Review(
        bookTitle: 'Đắc Nhân Tâm',
        author: 'Dale Carnegie',
        reviewerName: 'Nguyễn Văn A',
        timeAgo: '1 tuần trước',
        rating: 4,
        comment:
            'Sách hay, nhiều bài học bổ ích về cách ứng xử và giao tiếp với mọi người xung quanh.',
      ),
      Review(
        bookTitle: 'Nhà Giả Kim',
        author: 'Paulo Coelho',
        reviewerName: 'Trần Thị B',
        timeAgo: '2 tuần trước',
        rating: 5,
        comment:
            'Cuốn sách đã thay đổi cách nhìn của tôi về cuộc sống. Câu chuyện về hành trình tìm kiếm kho báu thật sự sâu sắc.',
      ),
    ];

    // Add this with your other sample data in the build method
    final List<Book> featuredBooks = [
      Book(
        title: 'Sách Nói Mới Ra Mắt',
        author: 'Tác giả nổi tiếng',
        color: Colors.purple[100]!,
      ),
      Book(
        title: 'Cuốn Sách Thịnh Hành',
        author: 'Nhà văn hàng đầu',
        color: Colors.blue[100]!,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category tabs
              Container(
                color: Color(0xFF2B3A5C),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      _buildCategoryTab('Mới & Hot', true, primaryColor),
                      const SizedBox(width: 10),
                      _buildCategoryTab('Ưu đãi', false, primaryColor),
                    ],
                  ),
                ),
              ),

              // Featured book carousel
              // FeaturedBookCarousel(books: featuredBooks),
              BookCarousel(),
              // Top trending audiobooks section
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SectionHeader(

                  title: 'Top Sách Nói Thịnh Hành',
                  subtitle: 'd',
                  onSeeAll: () {},
                ),
              ),
              //
              // Top books horizontal list
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: topBooks.length,
                  itemBuilder: (context, index) {
                    return _buildTopBook(
                      (index + 1).toString(),
                      topBooks[index].title,
                      topBooks[index].author,
                      topBooks[index].color,
                    );
                  },
                ),
              ),
              //
              // // Podcourse section
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           CircleAvatar(
              //             radius: 12,
              //             backgroundColor: primaryColor.withOpacity(0.7),
              //             child: const Icon(
              //               Icons.mic,
              //               color: Colors.white,
              //               size: 14,
              //             ),
              //           ),
              //           const SizedBox(width: 8),
              //           const Text(
              //             'PODCOURSE',
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 14,
              //             ),
              //           ),
              //         ],
              //       ),
              //       GestureDetector(
              //         onTap: () {},
              //         child: Row(
              //           children: [
              //             const Text(
              //               'Top thịnh hành hôm nay',
              //               style: TextStyle(fontSize: 12, color: Colors.grey),
              //             ),
              //             const SizedBox(width: 4),
              //             const Icon(Icons.arrow_forward_ios, size: 14),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //
              // // Podcourse horizontal list
              // SizedBox(
              //   height: 180,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     itemCount: podcourses.length,
              //     itemBuilder: (context, index) {
              //       return _buildPodcourse(
              //         podcourses[index].number,
              //         podcourses[index].title,
              //         primaryColor: primaryColor,
              //       );
              //     },
              //   ),
              // ),
              //
              // // Fonos collection
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: SectionHeader(
              //     title: 'Fonos Đoán Gu Bạn Là...',
              //     onSeeAll: () {},
              //   ),
              // ),
              //
              // // Book collection horizontal list
              // SizedBox(
              //   height: 220,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     itemCount: collectionBooks.length,
              //     itemBuilder: (context, index) {
              //       // Use RelatedBookCard component
              //       return RelatedBookCard(
              //         title: collectionBooks[index].title,
              //         author: collectionBooks[index].author,
              //         color: Colors.white,
              //         onTap: () {
              //           Navigator.pushNamed(context, '/homedetail');
              //         },
              //       );
              //     },
              //   ),
              // ),
              //
              // // CRM section
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: SectionHeader(
              //     title: 'Cảm Nhận Quà Giọng Tác Giả',
              //     onSeeAll: () {},
              //   ),
              // ),
              //
              // // CRM books horizontal list
              // SizedBox(
              //   height: 220,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     itemCount: crmBooks.length,
              //     itemBuilder: (context, index) {
              //       // Use PublisherBookCard component
              //       return PublisherBookCard(
              //         title: crmBooks[index].title,
              //         author: crmBooks[index].author,
              //         color:
              //             index % 2 == 0
              //                 ? Colors.black
              //                 : const Color(0xFFFFE082),
              //         isPurchased: true,
              //         tokenInfo: crmBooks[index].tag,
              //       );
              //     },
              //   ),
              // ),
              //
              // // Book review section
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: SectionHeader(
              //     title: 'Đánh Giá Nổi Bật',
              //     onSeeAll: () {},
              //   ),
              // ),
              //
              // // Book reviews horizontal list
              // SizedBox(
              //   height: 240,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     itemCount: reviews.length,
              //     itemBuilder: (context, index) {
              //       return _buildReviewCard(
              //         reviews[index].bookTitle,
              //         reviews[index].author,
              //         reviews[index].reviewerName,
              //         reviews[index].timeAgo,
              //         reviews[index].rating,
              //         reviews[index].comment,
              //         primaryColor: primaryColor,
              //       );
              //     },
              //   ),
              // ),
              //
              // // Recently published section
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: SectionHeader(title: 'Mới Xuất Bản', onSeeAll: () {}),
              // ),
              //
              // // Recently published books
              // SizedBox(
              //   height: 220,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     itemCount: newBooks.length,
              //     itemBuilder: (context, index) {
              //       // Use AuthorBookCard component
              //       return AuthorBookCard(
              //         title: newBooks[index].title,
              //         author: newBooks[index].author,
              //         isPurchased: true,
              //       );
              //     },
              //   ),
              // ),
              //
              // // Categories section
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: SectionHeader(
              //     title: 'Danh Mục Sách Nói',
              //     onSeeAll: () {},
              //   ),
              // ),
              //
              // // Category list
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
              //   child: Wrap(
              //     spacing: 12,
              //     runSpacing: 12,
              //     children: [
              //       _buildCategory(
              //         'Tâm lý học',
              //         Icons.psychology,
              //         primaryColor,
              //       ),
              //       _buildCategory('Kỹ năng', Icons.lightbulb, primaryColor),
              //       _buildCategory('Tư duy', Icons.emoji_objects, primaryColor),
              //       _buildCategory(
              //         'Tâm linh - Tôn giáo',
              //         Icons.auto_awesome,
              //         primaryColor,
              //       ),
              //       _buildCategory('Văn học', Icons.book, primaryColor),
              //       _buildCategory('Kinh doanh', Icons.business, primaryColor),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Include all the widget building methods from HomeScreen with optional parameters
  Widget _buildCategoryTab(String title, bool isActive, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient:
            isActive
                ? const LinearGradient(
                  colors: [Color(0xFF8875C7), Color(0xFF5E97F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : null,
        color: isActive ? null : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow:
            isActive
                ? [
                  BoxShadow(
                    color: const Color(0xFF8875C7).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
                : null,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black87,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTopBook(
    String number,
    String title,
    String author,
    Color color, {
    String? coverUrl,
  }) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child:
                      coverUrl != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              coverUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Icons.book, color: color),
                                );
                              },
                            ),
                          )
                          : Center(child: Icon(Icons.book, color: color)),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  author,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodcourse(
    String number,
    String title, {
    String? imageUrl,
    required Color primaryColor,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 160,
                height: 120,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    imageUrl != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        )
                        : const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.podcasts, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Text(
                        'PodCourse',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.play_arrow, size: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal book card for collections
  Widget _buildBookCardHorizontal(
    String title, {
    String? tag,
    String? coverUrl,
    required Color primaryColor,
  }) {
    // Generate a random color for each book
    final List<Color> colors = [
      primaryColor.withOpacity(0.3),
      Colors.green[100]!,
      Colors.orange[100]!,
      Colors.purple[100]!,
      Colors.teal[100]!,
    ];
    final Color randomColor = colors[title.length % colors.length];

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
                height: 180, // Increased height for taller book covers
                decoration: BoxDecoration(
                  color: randomColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: randomColor.withOpacity(0.8),
                    width: 1,
                  ),
                ),
                child:
                    coverUrl != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  title.split(' ').take(2).join('\n'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        randomColor
                                                    .withOpacity(1.0)
                                                    .computeLuminance() >
                                                0.5
                                            ? Colors.black87
                                            : Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        : Center(
                          child: Text(
                            title.split(' ').take(2).join('\n'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  randomColor
                                              .withOpacity(1.0)
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black87
                                      : Colors.white,
                            ),
                          ),
                        ),
              ),
              if (tag != null)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: tag == 'MIỄN PHÍ' ? Colors.green : primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewBook(
    String title,
    String author, {
    String? coverUrl,
    required Color primaryColor,
  }) {
    // Generate a random color for each book
    final List<Color> colors = [
      Colors.amber[100]!,
      primaryColor.withOpacity(0.3),
      Colors.red[100]!,
    ];
    final Color randomColor = colors[title.length % colors.length];

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
                height: 160, // Increased height for taller book covers
                decoration: BoxDecoration(
                  color: randomColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: randomColor.withOpacity(0.8),
                    width: 1,
                  ),
                ),
                child:
                    coverUrl != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  title.split(' ').take(2).join('\n'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        randomColor
                                                    .withOpacity(1.0)
                                                    .computeLuminance() >
                                                0.5
                                            ? Colors.black87
                                            : Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        : Center(
                          child: Text(
                            title.split(' ').take(2).join('\n'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  randomColor
                                              .withOpacity(1.0)
                                              .computeLuminance() >
                                          0.5
                                      ? Colors.black87
                                      : Colors.white,
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
                    color: primaryColor,
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
          const SizedBox(height: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
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
          ),
        ],
      ),
    );
  }

  // Review card for horizontal scrolling
  Widget _buildReviewCard(
    String bookTitle,
    String author,
    String reviewerName,
    String timeAgo,
    int rating,
    String comment, {
    required Color primaryColor,
  }) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 240,
        ), // Giới hạn chiều cao tối đa của card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book info section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 100,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.book, color: primaryColor, size: 32),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        author,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Reviewer info section
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFFF5F5F7),
                  child: const Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: List.generate(
                    rating,
                    (index) =>
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Comment section - using Expanded to take available space
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    comment,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),

            // "Xem thêm" button
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Xem thêm',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, IconData icon, Color primaryColor) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class FeaturedBookCarousel extends StatefulWidget {
  final List<Book> books;

  const FeaturedBookCarousel({super.key, required this.books});

  @override
  State<FeaturedBookCarousel> createState() => _FeaturedBookCarouselState();
}

class _FeaturedBookCarouselState extends State<FeaturedBookCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.books.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.books.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return FeaturedBookCard(book: widget.books[index]);
            },
          ),
        ),
        if (widget.books.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.books.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index
                            ? const Color(0xFF8875C7) // Purple accent color
                            : Colors.grey.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class FeaturedBookCard extends StatelessWidget {
  final Book book;

  const FeaturedBookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8875C7), Color(0xFF6A5CB8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8875C7).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -15,
              bottom: -15,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Book cover on the left
            Positioned(
              left: 16,
              top: 16,
              bottom: 16,
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF9C4), Color(0xFFFFECB3)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            book.title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Audio badge with only bottom left and bottom right rounded corners
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.headphones, color: Colors.white, size: 10),
                          SizedBox(width: 4),
                          Text(
                            'SÁCH NÓI MỚI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Book details
            Positioned(
              left: 132,
              top: 24,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.author,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Khám phá ngay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Play button
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A3B89), Color(0xFF362A66)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
