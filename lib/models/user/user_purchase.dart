import '../base_model.dart';
import '../book/book.dart';

class UserPurchase implements BaseModel {
  final String? userPurchaseId;
  final String? appUserId;
  final String? bookId;
  final DateTime? purchaseDate;
  final double? purchasePrice;
  final String? paymentMethod;
  final String? transactionId;
  final String? paymentStatus;
  final Book? book;

  UserPurchase({
    this.userPurchaseId,
    this.appUserId,
    this.bookId,
    this.purchaseDate,
    this.purchasePrice,
    this.paymentMethod,
    this.transactionId,
    this.paymentStatus,
    this.book,
  });

  factory UserPurchase.fromJson(Map<String, dynamic> json) {
    return UserPurchase(
      userPurchaseId: json['userPurchaseId'],
      appUserId: json['appUserId'],
      bookId: json['bookId'],
      purchaseDate: json['purchaseDate'] != null ? DateTime.parse(json['purchaseDate']) : null,
      purchasePrice: json['purchasePrice'] != null ? (json['purchasePrice'] as num).toDouble() : null,
      paymentMethod: json['paymentMethod'],
      transactionId: json['transactionId'],
      paymentStatus: json['paymentStatus'],
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userPurchaseId': userPurchaseId,
      'appUserId': appUserId,
      'bookId': bookId,
      'purchaseDate': purchaseDate?.toIso8601String(),
      'purchasePrice': purchasePrice,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'paymentStatus': paymentStatus,
      'book': book?.toJson(),
    };
  }
}
