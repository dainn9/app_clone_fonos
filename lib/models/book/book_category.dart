import '../base_model.dart';
import 'book.dart';
import '../category/category.dart';

class BookCategory implements BaseModel {
  final String? bookCategoryId;
  final String? bookId;
  final Book? book;
  final String? categoryId;
  final Category? category;

  BookCategory({
    this.bookCategoryId,
    this.bookId,
    this.book,
    this.categoryId,
    this.category,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) {
    return BookCategory(
      bookCategoryId: json['bookCategoryId'],
      bookId: json['bookId'],
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      categoryId: json['categoryId'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'bookCategoryId': bookCategoryId,
      'bookId': bookId,
      'book': book?.toJson(),
      'categoryId': categoryId,
      'category': category?.toJson(),
    };
  }
}
