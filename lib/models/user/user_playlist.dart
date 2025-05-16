import '../base_model.dart';
import 'playlist_item.dart';

class UserPlaylist implements BaseModel {
  final String? userPlaylistId;
  final String? appUserId;
  final String? playlistName;
  final String? description;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final bool? isPublic;
  final List<PlaylistItem>? items;

  UserPlaylist({
    this.userPlaylistId,
    this.appUserId,
    this.playlistName,
    this.description,
    this.createdDate,
    this.updatedDate,
    this.isPublic,
    this.items,
  });

  factory UserPlaylist.fromJson(Map<String, dynamic> json) {
    return UserPlaylist(
      userPlaylistId: json['userPlaylistId'],
      appUserId: json['appUserId'],
      playlistName: json['playlistName'],
      description: json['description'],
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : null,
      isPublic: json['isPublic'],
      items: json['items'] != null
          ? List<PlaylistItem>.from(json['items'].map((x) => PlaylistItem.fromJson(x)))
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userPlaylistId': userPlaylistId,
      'appUserId': appUserId,
      'playlistName': playlistName,
      'description': description,
      'createdDate': createdDate?.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
      'isPublic': isPublic,
      'items': items != null ? items!.map((x) => x.toJson()).toList() : null,
    };
  }
}
