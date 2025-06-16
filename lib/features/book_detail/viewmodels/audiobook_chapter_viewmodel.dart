import 'package:app_clone_fonos/core/design_systems/design_system_export.dart';
import 'package:app_clone_fonos/features/book_detail/models/audiobook_chapter_model.dart';
import 'package:app_clone_fonos/services/audiobook_chapter_service.dart';

class AudiobookChapterViewModel extends ChangeNotifier {
  final AudiobookChapterService _service;

  List<AudiobookChapterModel> _chapters = [];
  bool _isLoading = false;
  String? errorMessage;

  List<AudiobookChapterModel> get chapters => _chapters;

  bool get isLoading => _isLoading;

  AudiobookChapterViewModel(this._service);

  Future<void> fetchAudioBooksByAudioBookId(String audiobookId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getAudioBookChapterByAudioBookId(
        audiobookId
      );
      final List<dynamic> data = response.data;
      _chapters =
          data.map((json) => AudiobookChapterModel.fromJson(json)).toList();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (chapters)';
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
