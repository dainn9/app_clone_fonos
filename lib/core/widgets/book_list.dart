import 'package:app_clone_fonos/core/models/book/book_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../features/all_books/views/all_books_screen.dart';
import '../../features/explore/viewmodels/explore_viewmodel.dart';
import '../../services/book_service.dart';
import '../design_systems/design_system_export.dart';
import '../../features/book_detail/views/book_detail_screen.dart';
import '../viewmodels/base_book_list_viewmodel.dart';
import 'book_item.dart';

class BookListWidget<T extends ChangeNotifier> extends StatelessWidget {
  final T viewModel;
  final bool showIndex;

  const BookListWidget({
    super.key,
    required this.viewModel,
    this.showIndex = false, // Mặc định là false nếu không truyền
  });


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: _BookListContent<T>(showIndex: showIndex),
    );
  }
}

class _BookListContent<T extends ChangeNotifier> extends StatelessWidget {
  final bool showIndex;
  const _BookListContent({super.key, required this.showIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, child) {
        final bookProvider = provider as BaseBookListViewModel;
        if (bookProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (bookProvider.books.isEmpty) {
          return const Center(child: Text('Không có sách nào'));
        }

        return SizedBox(
          height: 250, // Chiều cao cố định cho từng item
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            itemCount: bookProvider.books.length + 1,
            itemBuilder: (context, index) {
              if (index == bookProvider.books.length) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooksScreen(title: 'ád',)));
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

              final BookModel book = bookProvider.books[index];

              return Padding(
                padding: const EdgeInsets.only(right: 5),
                // Khoảng cách giữa các item
                child: BookCoverImage(
                  book: book,
                  width: 130,
                  // Rộng từng quyển sách
                  height: 200,
                  index: index + 1,
                  indexView: showIndex,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailScreen(id: book.bookId),
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


// @override
// Widget build(BuildContext context) {
//   return ChangeNotifierProvider<ExploreViewModel>(
//     create: (_) => ExploreViewModel(context.read<BookService>())..fetchTopRatingBooks(limit: 10),
//     child: _BookListContent(),
//   );
// }