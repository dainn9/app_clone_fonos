// import 'package:flutter/material.dart';
// import '../../components/input.dart';
// import '../component/book_item.dart';
// import '../model/book_2.dart';
//
// class HomeCategory extends StatelessWidget {
//   const HomeCategory({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Book> books = [
//       Book(
//         rank: 1,
//         coverUrl: '...',
//         title: 'THẦN AI NÀY LO',
//         description: 'Sự thật về tình yêu, tình bạn và bản chất con người',
//         author: 'ERIC BARKER',
//       ),
//       Book(
//         rank: 2,
//         coverUrl: '...',
//         title: 'THẦN AI NÀY LO',
//         description: 'Sự thật về tình yêu, tình bạn và bản chất con người',
//         author: 'ERIC BARKER',
//       ),
//       Book(
//         rank: 3,
//         coverUrl: '...',
//         title: 'THẦN AI NÀY LO',
//         description: 'Sự thật về tình yêu, tình bạn và bản chất con người',
//         author: 'ERIC BARKER',
//       ),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Danh sách sách')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Input với icon
//             // CustomInput(
//             //   icon: Icons.search,
//             //   content: 'Tìm kiếm sách',
//             //   backgroundColor: const Color(0xFFE0E0E0),
//             //   navigateText: '/search', // Điều hướng đến route /search
//             // ),
//             const SizedBox(height: 16),
//             // Input không có icon
//             // CustomInput(
//             //   content: 'Nhập từ khóa',
//             //   backgroundColor: const Color(0xFF1976D2),
//             //   navigateText: '/search', // Điều hướng đến route /search
//             // ),
//             const SizedBox(height: 16),
//             // Danh sách sách
//             Expanded(
//               child: ListView.builder(
//                 itemCount: books.length,
//                 itemBuilder: (context, index) {
//                   return BookItem(book: books[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
