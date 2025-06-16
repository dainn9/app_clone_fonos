// // Lưu vào lib/providers/audio_player_provider.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import '../../../core/api/audiobook_service.dart';
// import '../../../models/audio/audiobook_chapter.dart';
// import '../../../models/audiobookk_detail/audiobook_detail.dart';
//
// class AudioPlayerProvider extends ChangeNotifier {
//   // Thông tin audiobook
//   AudiobookDetail? _audiobookDetail;
//   AudiobookChapter? _currentChapter;
//   int _currentChapterIndex = 0;
//
//   // Trạng thái player
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final YoutubeExplode _youtubeExplode = YoutubeExplode();
//   bool _isPlaying = false;
//   bool _isLoading = true;
//   double _currentValue = 0.0;
//   Duration? _duration;
//   Duration? _position;
//   double _playbackSpeed = 1.0;
//
//   // Subscriptions
//   StreamSubscription? _durationSubscription;
//   StreamSubscription? _positionSubscription;
//   StreamSubscription? _playerStateSubscription;
//
//   // Getters
//   AudiobookDetail? get audiobookDetail => _audiobookDetail;
//   AudiobookChapter? get currentChapter => _currentChapter;
//   int get currentChapterIndex => _currentChapterIndex;
//   bool get isPlaying => _isPlaying;
//   bool get isLoading => _isLoading;
//   double get currentValue => _currentValue;
//   Duration? get duration => _duration;
//   Duration? get position => _position;
//   double get playbackSpeed => _playbackSpeed;
//   AudioPlayer get audioPlayer => _audioPlayer;
//
//   String get durationText =>
//       _duration != null
//           ? '${_duration!.inMinutes}:${(_duration!.inSeconds % 60).toString().padLeft(2, '0')}'
//           : '00:00';
//
//   String get positionText =>
//       _position != null
//           ? '${_position!.inMinutes}:${(_position!.inSeconds % 60).toString().padLeft(2, '0')}'
//           : '00:00';
//
//   String get remainingText {
//     if (_position != null && _duration != null) {
//       final remaining = _duration! - _position!;
//       return '-${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';
//     }
//     return '-00:00';
//   }
//
//   // Constructor
//   AudioPlayerProvider() {
//     _initAudioPlayer();
//   }
//
//   // Initialize audio player
//   void _initAudioPlayer() {
//     _durationSubscription = _audioPlayer.durationStream.listen((duration) {
//       _duration = duration;
//       notifyListeners();
//     });
//
//     _positionSubscription = _audioPlayer.positionStream.listen((position) {
//       _position = position;
//       if (_duration != null && _duration!.inMilliseconds > 0) {
//         _currentValue = _position!.inMilliseconds / _duration!.inMilliseconds;
//       }
//       notifyListeners();
//     });
//
//     _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
//       _isPlaying = state.playing;
//       notifyListeners();
//
//       // Tự động chuyển sang chương tiếp theo khi kết thúc chương hiện tại
//       if (state.processingState == ProcessingState.completed) {
//         playNextChapter();
//       }
//     });
//   }
//
//   // Fetch audiobook details
//   Future<void> fetchAudiobookDetail(String audiobookId) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       final audiobookDetail = await AudiobookService.getAudiobookDetail(audiobookId);
//
//       _audiobookDetail = audiobookDetail;
//
//       // Sắp xếp các chương theo số thứ tự
//       _audiobookDetail!.chapters.sort((a, b) => a.chapterNumber!.compareTo(b.chapterNumber!));
//
//       if (_audiobookDetail!.chapters.isNotEmpty) {
//         _currentChapter = _audiobookDetail!.chapters[_currentChapterIndex];
//         await loadYouTubeAudio(_currentChapter!.fileUrl!);
//       }
//
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       print("Không thể tải thông tin audiobook: $e");
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Load YouTube audio
//   Future<void> loadYouTubeAudio(String videoId) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       // Lấy thông tin về các định dạng âm thanh có sẵn
//       final StreamManifest manifest = await _youtubeExplode.videos.streamsClient
//           .getManifest(videoId);
//
//       // Lấy URL của stream âm thanh chất lượng cao nhất
//       final audioStream = manifest.audioOnly.withHighestBitrate();
//       final audioUrl = audioStream.url.toString();
//
//       // Đặt URL cho AudioPlayer
//       await _audioPlayer.setUrl(audioUrl);
//       await _audioPlayer.play();
//
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       print("Không thể tải âm thanh từ YouTube: $e");
//       _isLoading = false;
//       notifyListeners();
//       rethrow;
//     }
//   }
//
//   // Play/Pause
//   void playPause() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play();
//     }
//   }
//
//   // Replay 10 seconds
//   void replay10() {
//     if (_position != null) {
//       final newPosition = _position! - const Duration(seconds: 10);
//       _audioPlayer.seek(newPosition.isNegative ? Duration.zero : newPosition);
//     }
//   }
//
//   // Forward 30 seconds
//   void forward30() {
//     if (_position != null && _duration != null) {
//       final newPosition = _position! + const Duration(seconds: 30);
//       _audioPlayer.seek(newPosition > _duration! ? _duration! : newPosition);
//     }
//   }
//
//   // Seek to position
//   void seekTo(double value) {
//     if (_duration != null) {
//       final position = Duration(
//         milliseconds: (value * _duration!.inMilliseconds).round(),
//       );
//       _audioPlayer.seek(position);
//     }
//   }
//
//   // Change playback speed
//   void changeSpeed() {
//     double newSpeed;
//
//     if (_playbackSpeed == 1.0) {
//       newSpeed = 1.5;
//     } else if (_playbackSpeed == 1.5) {
//       newSpeed = 2.0;
//     } else if (_playbackSpeed == 2.0) {
//       newSpeed = 0.75;
//     } else {
//       newSpeed = 1.0;
//     }
//
//     _audioPlayer.setSpeed(newSpeed);
//     _playbackSpeed = newSpeed;
//     notifyListeners();
//   }
//
//   // Play next chapter
//   void playNextChapter() {
//     if (_audiobookDetail == null || _currentChapterIndex >= _audiobookDetail!.chapters.length - 1) {
//       return; // Không còn chương tiếp theo
//     }
//
//     _currentChapterIndex++;
//     _currentChapter = _audiobookDetail!.chapters[_currentChapterIndex];
//     loadYouTubeAudio(_currentChapter!.fileUrl);
//   }
//
//   // Play previous chapter
//   void playPreviousChapter() {
//     if (_audiobookDetail == null || _currentChapterIndex <= 0) {
//       return; // Không có chương trước đó
//     }
//
//     _currentChapterIndex--;
//     _currentChapter = _audiobookDetail!.chapters[_currentChapterIndex];
//     loadYouTubeAudio(_currentChapter!.fileUrl);
//   }
//
//   // Play specific chapter
//   void playChapter(int index) {
//     if (_audiobookDetail == null ||
//         index < 0 ||
//         index >= _audiobookDetail!.chapters.length) {
//       return;
//     }
//
//     _currentChapterIndex = index;
//     _currentChapter = _audiobookDetail!.chapters[_currentChapterIndex];
//     loadYouTubeAudio(_currentChapter!.fileUrl);
//   }
//
//   @override
//   void dispose() {
//     _durationSubscription?.cancel();
//     _positionSubscription?.cancel();
//     _playerStateSubscription?.cancel();
//     _audioPlayer.dispose();
//     _youtubeExplode.close();
//     super.dispose();
//   }
// }
