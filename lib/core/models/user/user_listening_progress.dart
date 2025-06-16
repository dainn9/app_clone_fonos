import '../base_model.dart';
import '../audio/audiobook_chapter.dart';

class UserListeningProgress implements BaseModel {
  final String? userListeningProgressId;
  final String? appUserId;
  final String? audiobookChapterId;
  final int? currentPosition;
  final DateTime? lastUpdated;
  final bool? isCompleted;
  final AudiobookChapter? audiobookChapter;

  UserListeningProgress({
    this.userListeningProgressId,
    this.appUserId,
    this.audiobookChapterId,
    this.currentPosition,
    this.lastUpdated,
    this.isCompleted,
    this.audiobookChapter,
  });

  factory UserListeningProgress.fromJson(Map<String, dynamic> json) {
    return UserListeningProgress(
      userListeningProgressId: json['userListeningProgressId'],
      appUserId: json['appUserId'],
      audiobookChapterId: json['audiobookChapterId'],
      currentPosition: json['currentPosition'],
      lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated']) : null,
      isCompleted: json['isCompleted'],
      audiobookChapter: json['audiobookChapter'] != null
          ? AudiobookChapter.fromJson(json['audiobookChapter'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userListeningProgressId': userListeningProgressId,
      'appUserId': appUserId,
      'audiobookChapterId': audiobookChapterId,
      'currentPosition': currentPosition,
      'lastUpdated': lastUpdated?.toIso8601String(),
      'isCompleted': isCompleted,
      'audiobookChapter': audiobookChapter?.toJson(),
    };
  }
}
