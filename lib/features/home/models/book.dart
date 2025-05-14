import 'package:flutter/material.dart'; // Make sure this import is at the top of your file

// Then add these class definitions
class Book {
  final String title;
  final String author;
  final Color color;
  final String? tag;
  final String? coverUrl;

  Book({
    required this.title,
    required this.author,
    this.color = Colors.blue,
    this.tag,
    this.coverUrl,
  });
}

class Podcast {
  final String title;
  final String number;
  final String? imageUrl;

  Podcast({
    required this.title,
    required this.number,
    this.imageUrl,
  });
}

class Review {
  final String bookTitle;
  final String author;
  final String reviewerName;
  final String timeAgo;
  final int rating;
  final String comment;

  Review({
    required this.bookTitle,
    required this.author,
    required this.reviewerName,
    required this.timeAgo,
    required this.rating,
    required this.comment,
  });
}
