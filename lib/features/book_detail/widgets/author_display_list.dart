import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../../author_detail/models/author_detail_model.dart';
import '../../author_detail/viewmodels/author_viewmodel.dart';
import '../../author_detail/views/author_detail.dart';
import 'author_list_title.dart';

class AuthorDisplayList extends StatelessWidget {
  const AuthorDisplayList({super.key});

  void _showAuthorsBottomSheet(BuildContext context, List<AuthorDetailModel> authors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Thanh kéo ở trên cùng
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Tiêu đề
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Tác giả',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F3351),
                  ),
                ),
              ),

              // Danh sách tác giả
              ...authors
                  .map(
                    (author) => Column(
                      children: [
                        AuthorListTile(
                          author: author,
                          onTap: () {
                            // Xử lý khi nhấn vào tác giả
                            Navigator.pop(context);
                            // Điều hướng đến trang chi tiết tác giả nếu cần
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AuthorDetailScreen(
                                      id: author.authorId,
                                    ),
                              ),
                            );
                          },
                        ),
                        if (author != authors.last) const Divider(height: 1),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorViewModel>(
      builder: (context, authorViewModel, _) {
        if (authorViewModel.isLoading) {
          return CircularProgressIndicator(color: Colors.white);
        }

        final authors = authorViewModel.authors;

        if (authors.isEmpty) {
          return Text(
            'Không có tác giả',
            style: TextStyle(fontSize: 16, color: Colors.white),
          );
        }

        // Ghép tên tác giả lại
        final authorNames = authors.map((a) => a.authorName).join(', ');

        return GestureDetector(
          onTap: () {
            _showAuthorsBottomSheet(context, authors);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                authorNames,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: Colors.white70, size: 20),
            ],
          ),
        );
      },
    );
  }
}
