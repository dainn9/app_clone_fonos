class AudiobookChapterModel {
  final String audiobookChapterId;
  final String chapterTitle;
  final String duration;
  final String fileUrl;

  AudiobookChapterModel({
    required this.audiobookChapterId,
    required this.chapterTitle,
    required this.duration,
    required this.fileUrl,
  });

  factory AudiobookChapterModel.fromJson(Map<String, dynamic> json) {
    return AudiobookChapterModel(
      audiobookChapterId: json['audiobookChapterId'] as String,
      chapterTitle: json['chapterTitle'] as String,
      duration: json['duration'] as String,
      fileUrl: json['fileUrl'] as String,
    );
  }
}
