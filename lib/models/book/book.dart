import 'dart:convert';
import '../base_model.dart';
import '../audio/audiobook.dart';
import 'publisher.dart';
import '../rating/rating.dart';

class Book implements BaseModel {
  final String? bookId;
  final String? title;
  final String? isbn;
  final String? publisherId;
  final int? publicationYear;
  final String? description;
  final String? coverImageUrl;
  final int? pageCount;
  final String? language;
  final double? price;
  final bool? isActive;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final Audiobook? audiobook;
  final Publisher? publisher;
  final List<Rating>? ratings;
  final double? rating;
  final int? numberOfReviews;

  Book({
    this.bookId,
    this.title,
    this.isbn,
    this.publisherId,
    this.publicationYear,
    this.description,
    this.coverImageUrl,
    this.pageCount,
    this.language,
    this.price,
    this.isActive,
    this.createdDate,
    this.updatedDate,
    this.audiobook,
    this.publisher,
    this.ratings,
    this.rating,
    this.numberOfReviews,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'],
      title: json['title'],
      isbn: json['isbn'],
      publisherId: json['publisherId'],
      publicationYear: json['publicationYear'],
      description: json['description'],
      coverImageUrl: json['coverImageUrl'],
      pageCount: json['pageCount'],
      language: json['language'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      rating:
          json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      isActive: json['isActive'],
      createdDate:
          json['createdDate'] != null
              ? DateTime.parse(json['createdDate'])
              : null,
      updatedDate:
          json['updatedDate'] != null &&
                  json['updatedDate'] != "0001-01-01T00:00:00"
              ? DateTime.parse(json['updatedDate'])
              : null,
      audiobook:
          json['audiobook'] != null
              ? Audiobook.fromJson(json['audiobook'])
              : null,
      publisher:
          json['publisher'] != null
              ? Publisher.fromJson(json['publisher'])
              : null,
      ratings:
          json['ratings'] != null
              ? List<Rating>.from(
                json['ratings'].map((x) => Rating.fromJson(x)),
              )
              : null,
      numberOfReviews: json['numberOfReviews'] ?? 0,
    );
  }

  factory Book.fromJsonTopRating(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'],
      title: json['title'],
      isbn: json['isbn'],
      publicationYear: json['publicationYear'],
      description: json['description'],
      coverImageUrl: json['coverImageUrl'],
      pageCount: json['pageCount'],
      language: json['language'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      numberOfReviews: json['numberOfReviews'], // Parse trường mới
      isActive: json['isActive'],
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
      updatedDate: json['updatedDate'] != null && json['updatedDate'] != "0001-01-01T00:00:00"
          ? DateTime.parse(json['updatedDate'])
          : null,
      audiobook: json['audiobook'] != null ? Audiobook.fromJson(json['audiobook']) : null,
      publisher: json['publisher'] != null ? Publisher.fromJson(json['publisher']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'isbn': isbn,
      'publisherId': publisherId,
      'publicationYear': publicationYear,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'pageCount': pageCount,
      'language': language,
      'price': price,
      'isActive': isActive,
      'createdDate': createdDate?.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
      'audiobook': audiobook?.toJson(),
      'publisher': publisher?.toJson(),
      'ratings':
          ratings != null ? ratings!.map((x) => x.toJson()).toList() : null,
      'rating': rating,
      'numberOfReviews': numberOfReviews
    };
  }

}
