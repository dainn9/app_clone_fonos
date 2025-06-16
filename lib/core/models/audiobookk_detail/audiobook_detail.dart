import '../audio/audiobook_chapter.dart';

class AudiobookDetail {
  final String audiobookId;
  final String bookId;
  final String duration;
  final int fileSize;
  final String audioQuality;
  final DateTime releaseDate;
  final bool isComplete;
  final int totalChapters;
  final List<AudiobookChapter> chapters;

  AudiobookDetail({
    required this.audiobookId,
    required this.bookId,
    required this.duration,
    required this.fileSize,
    required this.audioQuality,
    required this.releaseDate,
    required this.isComplete,
    required this.totalChapters,
    required this.chapters,
  });

  factory AudiobookDetail.fromJson(Map<String, dynamic> json) {
    return AudiobookDetail(
      audiobookId: json['audiobookId'],
      bookId: json['bookId'],
      duration: json['duration'],
      fileSize: json['fileSize'],
      audioQuality: json['audioQuality'],
      releaseDate: DateTime.parse(json['releaseDate']),
      isComplete: json['isComplete'],
      totalChapters: json['totalChapters'],
      chapters: (json['chapters'] as List)
          .map((chapter) => AudiobookChapter.fromJson(chapter))
          .toList(),
    );
  }
}
