import '../../features/author_detail/models/book_with_author_model.dart';
import '../design_systems/design_system_export.dart';
import '../models/book/book_model.dart';

abstract class BaseBookListViewModel extends ChangeNotifier {
  List<BookModel> get books;
  bool get isLoading;
}
