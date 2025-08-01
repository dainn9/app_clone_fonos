import 'dart:async';

import 'package:app_clone_fonos/core/design_systems/design_system_export.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../services/audiobook_chapter_service.dart';
import '../../book_detail/models/audiobook_chapter_model.dart';

class AudioPlayerViewModel extends ChangeNotifier {
  final AudiobookChapterService _service;

  List<AudiobookChapterModel> _chapters = [];
  AudiobookChapterModel? _currentChapter;
  int _currentChapterIndex = 0;

  // Trạng thái player
  final AudioPlayer _audioPlayer = AudioPlayer();
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  bool _isPlaying = false;
  double _currentValue = 0.0;
  Duration? _duration;
  Duration? _position;
  double _playbackSpeed = 1.0;
  Timer? _sleepTimer;

  // // Subscriptions
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerStateSubscription;

  bool _isLoading = false;
  String? errorMessage;

  List<AudiobookChapterModel> get chapters => _chapters;

  AudiobookChapterModel? get currentChapter => _currentChapter;

  int get currentChapterIndex => _currentChapterIndex;

  bool get isPlaying => _isPlaying;

  bool get isLoading => _isLoading;

  double get currentValue => _currentValue;

  Duration? get duration => _duration;

  Duration? get position => _position;

  double get playbackSpeed => _playbackSpeed;

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioPlayerViewModel(this._service) {
    _initAudioPlayer();
  }

  // Initialize audio player
  void _initAudioPlayer() {
    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      _duration = duration;
      notifyListeners();
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      _position = position;
      if (_duration != null && _duration!.inMilliseconds > 0) {
        _currentValue = _position!.inMilliseconds / _duration!.inMilliseconds;
      }
      notifyListeners();
    });

    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();

      // Tự động chuyển sang chương tiếp theo khi kết thúc chương hiện tại
      if (state.processingState == ProcessingState.completed) {
        playChapterAtOffset(1);
      }
    });
  }

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

  Future<void> fetchAudioBooksByAudioBookId(
    String audiobookId, {
    bool? run = false,
    int currentChapterIndex = 0,
  }) async {
    _isLoading = true;
    notifyListeners();
    _currentChapterIndex = currentChapterIndex;
    try {
      final response = await _service.getAudioBookChapterByAudioBookId(
        audiobookId,
      );
      final List<dynamic> data = response.data;
      _chapters =
          data.map((json) => AudiobookChapterModel.fromJson(json)).toList();

      if (run == true) {
        _currentChapter = chapters[_currentChapterIndex];
        await loadYouTubeAudio(_currentChapter!.fileUrl);
      }

      errorMessage = null;
    } catch (e) {
      errorMessage = 'Lỗi khi tải (chapters)';
      print("Exception: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> playChapter(int index) async {
    if (index < 0 || index >= _chapters.length) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentChapterIndex = index;
      _currentChapter = _chapters[index];
      await loadYouTubeAudio(_currentChapter!.fileUrl); // videoId của chương
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Không thể phát chương: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load YouTube audio
  Future<void> loadYouTubeAudio(String videoId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Lấy thông tin về các định dạng âm thanh có sẵn
      final StreamManifest manifest = await _youtubeExplode.videos.streamsClient
          .getManifest(videoId);

      if (manifest.audioOnly.isEmpty) {
        throw Exception("Video không có stream âm thanh.");
      }

      // Lấy URL của stream âm thanh chất lượng cao nhất
      final audioStream = manifest.audioOnly.withHighestBitrate();

      final audioUrl = audioStream.url.toString();

      // Đặt URL cho AudioPlayer
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.play();
      _isPlaying = true;
      // final handler = _audioPlayer as AudioPlayerHandler;
      // await handler.playFromUrl(audioUrl);

      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      print("Không thể tải âm thanh từ YouTube: $e $videoId");
      print("Lỗi stackTrace: $stackTrace");
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _isPlaying = false;
    } else {
      await _audioPlayer.play();
      _isPlaying = true;
    }
    notifyListeners();
  }

  // Replay 10 seconds
  void replay10() {
    if (_position != null) {
      final newPosition = _position! - const Duration(seconds: 10);
      _audioPlayer.seek(newPosition.isNegative ? Duration.zero : newPosition);
    }
  }

  //
  // Forward 30 seconds
  void forward30() {
    if (_position != null && _duration != null) {
      final newPosition = _position! + const Duration(seconds: 30);
      _audioPlayer.seek(newPosition > _duration! ? _duration! : newPosition);
    }
  }

  //
  // Seek to position
  void seekTo(double value) {
    if (_duration != null) {
      final position = Duration(
        milliseconds: (value * _duration!.inMilliseconds).round(),
      );
      _audioPlayer.seek(position);
    }
  }

  // Change playback speed
  void changeSpeed() {
    double newSpeed;

    if (_playbackSpeed == 1.0) {
      newSpeed = 1.5;
    } else if (_playbackSpeed == 1.5) {
      newSpeed = 2.0;
    } else if (_playbackSpeed == 2.0) {
      newSpeed = 0.75;
    } else {
      newSpeed = 1.0;
    }

    _audioPlayer.setSpeed(newSpeed);
    _playbackSpeed = newSpeed;
    notifyListeners();
  }

  void setSleepTimer(Duration duration) {
    _sleepTimer?.cancel(); // Huỷ timer cũ nếu có

    _sleepTimer = Timer(duration, () async {
      if (_isPlaying) {
        await _audioPlayer.pause();
        _isPlaying = false;
        notifyListeners();
      }
      print("Đã tắt nhạc theo hẹn giờ.");
    });

    notifyListeners();
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
  }

  // Play next chapter
  Future<void> playChapterAtOffset(int offset) async {
    final nextIndex = _currentChapterIndex = offset;

    if (nextIndex < 0 || nextIndex >= chapters.length) {
      return; // Không còn chương tiếp theo
    }
    _isLoading = true;
    notifyListeners();

    try {
      _currentChapterIndex = nextIndex;
      _currentChapter = chapters[_currentChapterIndex];
      await loadYouTubeAudio(_currentChapter!.fileUrl);
    } catch (e) {
      errorMessage = 'Không thể phát chương kế tiếp: $e';
    }

    _isLoading = false;
    notifyListeners();
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
}
