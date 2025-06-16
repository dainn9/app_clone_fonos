import 'package:app_clone_fonos/features/author_detail/viewmodels/author_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/book_author_service.dart';
import '../../book_detail/views/book_detail_screen.dart';
import '../models/book_with_author_model.dart';

class AuthorDetailScreen extends StatelessWidget {
  final String id;

  const AuthorDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthorViewModel>(
          create:
              (_) => AuthorViewModel(
                context.read<BookAuthorService>(),
              )..fetchBooksBySameAuthor(id),
        ),
      ],
      child: _AuthorDetailContent(),
    );
  }
}

class _AuthorDetailContent extends StatefulWidget {
  @override
  _AuthorDetailContentState createState() => _AuthorDetailContentState();
}

class _AuthorDetailContentState extends State<_AuthorDetailContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorViewModel>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Scaffold(
            backgroundColor: const Color(0xFF2A4D80),
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }
        final authors = provider.bookListBySameAuthor;
        if (authors == null) {
          return Scaffold(
            backgroundColor: const Color(0xFF2A4D80),
            body: Center(
              child: Text(
                'Không tìm thấy thông tin tác giả',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final booksByAuthor = provider.bookListBySameAuthor ?? [];
        return Scaffold(
          backgroundColor: const Color(0xFF2A4D80),
          body: SafeArea(
            child: Column(
              children: [
                // Header với nút quay lại và ảnh tác giả
                _buildHeader(
                  authors[0].author.imageUrl,
                  authors[0].author.authorName,
                ),

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
                        _buildIntroduction(authors[0].author.biography),

                        // Phần tác phẩm
                        _buildWorks(booksByAuthor),

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
      },
    );
  }

  Widget _buildHeader(String imageUrl, String authorName) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Nút quay lại
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints(),
                  iconSize: 15,
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
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Xử lý lỗi khi tải ảnh
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Vai trò
          const Text(
            'Tác giả / Mentor',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),

          const SizedBox(height: 4),

          // Tên tác giả
          Text(
            authorName,
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

  Widget _buildIntroduction(String biography) {
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

          // Hiển thị tiểu sử
          Text(
            biography,
            style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.5),
          ),

          const SizedBox(height: 8),

          const Divider(),
        ],
      ),
    );
  }

  Widget _buildWorks(List<BookWithAuthorModel> books) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề phần tác phẩm
          Row(
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
                '(${books.length})',
                style: TextStyle(
                  color: Color(0xFF2A4D80),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildWorksList(books),
        ],
      ),
    );
  }

  Widget _buildWorksList(List<BookWithAuthorModel> books) {
    if (books.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Không có tác phẩm nào',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children:
          books
              .map(
                (book) => Column(
                  children: [
                    _buildWorkItem(
                      id: book.book.bookId,
                      title: book.book.title,
                      author: book.author.authorName,
                      imageUrl: book.book.coverImageUrl,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
              .toList(),
    );
  }

  Widget _buildWorkItem({
    required String id,
    required String title,
    required String author,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BookDetailScreen(id: id)),
        );
      },
      child: Container(
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
                width: 70,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 100,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.book, color: Colors.grey),
                  );
                },
              ),
            ),

            // Thông tin sách
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tiêu đề
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
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
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
