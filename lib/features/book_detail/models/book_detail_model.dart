class BookDetailModel {
  final String bookId;
  final String title;
  final String coverImageUrl;
  final String description;
  final int rating;
  final int numberOfReviews;
  final String audiobookId;
  final String duration;
  final String publisherId;
  final String publisherName;

  BookDetailModel({
    required this.bookId,
    required this.title,
    required this.coverImageUrl,
    required this.description,
    required this.rating,
    required this.numberOfReviews,
    required this.audiobookId,
    required this.duration,
    required this.publisherId,
    required this.publisherName,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    return BookDetailModel(
      bookId: json['bookId'] ?? '',
      title: json['title'] ?? '',
      coverImageUrl: json['coverImageUrl'] ?? '',
      description: json['description'] ?? '',
      rating: json['rating'] ?? 0,
      numberOfReviews: json['numberOfReviews'] ?? 0,
      audiobookId: json['audiobook']?['audiobookId'] ?? '',
      duration: json['audiobook']?['duration'] ?? '',
      publisherId: json['publisher']?['publisherId'] ?? '',
      publisherName: json['publisher']?['publisherName'] ?? '',
    );
  }
}
