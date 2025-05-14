import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:async';

class HomeListening extends StatefulWidget {
  const HomeListening({super.key});

  @override
  State<HomeListening> createState() => _HomeListeningState();
}

class _HomeListeningState extends State<HomeListening> {
  bool isPlaying = false;
  bool isLoading = true;
  double currentValue = 0.0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final YoutubeExplode _youtubeExplode = YoutubeExplode();
  Duration? _duration;
  Duration? _position;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerStateSubscription;
  double _playbackSpeed = 1.0;

  String get durationText =>
      _duration != null
          ? '${_duration!.inMinutes}:${(_duration!.inSeconds % 60).toString().padLeft(2, '0')}'
          : '00:00';

  String get positionText =>
      _position != null
          ? '${_position!.inMinutes}:${(_position!.inSeconds % 60).toString().padLeft(2, '0')}'
          : '00:00';

  String get remainingText {
    if (_position != null && _duration != null) {
      final remaining = _duration! - _position!;
      return '-${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '-00:00';
  }

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Lắng nghe các sự kiện từ AudioPlayer
    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
        if (_duration != null && _duration!.inMilliseconds > 0) {
          currentValue = _position!.inMilliseconds / _duration!.inMilliseconds;
        }
      });
    });

    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
      });
    });

    // Tải âm thanh từ YouTube
    await _loadYouTubeAudio();
  }

  Future<void> _loadYouTubeAudio() async {
    setState(() {
      isLoading = true;
    });

    try {
      // ID của video YouTube
      const videoId =
          'uIDqAHgOPjc'; // ID từ URL https://www.youtube.com/watch?v=Pe0jMzpWaIw

      // Lấy thông tin về các định dạng âm thanh có sẵn
      final StreamManifest manifest = await _youtubeExplode.videos.streamsClient
          .getManifest(videoId);

      // Lấy URL của stream âm thanh chất lượng cao nhất
      final audioStream = manifest.audioOnly.withHighestBitrate();
      final audioUrl = audioStream.url.toString();

      // Đặt URL cho AudioPlayer
      await _audioPlayer.setUrl(audioUrl);

      setState(() {
        isLoading = false;
      });

      // Hiển thị thông báo thành công
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã tải âm thanh từ YouTube thành công'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print("Không thể tải âm thanh từ YouTube: $e");
      setState(() {
        isLoading = false;
      });

      // Hiển thị thông báo lỗi
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Không thể tải âm thanh: $e'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }

      // Tải một file âm thanh dự phòng
      try {
        await _audioPlayer.setUrl(
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        );
      } catch (e) {
        print("Không thể tải file âm thanh dự phòng: $e");
      }
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    _youtubeExplode.close();
    super.dispose();
  }

  // Phát/Tạm dừng âm thanh
  void _playPause() {
    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  // Tua lại 10 giây
  void _replay10() {
    if (_position != null) {
      final newPosition = _position! - const Duration(seconds: 10);
      _audioPlayer.seek(newPosition.isNegative ? Duration.zero : newPosition);
    }
  }

  // Tua tới 30 giây
  void _forward30() {
    if (_position != null && _duration != null) {
      final newPosition = _position! + const Duration(seconds: 30);
      _audioPlayer.seek(newPosition > _duration! ? _duration! : newPosition);
    }
  }

  // Chuyển đến vị trí cụ thể
  void _seekTo(double value) {
    if (_duration != null) {
      final position = Duration(
        milliseconds: (value * _duration!.inMilliseconds).round(),
      );
      _audioPlayer.seek(position);
    }
  }

  // Thay đổi tốc độ phát
  void _changeSpeed() {
    // Xoay vòng giữa các tốc độ: 1.0x -> 1.5x -> 2.0x -> 0.75x -> 1.0x
    double newSpeed;

    if (_playbackSpeed == 1.0) {
      newSpeed = 1.5;
    } else if (_playbackSpeed == 1.5)
      newSpeed = 2.0;
    else if (_playbackSpeed == 2.0)
      newSpeed = 0.75;
    else
      newSpeed = 1.0;

    _audioPlayer.setSpeed(newSpeed);

    setState(() {
      _playbackSpeed = newSpeed;
    });

    // Hiển thị thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tốc độ phát: ${newSpeed}x'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Màu chủ đạo - màu nâu vàng từ hình ảnh
    final backgroundColor = const Color(0xFF8D7542);

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
                          errorBuilder:
                              (context, error, stackTrace) => const Icon(
                                Icons.multitrack_audio,
                                color: Color(0xFF8D7542),
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
                            color: const Color(
                              0xFFF5E9B9,
                            ), // Màu vàng nhạt của bìa sách
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
                                // Hình ảnh bìa sách - sử dụng thumbnail từ YouTube
                                Image.network(
                                  'https://img.youtube.com/vi/Pe0jMzpWaIw/maxresdefault.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Hình cây và phong cảnh
                                          Icon(
                                            Icons.nature,
                                            size: 80,
                                            color: Colors.brown.withOpacity(
                                              0.7,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          // Tiêu đề sách
                                          const Text(
                                            'Đồi Gió Hú',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.brown,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Emily Brontë',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.brown,
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
                        if (isLoading)
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
                          'Đồi Gió Hú',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Phần 10',
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
                            value: currentValue.clamp(0.0, 1.0),
                            onChanged: (value) {
                              setState(() {
                                currentValue = value;
                              });
                            },
                            onChangeEnd: (value) {
                              _seekTo(value);
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
                                positionText,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                remainingText,
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
                            // Quay về đầu bài
                            _audioPlayer.seek(Duration.zero);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.replay_10,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: _replay10,
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
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: backgroundColor,
                              size: 32,
                            ),
                            onPressed: _playPause,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.forward_30,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: _forward30,
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            // Chuyển đến cuối bài
                            if (_duration != null) {
                              _audioPlayer.seek(_duration!);
                            }
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Các tính năng bổ sung
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFeatureButton(
                          Icons.nightlight_round,
                          'Hẹn giờ',
                          onTap: () {
                            _showTimerDialog(context);
                          },
                        ),
                        _buildFeatureButton(
                          Icons.format_list_bulleted,
                          'Chương',
                          onTap: () {
                            _showChaptersDialog(context);
                          },
                        ),
                        _buildFeatureButton(
                          Icons.speed,
                          '${_playbackSpeed}x',
                          hasCircle: true,
                          onTap: _changeSpeed,
                        ),
                        _buildFeatureButton(
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
      builder:
          (context) => AlertDialog(
            title: const Text('Hẹn giờ tắt'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Tắt sau 15 phút'),
                  onTap: () {
                    Navigator.pop(context);
                    _setTimer(15);
                  },
                ),
                ListTile(
                  title: const Text('Tắt sau 30 phút'),
                  onTap: () {
                    Navigator.pop(context);
                    _setTimer(30);
                  },
                ),
                ListTile(
                  title: const Text('Tắt sau 45 phút'),
                  onTap: () {
                    Navigator.pop(context);
                    _setTimer(45);
                  },
                ),
                ListTile(
                  title: const Text('Tắt sau 60 phút'),
                  onTap: () {
                    Navigator.pop(context);
                    _setTimer(60);
                  },
                ),
                ListTile(
                  title: const Text('Hủy hẹn giờ'),
                  onTap: () {
                    Navigator.pop(context);
                    _cancelTimer();
                  },
                ),
              ],
            ),
          ),
    );
  }

  // Đặt hẹn giờ
  void _setTimer(int minutes) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã đặt hẹn giờ tắt sau $minutes phút'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Hủy hẹn giờ
  void _cancelTimer() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã hủy hẹn giờ'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Hiển thị dialog chương
  void _showChaptersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Danh sách chương'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (context, index) {
                  final chapterNumber = index + 1;
                  final isCurrentChapter =
                      chapterNumber == 10; // Giả sử đang ở chương 10

                  return ListTile(
                    title: Text('Chương $chapterNumber'),
                    subtitle: Text(
                      'Phần ${chapterNumber % 3 == 0
                          ? "cuối"
                          : chapterNumber % 3 == 1
                          ? "đầu"
                          : "giữa"}',
                    ),
                    selected: isCurrentChapter,
                    selectedTileColor: Colors.grey[200],
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đã chuyển đến Chương $chapterNumber'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
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
      builder:
          (context) => AlertDialog(
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
