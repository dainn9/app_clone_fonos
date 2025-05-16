import 'package:app_clone_fonos/core/design_systems/design_system_export.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../models/book/book.dart';

// Component hiển thị ảnh bìa sách
class BookCoverImage extends StatelessWidget {
  final Book book;
  final double width;
  final double height;
  final BoxFit fit;
  final VoidCallback? onTap;
  final int? index;

  const BookCoverImage({
    Key? key,
    required this.book,
    this.width = 200,
    this.height = 300,
    this.fit = BoxFit.cover,
    this.onTap,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: book.coverImageUrl!,
                fit: fit,
                placeholder:
                    (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
              ),
            ),
          ),
          if (index != null) ...[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 2,
                  bottom: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryRank,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
