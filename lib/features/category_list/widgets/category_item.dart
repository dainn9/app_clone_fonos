import 'package:app_clone_fonos/features/category_list/models/category_model.dart';
import 'package:app_clone_fonos/features/category_list/views/books_by_category_screen.dart';

import '../../../core/design_systems/design_system_export.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final Color backgroundColor;
  final Color textColor;

  const CategoryItem({
    required this.category,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => BooksByCategoryScreen(
                  categoryId: category.categoryId,
                  title: category.categoryName,
                ),
          ),
        );
      },
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
              child: ClipOval(
                child: Image.network(
                  category.imageUrl, // Thay vì category.emoji
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 16),
            // Category name
            Expanded(
              child: Text(
                category.categoryName,
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
