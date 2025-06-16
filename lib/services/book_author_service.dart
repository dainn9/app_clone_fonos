import 'package:dio/dio.dart';

import '../core/api/api_client.dart';

class BookAuthorService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getBooksBySameAuthor(String authorId) =>
      _dio.get('/BookAuthor/same-author', queryParameters: {'authorId': authorId});

  Future<Response> getAuthorsByBookId(String bookId) =>
      _dio.get('/BookAuthor', queryParameters: {'bookId': bookId});

}