import 'package:app_clone_fonos/features/author_detail/viewmodels/author_viewmodel.dart';
import 'package:app_clone_fonos/features/book_detail/viewmodels/book_detail_viewmodel.dart';
import 'package:app_clone_fonos/features/book_detail/widgets/author_display_list.dart';
import 'package:app_clone_fonos/services/book_author_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/book_list.dart';
import '../../../core/widgets/section_header.dart';
import '../../../services/book_service.dart';
import '../../components/book_components/action_button.dart';
import '../../components/book_components/book_info_row.dart';
import '../../../core/widgets/expandable_text.dart';
import '../../home/view/audio_player_screen.dart';
import '../widgets/chapter_display_list.dart';
import '../widgets/circle_icon_button_book.dart';
import '../widgets/favorite_button.dart';

class BookDetailScreen extends StatelessWidget {
  final String id;

  const BookDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookDetailViewModel>(
          create:
              (_) =>
                  BookDetailViewModel(context.read<BookService>())
                    ..fetchDetailBooks(id),
        ),
        ChangeNotifierProvider<AuthorViewModel>(
          create:
              (_) =>
                  AuthorViewModel(context.read<BookAuthorService>())
                    ..fetchAuthors(id),
        ),
      ],
      child: _BookDetailContent(),
    );
  }
}

class _BookDetailContent extends StatefulWidget {
  @override
  _BookDetailContentState createState() => _BookDetailContentState();
}

class _BookDetailContentState extends State<_BookDetailContent> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 200 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailViewModel>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Container(
            height: 400,
            child: Center(child: const CircularProgressIndicator()),
          );
        }
        //
        if (provider.errorMessage != null) {
          return Center(child: Text('Lỗi: ${provider.errorMessage}'));
        }

        final book = provider.book;
        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4A6EA9), Color(0xFF324763)],
                    stops: [0.0, 0.3],
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 180,
                              height: 280,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(book.coverImageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // title
                          Text(
                            book.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),

                          AuthorDisplayList(),

                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color:
                                    book.rating > 0
                                        ? Colors.amber
                                        : Colors.white,
                                size: 22,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                book.rating > 0
                                    ? '${book.rating.toStringAsFixed(1)} (${book.numberOfReviews} đánh giá)'
                                    : 'Chưa đánh giá',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      book.rating > 0
                                          ? Colors.amber
                                          : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Trong BookDetailScreen
                          ActionButton(
                            text: "Bắt đầu nghe",
                            icon: Icons.play_arrow,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => AudioPlayerScreen(
                                        audiobookId: book.audiobookId,
                                        bookTitle: book.title,
                                        coverImageUrl: book.coverImageUrl,
                                        authorName:
                                            // provider.books.isNotEmpty
                                            //     ? provider.books.map((a) => a.numberOfReviews).join(', ')
                                            'Không có tác giả',
                                      ),
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                    top: 12,
                                  ),
                                  child: const SectionHeader(
                                    title: 'Giới thiệu nội dung',
                                  ),
                                ),

                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: ExpandableText(
                                    text: book.description,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    expandButtonStyle: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                BookInfoRow(
                                  duration: book.duration,
                                  publisher: book.publisherName,
                                  onPublisherTap: () {},
                                ),
                                ChapterDisplayListWidget(
                                  audiobookId: book.audiobookId,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: SectionHeader(
                                    title: book.publisherName,
                                    subtitle: 'Cùng nhà xuất bản',
                                    onPress: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: BookListWidget<BookDetailViewModel>(
                                    viewModel: BookDetailViewModel(
                                      context.read<BookService>(),
                                    )..fetchSamePublisherBooks(
                                      book.publisherId,
                                      limit: 10,
                                    ),
                                  ),
                                ),
                                // rating
                                Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: const SectionHeader(
                                    title: 'Người nghe nói gì',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  color: _isScrolled ? Color(0xFF324763) : Colors.transparent,
                  child: SafeArea(
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: Padding(
                        padding: const EdgeInsets.all(13),
                        child: CircleIconButtonBook(
                          icon: Icons.arrow_back,
                          iconColor: Colors.white,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      title: Text(
                        book.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              _isScrolled ? Colors.white : Colors.transparent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      centerTitle: true,
                      // cực kỳ quan trọng để căn giữa title
                      actions: [
                        const SizedBox(width: 10),
                        const FavoriteButton(),
                        const SizedBox(width: 10),
                        CircleIconButtonBook(
                          icon: Icons.share,
                          iconColor: Colors.white,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
