import '../base_model.dart';
import '../audio/audiobook_chapter.dart';

class UserBookmark implements BaseModel {
  final String? userBookmarkId;
  final String? appUserId;
  final String? audiobookChapterId;
  final String? position;
  final String? bookmarkName;
  final String? notes;
  final DateTime? createdDate;
  final AudiobookChapter? audiobookChapter;

  UserBookmark({
    this.userBookmarkId,
    this.appUserId,
    this.audiobookChapterId,
    this.position,
    this.bookmarkName,
    this.notes,
    this.createdDate,
    this.audiobookChapter,
  });

  factory UserBookmark.fromJson(Map<String, dynamic> json) {
    return UserBookmark(
      userBookmarkId: json['userBookmarkId'],
      appUserId: json['appUserId'],
      audiobookChapterId: json['audiobookChapterId'],
      position: json['position'],
      bookmarkName: json['bookmarkName'],
      notes: json['notes'],
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      audiobookChapter: json['audiobookChapter'] != null
          ? AudiobookChapter.fromJson(json['audiobookChapter'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userBookmarkId': userBookmarkId,
      'appUserId': appUserId,
      'audiobookChapterId': audiobookChapterId,
      'position': position,
      'bookmarkName': bookmarkName,
      'notes': notes,
      'createdDate': createdDate?.toIso8601String(),
      'audiobookChapter': audiobookChapter?.toJson(),
    };
  }
}
