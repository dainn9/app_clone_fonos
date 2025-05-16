import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/ book_author_response/book_author response.dart';
import '../../../models/author/author.dart';

class AuthorProvider with ChangeNotifier {
  List<Author> _authors = [];
  bool _isLoading = false;
  Author? _selectedAuthor;
  String? _errorMessage;

  List<Author> get authors => _authors;
  Author? get selectedAuthor => _selectedAuthor;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAuthors(String bookId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final queryParams = {
      'bookId': bookId,
    };

    try {
      final uri = Uri.http(
        '10.0.2.2:5022',
        '/api/BookAuthor',
        queryParams,
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Sử dụng BookAuthorResponse để parse JSON
        List<BookAuthorResponse> bookAuthorResponses = data
            .map((item) => BookAuthorResponse.fromJson(item))
            .toList();

        // Lấy danh sách tác giả từ các đối tượng BookAuthorResponse
        _authors = bookAuthorResponses
            .where((item) => item.author != null)
            .map((item) => item.author!)
            .toList();

        notifyListeners();
      } else {
        _authors = [];
        _errorMessage = "Lỗi: ${response.statusCode}";
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      _authors = [];
      _errorMessage = "Đã xảy ra lỗi: $e";
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAuthorDetail(String authorId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final uri = Uri.http(
        '10.0.2.2:5022',
        '/api/Author/$authorId',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _selectedAuthor = Author.fromJson(data);
        notifyListeners();
      } else {
        _errorMessage = "Lỗi: ${response.statusCode}";
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      _errorMessage = "Đã xảy ra lỗi: $e";
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Phương thức làm mới dữ liệu
  void resetSelectedAuthor() {
    _selectedAuthor = null;
    _errorMessage = null;
    notifyListeners();
  }
}
