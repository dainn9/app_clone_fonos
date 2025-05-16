import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/design_systems/design_system_export.dart';
import '../provider/book_provider.dart';
import '../view/book_detail_screen.dart';
import 'book_item.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookProvider()..fetchBooksTopRating(limit: 10),
      child: _BookListContent(),
    );
  }
}

class _BookListContent extends StatefulWidget {
  @override
  _BookListScreenContentState createState() => _BookListScreenContentState();
}

class _BookListScreenContentState extends State<_BookListContent> {
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
          height: 250, // Chiều cao cố định cho từng item
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            itemCount: provider.books.length + 1,
            itemBuilder: (context, index) {
              if (index == provider.books.length) {
                return GestureDetector(
                  onTap: () {
                    // TODO: Xử lý khi nhấn vào nút xem tất cả
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooksScreen()));
                  },
                  child: Container(
                    width: 40, // hoặc size mong muốn
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                );
              }

              final book = provider.books[index];
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                // Khoảng cách giữa các item
                child: BookCoverImage(
                  book: book,
                  width: 130,
                  // Rộng từng quyển sách
                  height: 200,
                  index: index + 1,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailScreen(id: book.bookId!),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
