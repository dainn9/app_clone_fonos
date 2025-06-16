class BookModel {
  final String bookId;
  final String title;
  final String coverImageUrl;

  BookModel({required this.bookId, required this.title,required this.coverImageUrl});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      bookId: json['bookId'],
      title: json['title'],
      coverImageUrl: json['coverImageUrl'],
    );
  }
}
