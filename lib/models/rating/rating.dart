import '../base_model.dart';

class Rating implements BaseModel {
  final String? ratingId;
  final String? appUserId;
  final String? bookId;
  final double? ratingValue;
  final String? reviewText;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final bool? isVisible;
  final String? userName; // Thêm để hiển thị tên người đánh giá

  Rating({
    this.ratingId,
    this.appUserId,
    this.bookId,
    this.ratingValue,
    this.reviewText,
    this.createdDate,
    this.updatedDate,
    this.isVisible,
    this.userName,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      ratingId: json['ratingId'],
      appUserId: json['appUserId'],
      bookId: json['bookId'],
      ratingValue: json['ratingValue'] != null ? (json['ratingValue'] as num).toDouble() : null,
      reviewText: json['reviewText'],
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : null,
      isVisible: json['isVisible'],
      userName: json['appUser'] != null ? json['appUser']['userName'] : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'ratingId': ratingId,
      'appUserId': appUserId,
      'bookId': bookId,
      'ratingValue': ratingValue,
      'reviewText': reviewText,
      'createdDate': createdDate?.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
      'isVisible': isVisible,
    };
  }
}
