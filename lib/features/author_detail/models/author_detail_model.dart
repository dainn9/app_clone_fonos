class AuthorDetailModel {
  final String authorId;
  final String authorName;
  final String biography;
  final String imageUrl;

  AuthorDetailModel({
    required this.authorId,
    required this.authorName,
    required this.biography,
    required this.imageUrl
});

  factory AuthorDetailModel.fromJson(Map<String, dynamic> json) {
    return AuthorDetailModel(
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      biography: json['biography'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
