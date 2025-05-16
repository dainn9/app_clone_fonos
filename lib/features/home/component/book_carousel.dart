import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../provider/book_provider.dart';
import '../view/book_detail_screen.dart';

class BookCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookProvider()..fetchBooks(limit: 5),
      child: _BookCarouselContent(),
    );
  }
}

class _BookCarouselContent extends StatefulWidget {
  @override
  _BookCarouselContentState createState() => _BookCarouselContentState();
}

class _BookCarouselContentState extends State<_BookCarouselContent> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1000, viewportFraction: 0.7);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentPage = _pageController.initialPage.toDouble();
      });
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Container(
            height: 400,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.books.isEmpty) {
          return Container(
            height: 400,
            child: Center(child: Text('Không có sách nào')),
          );
        }

        final booksCount = provider.books.length;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF2B3A5C), // Màu ở trên
                Colors.white, // Màu ở dưới
              ],
            ),
          ),
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            itemCount: null,
            itemBuilder: (context, index) {
              final actualIndex = index % booksCount;
              final book = provider.books[actualIndex];

              double distanceFromCenter = (_currentPage - index).abs();
              double scale = max(0.9, 1.0 - (distanceFromCenter * 0.1));
              double verticalAlignment = Curves.easeOutQuint.transform(
                max(0, 1 - distanceFromCenter),
              );

              return Transform.scale(
                scale: scale,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailScreen(id: book.bookId!),
                        ),
                      );
                    },
                    child: Container(
                      height: 350 * verticalAlignment,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
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
                            imageUrl: book.coverImageUrl!,
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => Container(
                                  color: Colors.grey.shade200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Icon(Icons.error),
                          ),

                          // Lớp phủ tối
                          Container(color: Colors.black.withOpacity(0.3)),

                          // Tiêu đề sách
                          Center(
                            child: Text(
                              book.title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
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
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
