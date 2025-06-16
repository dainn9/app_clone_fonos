import 'package:app_clone_fonos/features/book_detail/models/book_detail_model.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../../../core/models/book/book_model.dart';
import '../../../core/viewmodels/base_book_list_viewmodel.dart';
import '../../../services/book_service.dart';

class BookDetailViewModel extends ChangeNotifier
    implements BaseBookListViewModel {
  final BookService _service;

  late BookDetailModel _book;
  List<BookModel> _books = [];
  bool _isLoading = false;
  String? errorMessage;

  BookDetailModel get book => _book;

  @override
  List<BookModel> get books => _books;

  @override
  bool get isLoading => _isLoading;

  BookDetailViewModel(this._service);

  Future<void> fetchDetailBooks(String bookId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getDetailBooks(bookId);
      final data = response.data;
      _book = BookDetailModel.fromJson(data);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (detail book)';
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSamePublisherBooks(String publisherId, {int? limit}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getSamePublisherBooks(
        publisherId,
        limit: limit,
      );

      final List<dynamic> data = response.data;
      _books = data.map((json) => BookModel.fromJson(json)).toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (same-publisher book)';
    }

    _isLoading = false;
    notifyListeners();
  }
}
