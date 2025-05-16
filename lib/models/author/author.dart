import '../base_model.dart';

class Author implements BaseModel {
  final String? authorId;
  final String? authorName;
  final String? biography;
  final DateTime? birthDate;
  final DateTime? deathDate;
  final String? nationality;
  final String? imageUrl;

  Author({
    this.authorId,
    this.authorName,
    this.biography,
    this.birthDate,
    this.deathDate,
    this.nationality,
    this.imageUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      authorId: json['authorId'],
      authorName: json['authorName'],
      biography: json['biography'],
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      deathDate: json['deathDate'] != null ? DateTime.parse(json['deathDate']) : null,
      nationality: json['nationality'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'biography': biography,
      'birthDate': birthDate?.toIso8601String(),
      'deathDate': deathDate?.toIso8601String(),
      'nationality': nationality,
      'imageUrl': imageUrl,
    };
  }
}
