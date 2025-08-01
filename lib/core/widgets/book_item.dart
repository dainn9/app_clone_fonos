import 'package:flutter/material.dart';
import '../../features/book_detail/views/book_detail_screen.dart';

class WorkItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const WorkItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BookDetailScreen(id: id)),
        );
      },
      child: Container(
        height: 100,
        decoration: _containerDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BookImage(imageUrl: imageUrl),
            _BookInfo(title: title),
          ],
        ),
      ),
    );
  }

  BoxDecoration get _containerDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

class _BookImage extends StatelessWidget {
  final String imageUrl;

  const _BookImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      ),
      child: Image.network(
        imageUrl,
        width: 70,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 70,
            height: 100,
            color: Colors.grey.shade300,
            child: const Icon(Icons.book, color: Colors.grey),
          );
        },
      ),
    );
  }
}

class _BookInfo extends StatelessWidget {
  final String title;

  const _BookInfo({required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

