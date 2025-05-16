import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/book/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;
  Book? _selectedBook;


  List<Book> get books => _books;
  Book? get selectBook => _selectedBook;
  bool get isLoading => _isLoading;

  Future<void> fetchBooks({int? limit}) async {

    _isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.http(
        '10.0.2.2:5022',
        '/api/Book/mobile-option',
        limit != null ? {'limit': limit.toString()} : null,
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _books = data.map((json) => Book.fromJson(json)).toList();
        notifyListeners();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksNew({int? limit}) async {

    _isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.http(
        '10.0.2.2:5022',
        '/api/Book/new',
        limit != null ? {'limit': limit.toString()} : null,
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _books = data.map((json) => Book.fromJson(json)).toList();
        notifyListeners();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBookDetail(String id) async {

    _isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.http(
        '10.0.2.2:5022',
        '/api/Book/$id',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _selectedBook = Book.fromJson(data);

        notifyListeners();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksTopRating({int? limit}) async {

    _isLoading = true;
    notifyListeners();

    try {
      final uri = Uri.http(
        '10.0.2.2:5022',
        '/api/Book/top-rating',
        limit != null ? {'limit': limit.toString()} : null,
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _books = data.map((json) => Book.fromJson(json)).toList();
        notifyListeners();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
