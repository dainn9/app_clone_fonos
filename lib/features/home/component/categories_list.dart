import 'package:flutter/material.dart';

import '../../../models/category/category.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;
  final double spacing;
  final Color backgroundColor;
  final Color textColor;

  const CategoriesList({
    Key? key,
    required this.categories,
    this.spacing = 16.0,
    this.backgroundColor = const Color(0xFFD7E6F5),
    this.textColor = const Color(0xFF1A3353),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryItem(
          category: category,
          backgroundColor: backgroundColor,
          textColor: textColor,
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final Color backgroundColor;
  final Color textColor;

  const CategoryItem({
    Key? key,
    required this.category,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // on tap
      onTap: category.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),

        child: Row(
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  category.emoji!,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Category name
            Expanded(
              child: Text(
                category.categoryName!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
