// Lưu vào lib/screens/audio_player_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/audio_player_provider.dart';

class AudioPlayerScreen extends StatelessWidget {
  final String audiobookId;
  final String bookTitle;
  final String coverImageUrl;
  final String authorName;

  const AudioPlayerScreen({
    Key? key,
    required this.audiobookId,
    required this.bookTitle,
    required this.coverImageUrl,
    required this.authorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioPlayerProvider()..fetchAudiobookDetail(audiobookId),
      child: _AudioPlayerContent(
        bookTitle: bookTitle,
        coverImageUrl: coverImageUrl,
        authorName: authorName,
      ),
    );
  }
}

class _AudioPlayerContent extends StatelessWidget {
  final String bookTitle;
  final String coverImageUrl;
  final String authorName;

  const _AudioPlayerContent({
    Key? key,
    required this.bookTitle,
    required this.coverImageUrl,
    required this.authorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AudioPlayerProvider>(context);
    final backgroundColor = const Color(0xFF2A4D80);

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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/fonos_logo.png', // Thay thế bằng đường dẫn thực tế
                          width: 20,
                          height: 20,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.multitrack_audio,
                            color: Color(0xFF2A4D80),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'fonos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Nút menu
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
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
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Hình ảnh bìa sách
                                Image.network(
                                  coverImageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.book,
                                        size: 80,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        bookTitle,
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
                                        authorName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Hiển thị loading indicator khi đang tải
                        if (provider.isLoading)
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
                          bookTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          provider.currentChapter?.chapterTitle ?? 'Đang tải...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
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
                            inactiveTrackColor: Colors.white.withOpacity(0.3),
                            thumbColor: Colors.white,
                            overlayColor: Colors.white.withOpacity(0.2),
                          ),
                          child: Slider(
                            value: provider.currentValue.clamp(0.0, 1.0),
                            onChanged: (value) {
                              provider.seekTo(value);
                            },
                          ),
                        ),

                        // Thời gian
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                provider.positionText,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                provider.remainingText,
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
                          onPressed: provider.playPreviousChapter,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.replay_10,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: provider.replay10,
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
                              provider.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: backgroundColor,
                              size: 32,
                            ),
                            onPressed: provider.playPause,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.forward_30,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: provider.forward30,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: provider.playNextChapter,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Các tính năng bổ sung
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureButton(
                          context,
                          Icons.nightlight_round,
                          'Hẹn giờ',
                          onTap: () {
                            _showTimerDialog(context);
                          },
                        ),
                        _buildFeatureButton(
                          context,
                          Icons.format_list_bulleted,
                          'Chương',
                          onTap: () {
                            _showChaptersDialog(context);
                          },
                        ),
                        _buildFeatureButton(
                          context,
                          Icons.speed,
                          '${provider.playbackSpeed}x',
                          hasCircle: true,
                          onTap: provider.changeSpeed,
                        ),
                        _buildFeatureButton(
                          context,
                          Icons.attachment,
                          'Đính kèm',
                          onTap: () {
                            _showAttachmentsDialog(context);
                          },
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
  }

  Widget _buildFeatureButton(
      BuildContext context,
      IconData icon,
      String label, {
        bool hasCircle = true,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          hasCircle
              ? Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          )
              : Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  // Hiển thị dialog hẹn giờ
  void _showTimerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hẹn giờ tắt'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tắt sau 15 phút'),
              onTap: () {
                Navigator.pop(context);
                _setTimer(context, 15);
              },
            ),
            ListTile(
              title: const Text('Tắt sau 30 phút'),
              onTap: () {
                Navigator.pop(context);
                _setTimer(context, 30);
              },
            ),
            ListTile(
              title: const Text('Tắt sau 45 phút'),
              onTap: () {
                Navigator.pop(context);
                _setTimer(context, 45);
              },
            ),
            ListTile(
              title: const Text('Tắt sau 60 phút'),
              onTap: () {
                Navigator.pop(context);
                _setTimer(context, 60);
              },
            ),
            ListTile(
              title: const Text('Hủy hẹn giờ'),
              onTap: () {
                Navigator.pop(context);
                _cancelTimer(context);
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
  }

  // Hủy hẹn giờ
  void _cancelTimer(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã hủy hẹn giờ'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Hiển thị dialog chương
  void _showChaptersDialog(BuildContext context) {
    final provider = Provider.of<AudioPlayerProvider>(context, listen: false);

    if (provider.audiobookDetail == null) {
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
      builder: (context) => AlertDialog(
        title: const Text('Danh sách chương'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: provider.audiobookDetail!.chapters.length,
            itemBuilder: (context, index) {
              final chapter = provider.audiobookDetail!.chapters[index];
              final isCurrentChapter = index == provider.currentChapterIndex;

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

  // Hiển thị dialog đính kèm
  void _showAttachmentsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Tài liệu đính kèm'),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
          ListTile(
          leading: const Icon(Icons.picture_as_pdf),
          title: const Text('Tóm tắt tác phẩm.pdf'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đang mở file PDF...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Hình ảnh minh họa.jpg'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Đang mở hình ảnh...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        ListTile(
        leading: const Icon(Icons.text_snippet),
    title: const Text('Ghi chú về tác giả.txt'),
    onTap: () {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang mở file văn bản...'),
        duration: Duration(seconds: 2),
      ),
    );
    },
        ),
              ],
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

