import 'package:app_clone_fonos/features/category_list/widgets/work_list_category.dart';
import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../../../services/category_service.dart';
import '../../all_books/widgets/custom_header.dart';
import '../viewmodels/category_viewmodel.dart';

class BooksByCategoryScreen extends StatelessWidget {
  final String categoryId;
  final String title;

  const BooksByCategoryScreen({super.key, required this.categoryId,required this.title});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final categoryService = context.read<CategoryService>();
        return ChangeNotifierProvider(
          create: (_) => CategoryViewModel(categoryService)..fetchBooksByCategory(categoryId),
          child: _AllBookContent(title: title),
        );
      },
    );
  }
}

class _AllBookContent extends StatelessWidget {
  final String title;

  const _AllBookContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryViewModel>(
      builder: (context, categoryViewModel, child) {

        if (categoryViewModel.isLoading) {
          return const Scaffold(
            backgroundColor: AppColors.playerBackgroundDefault,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (categoryViewModel.errorMessage != null) {
          return Scaffold(
            backgroundColor: AppColors.playerBackgroundDefault,
            body: Center(
              child: Text(
                categoryViewModel.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }


        final booksByCategory = categoryViewModel.bookListByCategory;

        return Scaffold(
          backgroundColor: AppColors.playerBackgroundDefault,
          body: SafeArea(
            child: Column(
              children: [
                CustomHeader(title: title),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      children: [
                        const Text(
                          'Tất cả sách',
                          style: TextStyle(fontSize: 16),
                        ),
                        // Phần tác phẩm
                        const SizedBox(height: 20),

                        WorkListCategory(booksByCategory: booksByCategory!),

                        // Thêm padding ở cuối để tránh bị che bởi thanh điều hướng
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
