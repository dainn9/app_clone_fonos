// import 'package:flutter/material.dart';
//
// class MembershipCard extends StatelessWidget {
//   final String
//   title; // Nội dung chính của card (ví dụ: "Miễn phí Cho hội viên")
//   final List<Widget> children; // Phần nội dung con (children) bên dưới card
//
//   const MembershipCard({
//     super.key,
//     required this.title,
//     required this.children,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Card chính
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Nội dung chính (ví dụ: "Miễn phí Cho hội viên")
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               // Mũi tên qua phải
//               const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8), // Khoảng cách giữa card và children
//         // Phần children (nội dung bên dưới)
//         ...children,
//       ],
//     );
//   }
// }
