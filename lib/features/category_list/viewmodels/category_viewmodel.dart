import 'dart:convert';

import 'package:app_clone_fonos/features/category_list/models/book_by_category_model.dart';
import 'package:app_clone_fonos/features/category_list/models/category_model.dart';
import 'package:app_clone_fonos/services/category_service.dart';
import 'package:flutter/foundation.dart';

import '../../../core/design_systems/design_system_export.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _service;

  List<CategoryModel> _categories = [];
  List<BookByCategoryModel>? _bookListByCategory;

  bool _isLoading = false;
  String? errorMessage;

  List<CategoryModel> get categories => _categories;
  List<BookByCategoryModel>? get bookListByCategory => _bookListByCategory;
  bool get isLoading => _isLoading;

  CategoryViewModel(this._service);

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getCategories();
      final List<dynamic> data = response.data;
      _categories = data.map((json) => CategoryModel.fromJson(json)).toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (cateogory)';
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByCategory(String categoryId) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _service.getBooksByCategoryId(categoryId);
      final data = response.data;

      _bookListByCategory = parseBookByCategory(jsonEncode(data));
      notifyListeners();
    } catch (e) {
      errorMessage = "Đã xảy ra lỗi lấy sách theo loại: $e";
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
