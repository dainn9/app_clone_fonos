import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/design_systems/design_system_export.dart';
import '../../../services/book_service.dart';
import '../../all_books/views/all_books_screen.dart';
import '../../book_detail/views/book_detail_screen.dart';
import '../../../core/widgets/book_cover_image.dart';
import '../viewmodels/explore_viewmodel.dart';

class BookNewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExploreViewModel>(
      create: (_) => ExploreViewModel(context.read<BookService>())..fetchNewBooks(limit: 10),
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
    return Consumer<ExploreViewModel>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.books.isEmpty) {
          return Center(child: Text('Không có sách nào (${provider.errorMessage})'));
        }

        return SizedBox(
          height: 420, // Chiều cao cố định cho từng item
          child: GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 8,
            children: List.generate(provider.books.length + 1, (index) {
              if (index == provider.books.length) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Xử lý khi nhấn vào nút xem tất cả
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooksScreen(title: 'Mới xuất bản',viewModel: ExploreViewModel(context.read<BookService>())..fetchTopRatingBooks())));
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
                      builder: (_) => BookDetailScreen(id: book.bookId),
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
