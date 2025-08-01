import 'dart:convert';
import 'package:app_clone_fonos/features/category_list/models/category_model.dart';
import '../../../core/models/book/book_model.dart';

class BookByCategoryModel {
  final BookModel book;
  final CategoryModel category;

  BookByCategoryModel({required this.book, required this.category});

  factory BookByCategoryModel.fromJson(Map<String, dynamic> json) {
    return BookByCategoryModel(
      book: BookModel.fromJson(json['book']),
      category: CategoryModel.fromJson(json['category']),
    );
  }
}

List<BookByCategoryModel> parseBookByCategory(String jsonString) {
  final List<dynamic> jsonData = jsonDecode(jsonString);
  return jsonData.map<BookByCategoryModel>((json) => BookByCategoryModel.fromJson(json)).toList();
}