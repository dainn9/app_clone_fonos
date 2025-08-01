import 'package:app_clone_fonos/features/explore/widgets/book_carousel.dart';
import 'package:app_clone_fonos/features/explore/widgets/book_new_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/book_list.dart';
import '../../../services/book_service.dart';
import '../../../services/category_service.dart';
import '../../all_books/views/all_books_screen.dart';
import '../../category_list/viewmodels/category_viewmodel.dart';
import '../viewmodels/explore_viewmodel.dart';
import '../../category_list/views/categories_list.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCarousel(),
              // Top trending audiobooks section
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
                child: SectionHeader(
                  title: 'Top Sách Nói Thịnh Hành',
                  trailingTitleIcon: FontAwesomeIcons.trophy,
                  trailingTitleIconColor: Colors.amber,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooksScreen(title: 'Top Sách Nói Thịnh Hành',viewModel: ExploreViewModel(context.read<BookService>())..fetchTopRatingBooks())));
                  },
                ),
              ),
              SizedBox(
                height: 250,
                child: BookListWidget<ExploreViewModel>(
                  viewModel: ExploreViewModel(context.read<BookService>())..fetchTopRatingBooks(limit: 10), showIndex: true, title: 'Top Sách Nói Thịnh Hành'
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: SectionHeader(
                  title: 'Mới xuất bản',
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooksScreen(title: 'Mới xuất bản',viewModel: ExploreViewModel(context.read<BookService>())..fetchNewBooks())));
                  },
                ),
              ),

              SizedBox(
                height: 420,
                child: BookNewList(),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 12,right: 12),
                child: SectionHeader(
                  title: 'Danh mục sách nói',
                ),
              ),

              ChangeNotifierProvider(
                create: (_) => CategoryViewModel(CategoryService())..fetchCategories(),
                child: CategoriesList(),
              )

              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
