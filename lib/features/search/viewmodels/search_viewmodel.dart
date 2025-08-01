import '../../../core/design_systems/design_system_export.dart';
import '../../../core/models/book/book_model.dart';
import '../../../core/viewmodels/base_book_list_viewmodel.dart';
import '../../../services/book_service.dart';

class SearchViewModel extends ChangeNotifier implements BaseBookListViewModel {
  final BookService _service;

  List<BookModel> _books = [];
  bool _isLoading = false;
  String? errorMessage;

  @override
  List<BookModel> get books => _books;

  @override
  bool get isLoading => _isLoading;

  SearchViewModel(this._service);

  Future<void> fetchSuggestions(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getBooks( query: query);

      final List<dynamic> data = response.data;
      _books = data.map((json) => BookModel.fromJson(json)).toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải danh sach tim kiem';
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSuggestions() {
    _books = [];
    notifyListeners();
  }
}
