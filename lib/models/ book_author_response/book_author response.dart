import '../base_model.dart';
import '../book/book.dart';
import '../author/author.dart';

class BookAuthorResponse implements BaseModel {
  final Book? book;
  final Author? author;

  BookAuthorResponse({
    this.book,
    this.author,
  });

  factory BookAuthorResponse.fromJson(Map<String, dynamic> json) {
    return BookAuthorResponse(
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'book': book?.toJson(),
      'author': author?.toJson(),
    };
  }
}
