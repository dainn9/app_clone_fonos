import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class BookService {
  final Dio _dio = ApiClient.dio;

  Map<String, dynamic>? _buildQueryParams({int? limit}) {
    return (limit != null) ? {'limit': limit.toString()} : null;
  }

  Future<Response> getBooks({int? limit}) => _dio.get(
    '/Book/mobile-option',
    queryParameters: _buildQueryParams(limit: limit),
  );

  Future<Response> getTopRatingBooks({int? limit}) => _dio.get(
    '/Book/top-rating',
    queryParameters: _buildQueryParams(limit: limit),
  );

  Future<Response> getNewBooks({int? limit}) =>
      _dio.get('/Book/new', queryParameters: _buildQueryParams(limit: limit));

  Future<Response> getSamePublisherBooks(String publisherId, {int? limit}) {
    final params = {
      'publisherId': publisherId,
      if (limit != null) 'limit': limit,
    };

    return _dio.get('/Book/same-publisher', queryParameters: params);
  }

  Future<Response> getDetailBooks(String bookId) => _dio.get('/Book/$bookId');
}
