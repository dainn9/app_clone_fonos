import 'package:app_clone_fonos/features/author_detail/models/author_detail_model.dart';
import '../../../core/design_systems/design_system_export.dart';

class AuthorListTile extends StatelessWidget {
  final AuthorDetailModel author;
  final VoidCallback onTap;

  const AuthorListTile({Key? key, required this.author, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child:
                   author.imageUrl.isNotEmpty
                      ? Image.network(
                        author.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.shade300,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey.shade600,
                            ),
                          );
                        },
                      )
                      : Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.person, color: Colors.grey.shade600),
                      ),
            ),
            const SizedBox(width: 16),

            // Tên tác giả
            Expanded(
              child: Text(
                author.authorName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F3351),
                ),
              ),
            ),

            // Icon mũi tên
            const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
