import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../viewmodels/category_viewmodel.dart';
import '../widgets/category_item.dart';

class CategoriesList extends StatelessWidget {
  final double spacing;
  final Color backgroundColor;
  final Color textColor;

  const CategoriesList({
    super.key,
    this.spacing = 16.0,
    this.backgroundColor = const Color(0xFFD7E6F5),
    this.textColor = const Color(0xFF1A3353),
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, categoryViewModel, child) {
        if (categoryViewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoryViewModel.errorMessage != null) {
          return Center(
            child: Text(
              categoryViewModel.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final categories = categoryViewModel.categories;

        if (categories.isEmpty) {
          return const Center(child: Text('Không có danh mục nào.'));
        }

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
      },
    );
  }
}
