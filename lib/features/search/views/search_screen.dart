import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodels/search_viewmodel.dart';
import '../../../core/widgets/book_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Color primaryColor = const Color(0xFFFF5722); // Màu chính của ứng dụng
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final vm = context.read<SearchViewModel>();

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final trimmed = query.trim();
      if (trimmed.isNotEmpty) {
        vm.fetchSuggestions(trimmed);
      } else {
        vm.clearSuggestions(); // 👈 gọi hàm mới để xóa kết quả
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SearchViewModel>();
    final isSearching = _searchController.text.trim().isNotEmpty;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF2B3A5C),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    hintText: 'Nhập từ khoá...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              if (vm.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                )
              else if (isSearching)
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: vm.books.length,
                      itemBuilder: (context, index) {
                        final book = vm.books[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12), // khoảng cách giữa các item
                          child: WorkItem(
                            id: book.bookId,
                            title: book.title,
                            imageUrl: book.coverImageUrl,
                          ),
                        );
                      },
                    ),
                  ),
                )
              else
              // 👉 chỉ hiển thị phần danh mục khi không tìm kiếm
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27),
                        topRight: Radius.circular(27),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
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
                          GridView.count(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 16,
                            children: [
                              _buildSmallCategory('Ebook', Icons.menu_book, Colors.orange),
                              _buildSmallCategory('Tóm tắt', Icons.description, Colors.green),
                              _buildSmallCategory('Thiền', Icons.spa, Colors.teal),
                              _buildSmallCategory('Truyện ngủ', Icons.nightlight, Colors.indigo),
                              _buildSmallCategory('Nhạc', Icons.music_note, Colors.pink),
                              _buildSmallCategory('Thiếu nhi', Icons.child_care, Colors.brown),
                              _buildSmallCategory('Podcast', Icons.mic, Colors.orange),
                              const SizedBox(), // slot trống
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
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
