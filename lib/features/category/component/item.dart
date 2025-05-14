// import 'package:flutter/material.dart';
//
// class CategoryItem extends StatelessWidget {
//   final String emoji;
//   final String content;
//
//   const CategoryItem({super.key, required this.emoji, required this.content});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min, // Để Row chỉ chiếm không gian cần thiết
//         children: [
//           // Emoji
//           Text(emoji, style: const TextStyle(fontSize: 16)),
//           const SizedBox(width: 8), // Khoảng cách giữa emoji và text
//           // Nội dung
//           Text(
//             content,
//             style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//           ),
//         ],
//       ),
//     );
//   }
// }
