import 'package:flutter/material.dart';
import 'dart:math';

class BookCarousel extends StatefulWidget {
  @override
  _BookCarouselState createState() => _BookCarouselState();
}

class _BookCarouselState extends State<BookCarousel> {
  late PageController _pageController;
  double _currentPage = 0.0;

  // Danh sách màu cho các cuốn sách
  final List<Color> bookColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  int get itemCount => bookColors.length;

  @override
  void initState() {
    super.initState();
    // Bắt đầu từ vị trí giữa của một danh sách lớn
    _pageController = PageController(
      initialPage: itemCount * 1000, // Số lớn để có thể cuộn nhiều lần
      viewportFraction: 0.7,
    );

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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2B3A5C),        // Màu ở trên
            Colors.white,       // Màu ở dưới
          ],
        ),
      ),
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        // Không giới hạn số lượng trang
        itemCount: null,
        itemBuilder: (context, index) {
          // Lấy index thực trong phạm vi của mảng màu
          final actualIndex = index % itemCount;
          // Tính toán hiệu ứng thu phóng và di chuyển
          double distanceFromCenter = (_currentPage - index).abs();
          double scale = max(0.9, 1.0 - (distanceFromCenter * 0.1));
          double verticalAlignment = Curves.easeOutQuint.transform(
              max(0, 1 - distanceFromCenter));

          return Transform.scale(
            scale: scale,
            child: Center(
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 350 * verticalAlignment,
                decoration: BoxDecoration(
                  color: bookColors[actualIndex],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Sách ${actualIndex + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
