import 'package:app_clone_fonos/features/category_list/models/book_by_category_model.dart';
import 'package:flutter/material.dart';
import '../../book_detail/views/book_detail_screen.dart';

class WorkListCategory extends StatelessWidget {
  final List<BookByCategoryModel> booksByCategory;

  const WorkListCategory({super.key, required this.booksByCategory});

  @override
  Widget build(BuildContext context) {
    if (booksByCategory.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Không có tác phẩm nào',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: booksByCategory.map((bookByCategory) {
        return Column(
          children: [
            _WorkItem(
              id: bookByCategory.book.bookId,
              title: bookByCategory.book.title,
              imageUrl: bookByCategory.book.coverImageUrl,
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
}

class _WorkItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const _WorkItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
                    child: const Icon(Icons.book, color: Colors.grey),
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
