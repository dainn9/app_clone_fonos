import 'dart:convert';

import 'package:app_clone_fonos/features/author_detail/models/author_detail_model.dart';

import '../../../core/models/book/book_model.dart';

class BookWithAuthorModel {
  final BookModel book;
  final AuthorDetailModel author;

  BookWithAuthorModel({required this.book, required this.author});

  factory BookWithAuthorModel.fromJson(Map<String, dynamic> json) {
    return BookWithAuthorModel(
      book: BookModel.fromJson(json['book']),
      author: AuthorDetailModel.fromJson(json['author']),
    );
  }
}

List<BookWithAuthorModel> parseBookWithAuthors(String jsonString) {
  final List<dynamic> jsonData = jsonDecode(jsonString);
  return jsonData.map<BookWithAuthorModel>((json) => BookWithAuthorModel.fromJson(json)).toList();
}
