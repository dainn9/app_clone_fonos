import 'package:app_clone_fonos/features/audio_player/viewmodels/audio_player_viewmodel.dart';
import 'package:app_clone_fonos/services/audiobook_chapter_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../../core/design_systems/design_system_export.dart';
import '../widgets/feature_button.dart';

class AudioPlayerScreen extends StatelessWidget {
  final String audiobookId;
  final String coverImageUrl;
  final int currentChapterIndex;

  const AudioPlayerScreen({
    Key? key,
    required this.audiobookId,
    required this.coverImageUrl,
    this.currentChapterIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final audiobookChapterService = context.read<AudiobookChapterService>();
        return ChangeNotifierProvider<AudioPlayerViewModel>(
          create: (_) {
            final viewModel = AudioPlayerViewModel(audiobookChapterService);
            viewModel.fetchAudioBooksByAudioBookId(
              audiobookId,
              run: true,
              currentChapterIndex: currentChapterIndex,
            );
            return viewModel;
          },
          builder: (context, _) {
            return _AudioPlayerContent(coverImageUrl: coverImageUrl);
          },
        );
      },
    );
  }
}

class _AudioPlayerContent extends StatelessWidget {
  final String coverImageUrl;

  const _AudioPlayerContent({required this.coverImageUrl});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColors.playerBackgroundDefault;
    return Consumer<AudioPlayerViewModel>(
      builder: (context, audioPlayerViewModel, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Phần header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nút quay lại
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),

                      // Logo Fonos
                      Image.asset(
                        'assets/images/logo_text_white.png',
                        height: 40, // Thay thế bằng đường dẫn thực tế
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.multitrack_audio,
                              color: AppColors.playerBackgroundDefault,
                            ),
                      ),

                      // Nút menu
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          // TODO
                        },
                      ),
                    ],
                  ),
                ),

                // Phần nội dung chính
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Ảnh bìa sách
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.4,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: coverImageUrl,
                                  fit: BoxFit.cover,
                                  errorWidget:
                                      (context, error, stackTrace) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.book,
                                            size: 80,
                                            color: Colors.white.withOpacity(
                                              0.7,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            'Title',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'author Name',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white.withOpacity(
                                                0.8,
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                ),
                              ),
                            ),

                            // Hiển thị loading indicator khi đang tải
                            if (audioPlayerViewModel.isLoading)
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        // Tiêu đề sách và phần
                        Column(
                          children: [
                            Text(
                              audioPlayerViewModel
                                      .currentChapter
                                      ?.chapterTitle ??
                                  'Đang tải...',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Thanh tiến trình
                        Column(
                          children: [
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 4,
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 8,
                                ),
                                overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 16,
                                ),
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white.withOpacity(
                                  0.3,
                                ),
                                thumbColor: Colors.white,
                                overlayColor: Colors.white.withOpacity(0.2),
                              ),
                              child: Slider(
                                value: audioPlayerViewModel.currentValue.clamp(
                                  0.0,
                                  1.0,
                                ),
                                onChanged: (value) {
                                  audioPlayerViewModel.seekTo(value);
                                },
                              ),
                            ),

                            // Thời gian
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    audioPlayerViewModel.positionText,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    audioPlayerViewModel.remainingText,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Các nút điều khiển
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () {
                                audioPlayerViewModel.playChapterAtOffset(-1);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.replay_10,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: audioPlayerViewModel.replay10,
                            ),
                            // Nút play/pause
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  audioPlayerViewModel.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: backgroundColor,
                                  size: 32,
                                ),
                                onPressed: audioPlayerViewModel.playPause,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.forward_30,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: audioPlayerViewModel.forward30,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () {
                                audioPlayerViewModel.playChapterAtOffset(1);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Các tính năng bổ sung
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FeatureButton(
                              icon: Icons.nightlight_round,
                              label: 'Hẹn giờ',
                              onTap: () {
                                _showTimerDialog(context);
                              },
                            ),
                            FeatureButton(
                              icon: Icons.format_list_bulleted,
                              label: 'Chương',
                              onTap: () {
                                _showChaptersDialog(context);
                              },
                            ),
                            FeatureButton(
                              icon: Icons.speed,
                              label: '${audioPlayerViewModel.playbackSpeed}x',
                              hasCircle: true,
                              onTap: audioPlayerViewModel.changeSpeed,
                            ),
                          ],
                        ),
                      ],
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

  void _showTimerDialog(BuildContext outerContext) {
    showDialog(
      context: outerContext,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Hẹn giờ tắt'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Tắt sau 15 phút'),
                  onTap: () {
                    Navigator.pop(dialogContext);
                    _setTimer(outerContext, 15);
                  },
                ),
                ListTile(
                  title: const Text('Tắt sau 30 phút'),
                  onTap: () {
                    Navigator.pop(dialogContext);
                    _setTimer(outerContext, 30);
                  },
                ),
                ListTile(
                  title: const Text('Tắt sau 45 phút'),
                  onTap: () {
                    Navigator.pop(dialogContext);
                    _setTimer(outerContext, 45);
                  },
                ),
                ListTile(
                  title: const Text('Tắt sau 60 phút'),
                  onTap: () {
                    Navigator.pop(dialogContext);
                    _setTimer(outerContext , 60);
                  },
                ),
                ListTile(
                  title: const Text('Hủy hẹn giờ'),
                  onTap: () {
                    Navigator.pop(dialogContext);
                    _cancelTimer(outerContext);
                  },
                ),
              ],
            ),
          ),
    );
  }

  // Đặt hẹn giờ
  void _setTimer(BuildContext context, int minutes) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã đặt hẹn giờ tắt sau $minutes phút'),
        duration: const Duration(seconds: 2),
      ),
    );
    final provider = Provider.of<AudioPlayerViewModel>(context, listen: false);
    provider.setSleepTimer(Duration(minutes: minutes));
  }

  // Hủy hẹn giờ
  void _cancelTimer(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã hủy hẹn giờ'),
        duration: Duration(seconds: 2),
      ),
    );
      final provider = Provider.of<AudioPlayerViewModel>(context, listen: false);
      provider.cancelSleepTimer();
  }

  // Hiển thị dialog chương
  void _showChaptersDialog(BuildContext context) {
    final provider = Provider.of<AudioPlayerViewModel>(context, listen: false);

    if (provider.isLoading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đang tải thông tin chương...'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Danh sách chương'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: provider.chapters.length,
                itemBuilder: (context, index) {
                  final chapter = provider.chapters[index];
                  final isCurrentChapter =
                      index == provider.currentChapterIndex;

                  return ListTile(
                    title: Text(chapter.chapterTitle),
                    subtitle: Text('Thời lượng: ${chapter.duration}'),
                    selected: isCurrentChapter,
                    selectedTileColor: Colors.grey[200],
                    onTap: () {
                      Navigator.pop(context);
                      provider.playChapter(index);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }
}
