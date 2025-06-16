// Lưu vào lib/models/audiobook/audiobook_models.dart
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

class AudiobookChapter {
  final String audiobookChapterId;
  final String audiobookId;
  final int chapterNumber;
  final String chapterTitle;
  final String duration;
  final String fileUrl; // YouTube video ID
  final int fileSize;

  AudiobookChapter({
    required this.audiobookChapterId,
    required this.audiobookId,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.duration,
    required this.fileUrl,
    required this.fileSize,
  });

  factory AudiobookChapter.fromJson(Map<String, dynamic> json) {
    return AudiobookChapter(
      audiobookChapterId: json['audiobookChapterId'],
      audiobookId: json['audiobookId'],
      chapterNumber: json['chapterNumber'],
      chapterTitle: json['chapterTitle'],
      duration: json['duration'],
      fileUrl: json['fileUrl'],
      fileSize: json['fileSize'],
    );
  }
}
