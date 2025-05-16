import 'package:app_clone_fonos/features/home/component/book_carousel.dart';
import 'package:app_clone_fonos/features/home/component/book_new_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/category/category.dart';
import '../../components/section_headers/section_header.dart';
import '../component/book_list.dart';
import '../component/categories_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

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
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: SectionHeader(
                  title: 'Top Sách Nói Thịnh Hành',
                  trailingTitleIcon: FontAwesomeIcons.trophy,
                  trailingTitleIconColor: Colors.amber,
                  onPress: () {},
                ),
              ),
              SizedBox(
                height: 250,
                child: BookList(),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: SectionHeader(
                  title: 'Mới xuất bản',
                  onPress: () {},
                ),
              ),

              SizedBox(
                height: 420,
                child: BookNewList(),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: SectionHeader(
                  title: 'Sách nói bạn có thể thích',
                  onPress: () {},
                ),
              ),

              // SizedBox(
              //   height: 250,
              //   child: BookList(),
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: SectionHeader(
                  title: 'Danh mục sách nói',
                  onPress: () {},
                ),
              ),

              CategoriesList(categories: categories)

              // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
