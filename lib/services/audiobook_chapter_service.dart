import 'package:dio/dio.dart';
import '../core/api/api_client.dart';

class AudiobookChapterService {
  final Dio _dio = ApiClient.dio;

  Future<Response> getAudioBookChapterByAudioBookId(String audioBookId) =>
      _dio.get('/AudiobookChapter', queryParameters: {
        'audioBookId': audioBookId,
      });
}