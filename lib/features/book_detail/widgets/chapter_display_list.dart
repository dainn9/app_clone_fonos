import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../../../core/widgets/section_header.dart';
import '../../../services/audiobook_chapter_service.dart';
import '../viewmodels/audiobook_chapter_viewmodel.dart';
import 'chapter_item.dart';


class ChapterDisplayListWidget extends StatefulWidget {
  final String audiobookId;
  const ChapterDisplayListWidget({ super.key,required this.audiobookId});

  @override
  State<ChapterDisplayListWidget> createState() => _ChapterDisplayListWidgetState();

  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider<AudiobookChapterViewModel>(
  //     create: (_) => AudiobookChapterViewModel(context.read<AudiobookChapterService>())..fetchAudioBooksByAudioBookId(audiobookId),
  //     child: _ChapterDisplayList(),
  //   );
  // }
}

class _ChapterDisplayListWidgetState extends State<ChapterDisplayListWidget> {
  late AudiobookChapterViewModel _chapterVM;

  @override
  void initState() {
    super.initState();
    // Delay gọi API để tránh lỗi context chưa sẵn sàng
    Future.microtask(() {
      _chapterVM.fetchAudioBooksByAudioBookId(widget.audiobookId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AudiobookChapterViewModel>(
      create: (_) {
        final vm = AudiobookChapterViewModel(context.read<AudiobookChapterService>());
        _chapterVM = vm;
        return vm;
      },
      child:  _ChapterDisplayList(),
    );
  }
}

class _ChapterDisplayList extends StatefulWidget {
  @override
  State<_ChapterDisplayList> createState() => _ChapterDisplayListState();
}

class _ChapterDisplayListState extends State<_ChapterDisplayList> {
  bool showAllChapters = false;


  @override
  Widget build(BuildContext context) {
    return Consumer<AudiobookChapterViewModel>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.chapters.isEmpty) {
          return Center(child: Text('Không có chapter nào (${provider.errorMessage ?? ""})'));
        }

        final chapters = showAllChapters
            ? provider.chapters
            : provider.chapters.take(2).toList();

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Mục lục'),
                const SizedBox(height: 8),
                ...chapters.map(
                      (chapter) => ChapterItem(
                    title: chapter.chapterTitle,
                    duration: chapter.duration,
                  ),
                ),
                const SizedBox(height: 12),
                if (provider.chapters.length > 2)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => showAllChapters = !showAllChapters);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE6EBEF),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        showAllChapters
                            ? "Thu gọn"
                            : "Xem tất cả ${provider.chapters.length} chương",
                        style: const TextStyle(color: Color(0xFF2B3A5C)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

