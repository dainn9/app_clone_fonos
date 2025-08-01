import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class BookService {
  final Dio _dio = ApiClient.dio;

  Map<String, dynamic>? _buildQueryParams({int? limit, String? query}) {
    final Map<String, dynamic> params = {};

    if (limit != null) params['limit'] = limit.toString();
    if (query != null && query.isNotEmpty) params['searching'] = query;

    return params.isEmpty ? null : params;
  }

  Future<Response> getBooks({int? limit, String? query}) => _dio.get(
    '/Book/mobile-option',
    queryParameters: _buildQueryParams(limit: limit, query: query),
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
