import '../../../core/design_systems/design_system_export.dart';
import '../../../core/models/book/book_model.dart';
import '../../../core/viewmodels/base_book_list_viewmodel.dart';
import '../../../services/book_service.dart';

class ExploreViewModel extends ChangeNotifier implements BaseBookListViewModel {
  final BookService _service;

  List<BookModel> _books = [];
  bool _isLoading = false;
  String? errorMessage;

  @override
  List<BookModel> get books => _books;

  @override
  bool get isLoading => _isLoading;

  ExploreViewModel(this._service);

  Future<void> fetchCarouselBooks({int? limit}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          limit != null
              ? await _service.getBooks(limit: limit)
              : await _service.getBooks();

      final List<dynamic> data = response.data;
      _books = data.map((json) => BookModel.fromJson(json)).toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (carousel)';
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTopRatingBooks({int? limit}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          limit != null
              ? await _service.getTopRatingBooks(limit: limit)
              : await _service.getTopRatingBooks();

      final List<dynamic> data = response.data;
      _books = data.map((json) => BookModel.fromJson(json)).toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (top rating)';
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNewBooks({int? limit}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          limit != null
              ? await _service.getNewBooks(limit: limit)
              : await _service.getNewBooks();

      final List<dynamic> data = response.data;
      _books = data.map((json) => BookModel.fromJson(json)).toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (new book)';
    }

    _isLoading = false;
    notifyListeners();
  }
}
