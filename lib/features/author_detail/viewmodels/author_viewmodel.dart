import 'dart:convert';

import 'package:app_clone_fonos/features/author_detail/models/author_detail_model.dart';
import 'package:app_clone_fonos/services/book_author_service.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../models/book_with_author_model.dart';

class AuthorViewModel extends ChangeNotifier {
  final BookAuthorService _service;

  List<AuthorDetailModel> _authors = [];
  List<BookWithAuthorModel>? _bookListBySameAuthor;

  bool _isLoading = false;
  String? errorMessage;

  List<AuthorDetailModel> get authors => _authors;
  List<BookWithAuthorModel>? get bookListBySameAuthor => _bookListBySameAuthor;
  bool get isLoading => _isLoading;

  AuthorViewModel(this._service);

  Future<void> fetchAuthors(String bookId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getAuthorsByBookId(bookId);
      final data = response.data;

      _bookListBySameAuthor = parseBookWithAuthors(jsonEncode(data));
      _authors =
          (_bookListBySameAuthor ?? [])
              .map((item) => item.author)
              .toSet()
              .toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (detail book)';
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksBySameAuthor(String authorId) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.getBooksBySameAuthor(authorId);
      final data = response.data;

      _bookListBySameAuthor = parseBookWithAuthors(jsonEncode(data));
      notifyListeners();
    } catch (e) {
      errorMessage = "Đã xảy ra lỗi: $e";
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
