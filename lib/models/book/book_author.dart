import '../base_model.dart';
import 'book.dart';
import '../author/author.dart';

class BookAuthor implements BaseModel {
  final String? bookAuthorId;
  final String? bookId;
  final Book? book;
  final String? authorId;
  final Author? author;

  BookAuthor({
    this.bookAuthorId,
    this.bookId,
    this.book,
    this.authorId,
    this.author,
  });

  factory BookAuthor.fromJson(Map<String, dynamic> json) {
    return BookAuthor(
      bookAuthorId: json['bookAuthorId'],
      bookId: json['bookId'],
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      authorId: json['authorId'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'bookAuthorId': bookAuthorId,
      'bookId': bookId,
      'book': book?.toJson(),
      'authorId': authorId,
      'author': author?.toJson(),
    };
  }
}
