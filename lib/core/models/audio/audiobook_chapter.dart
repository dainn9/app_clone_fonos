import '../base_model.dart';

class AudiobookChapter implements BaseModel {
  final String? audiobookChapterId;
  final String? audiobookId;
  final int? chapterNumber;
  final String? chapterTitle;
  final int? duration;
  final String? fileUrl;
  final int? fileSize;

  AudiobookChapter({
    this.audiobookChapterId,
    this.audiobookId,
    this.chapterNumber,
    this.chapterTitle,
    this.duration,
    this.fileUrl,
    this.fileSize,
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'audiobookChapterId': audiobookChapterId,
      'audiobookId': audiobookId,
      'chapterNumber': chapterNumber,
      'chapterTitle': chapterTitle,
      'duration': duration,
      'fileUrl': fileUrl,
      'fileSize': fileSize,
    };
  }
}
