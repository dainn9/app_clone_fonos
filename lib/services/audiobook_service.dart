import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class AudiobookService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getAudiobookDetail(String audiobookId) => _dio.get(
    '/Audiobook/detail',
    queryParameters: {'audiobookId': audiobookId},
  );
}
