import 'package:app_clone_fonos/features/home/provider/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/book_components/action_button.dart';
import '../../components/book_components/book_info_row.dart';
import '../../components/section_headers/section_header.dart';
import '../component/expandable_text.dart';
import '../component/favorite_button.dart';
import '../provider/book_provider.dart';

class BookDetailScreen extends StatelessWidget {
  final String id;
  const BookDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BookProvider>(
          create: (_) => BookProvider()..fetchBookDetail(id),
        ),
        ChangeNotifierProvider<AuthorProvider>(
          create: (_) => AuthorProvider()..fetchAuthors(id),
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
  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Container(
            height: 400,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        //
        if (provider.selectBook == null) {
          return Container(
            height: 400,
            child: Center(child: Text('Không có sách nào')),
          );
        }

        final book = provider.selectBook!;
        return Scaffold(
          body: Container(
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // top bar
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Spacer(),
                          FavoriteButton(),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    // anh bia
                    Center(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 180,
                              height: 280,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(book.coverImageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // title
                          Text(
                            book.title!,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Consumer<AuthorProvider>(
                            builder: (context, authorProvider, _) {
                              if (authorProvider.isLoading) {
                                return CircularProgressIndicator(color: Colors.white);
                              }

                              final authors = authorProvider.authors;

                              if (authors.isEmpty) {
                                return Text(
                                  'Không có tác giả',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                );
                              }

                              // Ghép tên tác giả lại
                              final authorNames = authors.map((a) => a.authorName).join(', ');

                              return GestureDetector(
                                onTap: () {
                                  // Mở trang danh sách tác giả nếu cần
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      authorNames ,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: book.rating != null && book.rating! > 0 ? Colors.amber : Colors.white,
                                size: 22,
                              ),
                              SizedBox(width: 4),
                              Text(
                                (book.rating != null && book.rating! > 0)
                                    ? '${book.rating?.toStringAsFixed(1) ?? '0.0'} (${book.numberOfReviews} đánh giá)'
                                    : 'Chưa đánh giá',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: book.rating != null && book.rating! > 0 ? Colors.amber : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 10,
                            ),
                            child: Expanded(
                              child: ActionButton(
                                text: "Bắt đầu nghe",
                                icon: Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
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
                                  child: SectionHeader(
                                    title: 'Giới thiệu nội dung',
                                  ),
                                ),

                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: ExpandableText(
                                    text: book.description!,
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
                                  duration: book.audiobook!.duration!,
                                  publisher: book.publisher!.publisherName!,
                                  onPublisherTap: () {},
                                ),

                                //muc luc
                                Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: SectionHeader(title: 'Mục lục'),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: SectionHeader(
                                    title: 'Cùng thể loại',
                                    onPress: () {},
                                  ),
                                ),
                                // rating
                                Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: SectionHeader(
                                    title: 'Người nghe nói gì',
                                  ),
                                ),
                              ],
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
        );
      },
    );
  }
}
