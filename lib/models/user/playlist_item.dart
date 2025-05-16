import '../base_model.dart';
import '../book/book.dart';

class PlaylistItem implements BaseModel {
  final String? playlistItemId;
  final DateTime? addedDate;
  final String? displayOrder;
  final String? userPlaylistId;
  final String? bookId;
  final Book? book;

  PlaylistItem({
    this.playlistItemId,
    this.addedDate,
    this.displayOrder,
    this.userPlaylistId,
    this.bookId,
    this.book,
  });

  factory PlaylistItem.fromJson(Map<String, dynamic> json) {
    return PlaylistItem(
      playlistItemId: json['playlistItemId'],
      addedDate: json['addedDate'] != null ? DateTime.parse(json['addedDate']) : null,
      displayOrder: json['displayOrder'],
      userPlaylistId: json['userPlaylistId'],
      bookId: json['bookId'],
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'playlistItemId': playlistItemId,
      'addedDate': addedDate?.toIso8601String(),
      'displayOrder': displayOrder,
      'userPlaylistId': userPlaylistId,
      'bookId': bookId,
      'book': book?.toJson(),
    };
  }
}
