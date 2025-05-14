// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// import '../model/book.dart';
//
// class BookItem extends StatelessWidget {
//   final Book book;
//
//   const BookItem({super.key, required this.book});
//
//   // Hàm hiển thị dialog chi tiết
//   void _showBookDetails(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(book.title),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CachedNetworkImage(
//                   imageUrl: book.coverUrl,
//                   width: 150,
//                   height: 225,
//                   fit: BoxFit.cover,
//                   placeholder:
//                       (context, url) =>
//                           const Center(child: CircularProgressIndicator()),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Rank: ${book.rank}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Description: ${book.description}',
//                   style: const TextStyle(fontSize: 14),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Author: ${book.author}',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showBookDetails(context),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Sử dụng Stack để đặt số thứ hạng nhô ra ngoài ảnh
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 // Ảnh bìa sách (đã bo góc)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: CachedNetworkImage(
//                     imageUrl: book.coverUrl,
//                     width: 100,
//                     height: 150,
//                     fit: BoxFit.cover,
//                     placeholder:
//                         (context, url) =>
//                             const Center(child: CircularProgressIndicator()),
//                     errorWidget:
//                         (context, url, error) => const Icon(Icons.error),
//                   ),
//                 ),
//                 // Hiển thị số thứ hạng nếu book.rank có giá trị và lớn hơn 0
//                 if (book.rank > 0)
//                   Positioned(
//                     top: -10,
//                     left: -10,
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: Colors.blue[800],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Text(
//                           book.rank.toString(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(width: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }
