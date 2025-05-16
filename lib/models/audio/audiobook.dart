import '../base_model.dart';
import 'audiobook_chapter.dart';

class Audiobook implements BaseModel {
  final String? audiobookId;
  final String? bookId;
  final String? duration;  // Thay đổi từ int? sang String?
  final int? fileSize;
  final String? audioQuality;
  final DateTime? releaseDate;
  final bool? isComplete;
  final int? totalChapters;
  final List<AudiobookChapter>? chapters;

  Audiobook({
    this.audiobookId,
    this.bookId,
    this.duration,
    this.fileSize,
    this.audioQuality,
    this.releaseDate,
    this.isComplete,
    this.totalChapters,
    this.chapters,
  });

  factory Audiobook.fromJson(Map<String, dynamic> json) {
    return Audiobook(
      audiobookId: json['audiobookId'],
      bookId: json['bookId'],
      duration: json['duration'],  // Không cần chuyển đổi kiểu
      fileSize: json['fileSize'],
      audioQuality: json['audioQuality'],
      releaseDate: json['releaseDate'] != null ? DateTime.parse(json['releaseDate']) : null,
      isComplete: json['isComplete'],
      totalChapters: json['totalChapters'],
      chapters: json['chapters'] != null
          ? List<AudiobookChapter>.from(json['chapters'].map((x) => AudiobookChapter.fromJson(x)))
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'audiobookId': audiobookId,
      'bookId': bookId,
      'duration': duration,
      'fileSize': fileSize,
      'audioQuality': audioQuality,
      'releaseDate': releaseDate?.toIso8601String(),
      'isComplete': isComplete,
      'totalChapters': totalChapters,
      'chapters': chapters != null ? chapters!.map((x) => x.toJson()).toList() : null,
    };
  }
}
