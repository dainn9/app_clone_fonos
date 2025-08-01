import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../../explore/viewmodels/explore_viewmodel.dart';
import '../widgets/custom_header.dart';
import '../widgets/work_list_all_book.dart';

class AllBooksScreen extends StatelessWidget {
  final ExploreViewModel viewModel;
  final String? title;

  const AllBooksScreen({super.key, required this.viewModel, this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExploreViewModel>.value(
      value: viewModel,
      child: _AllBookContent(title: title ?? ''),
    );
  }
}

class _AllBookContent extends StatelessWidget {
  final String title;

  const _AllBookContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreViewModel>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final books = provider.books;

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

                        WorkListAllBook(books: books),

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
