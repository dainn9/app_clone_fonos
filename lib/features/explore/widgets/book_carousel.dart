import 'package:app_clone_fonos/features/explore/viewmodels/explore_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Thêm thư viện
import 'package:provider/provider.dart';
import '../../../services/book_service.dart';
import '../../book_detail/views/book_detail_screen.dart';

class BookCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExploreViewModel>(
      create: (_) => ExploreViewModel(context.read<BookService>())..fetchCarouselBooks(limit: 5),
      child: _BookCarouselContent(),
    );
  }
}

class _BookCarouselContent extends StatefulWidget {
  @override
  _BookCarouselContentState createState() => _BookCarouselContentState();
}

class _BookCarouselContentState extends State<_BookCarouselContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreViewModel>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const SizedBox(
            height: 400,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.books.isEmpty) {
          return SizedBox(
            height: 400,
            child: Center(child: Text('Không có sách nào (${provider.errorMessage})')),
          );
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2B3A5C),
                Colors.white,
              ],
            ),
          ),
          height: 450,
          child: CarouselSlider.builder(
            itemCount: provider.books.length,
            itemBuilder: (context, index, realIndex) {
              final book = provider.books[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(id: book.bookId),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Ảnh nền
                      CachedNetworkImage(
                        imageUrl: book.coverImageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      // Lớp phủ tối
                      Container(color: Colors.black.withOpacity(0.3)),
                      // Tiêu đề sách
                      Center(
                        child: Text(
                          book.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 6.0,
                                color: Colors.black45,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            options: CarouselOptions(
              initialPage: 0,
              viewportFraction: 0.7,
              enlargeCenterPage: true, // Phóng to item trung tâm
              enableInfiniteScroll: true, // Vòng lặp vô hạn
              autoPlay: false, // Tắt tự động cuộn (tùy chọn)
              height: 400,
              enlargeStrategy: CenterPageEnlargeStrategy.scale, // Hiệu ứng scale giống code cũ
              onPageChanged: (index, reason) {
                // Có thể thêm logic nếu cần theo dõi trang hiện tại
              },
            ),
          ),
        );
      },
    );
  }
}