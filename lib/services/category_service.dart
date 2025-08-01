import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class CategoryService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getCategories() => _dio.get('/Category');

  Future<Response> getBooksByCategoryId(String categoryId) =>
      _dio.get('/BookCategory', queryParameters: {'categoryId': categoryId});
}
