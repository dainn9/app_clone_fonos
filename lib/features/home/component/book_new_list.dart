import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/design_systems/design_system_export.dart';
import '../provider/book_provider.dart';
import '../view/book_detail_screen.dart';
import 'book_item.dart';

class BookNewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookProvider()..fetchBooks(limit: 10),
      child: _BookNewListContent(),
    );
  }
}

class _BookNewListContent extends StatefulWidget {
  @override
  _BookListScreenContentState createState() => _BookListScreenContentState();
}

class _BookListScreenContentState extends State<_BookNewListContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.books.isEmpty) {
          return const Center(child: Text('Không có sách nào'));
        }

        return SizedBox(
          height: 420, // Chiều cao cố định cho từng item
          child: GridView.count(
            crossAxisCount: 2,
            // 2 hàng
            scrollDirection: Axis.horizontal,
            // cuộn ngang
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 8,
            children: List.generate(provider.books.length + 1, (index) {
              if (index == provider.books.length) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Xử lý khi nhấn vào nút xem tất cả
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.arrowRight,
                          size: 20,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                );
              }


              final book = provider.books[index];
              return BookCoverImage(
                book: book,
                width: 150,
                // Rộng từng quyển sách
                height: 200,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(id: book.bookId!),
                    ),
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
