import '../base_model.dart';
import '../book/book.dart';

class UserFavorite implements BaseModel {
  final String? userFavoriteId;
  final String? appUserId;
  final String? bookId;
  final DateTime? addedDate;
  final Book? book;

  UserFavorite({
    this.userFavoriteId,
    this.appUserId,
    this.bookId,
    this.addedDate,
    this.book,
  });

  factory UserFavorite.fromJson(Map<String, dynamic> json) {
    return UserFavorite(
      userFavoriteId: json['userFavoriteId'],
      appUserId: json['appUserId'],
      bookId: json['bookId'],
      addedDate: json['addedDate'] != null ? DateTime.parse(json['addedDate']) : null,
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userFavoriteId': userFavoriteId,
      'appUserId': appUserId,
      'bookId': bookId,
      'addedDate': addedDate?.toIso8601String(),
      'book': book?.toJson(),
    };
  }
}
