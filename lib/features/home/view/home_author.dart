import 'package:flutter/material.dart';

class HomeAuthor extends StatefulWidget {
  const HomeAuthor({super.key});

  @override
  State<HomeAuthor> createState() => _HomeAuthorState();
}

class _HomeAuthorState extends State<HomeAuthor> {
  bool _isExpanded = false;
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Tất cả', 'PodCourse', 'Sách nói'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A4D80),
      body: SafeArea(
        child: Column(
          children: [
            // Header với nút quay lại và ảnh tác giả
            _buildHeader(),

            // Phần thân với thông tin tác giả và tác phẩm
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Phần giới thiệu
                    _buildIntroduction(),

                    // Phần tác phẩm
                    _buildWorks(),

                    // Thêm padding ở cuối để tránh bị che bởi thanh điều hướng
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Nút quay lại
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                  iconSize: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Ảnh tác giả
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://randomuser.me/api/portraits/women/76.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Vai trò
          const Text(
            'Tác giả / Mentor',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 4),

          // Tên tác giả
          const Text(
            'Xuân Phượng',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Giới thiệu',
            style: TextStyle(
              color: Color(0xFF2A4D80),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Nội dung giới thiệu
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nguyễn Thị Xuân Phượng sinh năm 1929 tại làng Nhâm Biều, huyện Phong Trà, tỉnh Thừa Thiên - Huế. Năm 16 tuổi (1945) bà thoát ly gia đình, xếp bút nghiên lên đường tranh đấu giành độc lập cho đất nước. Bà từng làm nhiều nghề như thiện kỹ thuật viên thuốc nổ, y tá, phóng viên bản tin k...',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              // Nút xem thêm
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isExpanded ? 'Thu gọn' : 'Xem thêm',
                      style: const TextStyle(
                        color: Color(0xFF2A4D80),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: const Color(0xFF2A4D80),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(),
        ],
      ),
    );
  }

  Widget _buildWorks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề phần tác phẩm
          const Row(
            children: [
              Text(
                'Tác phẩm',
                style: TextStyle(
                  color: Color(0xFF2A4D80),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '(3)',
                style: TextStyle(
                  color: Color(0xFF2A4D80),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Tabs
          SizedBox(
            height: 36, // Giảm chiều cao
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2A4D80) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13, // Giảm kích thước chữ
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Danh sách tác phẩm
          _buildWorksList(),
        ],
      ),
    );
  }

  Widget _buildWorksList() {
    return Column(
      children: [
        // Tác phẩm 1
        _buildWorkItem(
          title: 'Lựa Chọn Lối Đi Riêng: Kinh Nghiệm Từ 95 Năm Cuộc Đời',
          author: 'Nguyễn Thị Xuân Phượng',
          imageUrl: 'https://randomuser.me/api/portraits/women/76.jpg',
          type: 'PODCOURSE',
        ),

        const SizedBox(height: 16),

        // Tác phẩm 2 (chỉ hiển thị một phần)
        _buildWorkItem(
          title: 'Tên sách khác',
          author: 'Nguyễn Thị Xuân Phượng',
          imageUrl: 'https://randomuser.me/api/portraits/women/76.jpg',
          type: 'SÁCH NÓI',
          isPurchased: true,
        ),
      ],
    );
  }

  Widget _buildWorkItem({
    required String title,
    required String author,
    required String imageUrl,
    required String type,
    bool isPurchased = false,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh bìa
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: Image.network(
              imageUrl,
              width: 70, // Giảm kích thước ảnh
              height: 100,
              fit: BoxFit.cover,
            ),
          ),

          // Thông tin sách
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Giảm padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Loại sách
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9, // Giảm kích thước chữ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Tiêu đề
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 13, // Giảm kích thước chữ
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Tác giả
                  Text(
                    author,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 11, // Giảm kích thước chữ
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Trạng thái đã mua (nếu có)
                  if (isPurchased)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'ĐÃ MUA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9, // Giảm kích thước chữ
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
