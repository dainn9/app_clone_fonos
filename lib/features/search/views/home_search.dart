import 'package:flutter/material.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  final TextEditingController _searchController = TextEditingController();
  final Color primaryColor = const Color(0xFFFF5722); // Màu chính của ứng dụng

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity, // Chiều cao nền phía dưới
          color: Color(0xFF2B3A5C), // Màu nền chính
        ),
          Positioned(
            top: 10, // Nằm chồng lên phần nền dưới
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Màu của layer trên
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27),
                  topRight: Radius.circular(27),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  const SizedBox(height: 20),
                  // Categories
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // Top Categories
                          Row(
                            children: [
                              Expanded(
                                child: _buildCategoryCard(
                                  title: 'Sách Nói',
                                  color: const Color(0xFF3A72B0),
                                  icon: Icons.book,
                                  iconColor: Colors.lightBlue[300]!,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildCategoryCard(
                                  title: 'PodCourse',
                                  color: const Color(0xFF5A47B0),
                                  icon: Icons.podcasts,
                                  iconColor: Colors.purpleAccent[100]!,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildCategoryCard(
                                  title: 'English',
                                  color: const Color(0xFFA84747),
                                  icon: Icons.language,
                                  iconColor: Colors.redAccent[100]!,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Rankings
                          Row(
                            children: [
                              Expanded(
                                child: _buildRankingCard(
                                  title: 'Sách Nói',
                                  color: const Color(0xFF3A72B0),
                                  icon: Icons.star,
                                  iconColor: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildRankingCard(
                                  title: 'Reviewer',
                                  color: const Color(0xFFB08A3A),
                                  icon: Icons.star,
                                  iconColor: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Small Categories Grid
                          GridView.count(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 16,
                            children: [
                              _buildSmallCategory(
                                'Ebook',
                                Icons.menu_book,
                                Colors.orange,
                              ),
                              _buildSmallCategory(
                                'Tóm tắt',
                                Icons.description,
                                Colors.green,
                              ),
                              _buildSmallCategory(
                                'Thiền',
                                Icons.spa,
                                Colors.teal,
                              ),
                              _buildSmallCategory(
                                'Truyện ngủ',
                                Icons.nightlight,
                                Colors.indigo,
                              ),
                              _buildSmallCategory(
                                'Nhạc',
                                Icons.music_note,
                                Colors.pink,
                              ),
                              _buildSmallCategory(
                                'Thiếu nhi',
                                Icons.child_care,
                                Colors.brown,
                              ),
                              _buildSmallCategory(
                                'Podcast',
                                Icons.mic,
                                Colors.orange,
                              ),
                              // Empty space for the last item
                              const SizedBox(),
                            ],
                          ),

                          // Thêm padding ở dưới cùng để tránh bị che bởi thanh điều hướng
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Thêm hiệu ứng gradient để màu sắc trông sáng hơn
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.7), color],
              ),
            ),
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.play_arrow, color: Colors.white, size: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingCard({
    required String title,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.7), color],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bảng xếp hạng',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(icon, color: iconColor, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCategory(String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Color(0xFF333333), fontSize: 12),
        ),
      ],
    );
  }
}
