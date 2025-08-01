import 'package:flutter/material.dart';
import '../../../core/models/book/book_model.dart';
import '../../../core/widgets/book_item.dart';

class WorkListAllBook extends StatelessWidget {
  final List<BookModel> books;

  const WorkListAllBook({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
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
      children: books.map((book) {
        return Column(
          children: [
            WorkItem(
              id: book.bookId,
              title: book.title,
              imageUrl: book.coverImageUrl,
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }
}

