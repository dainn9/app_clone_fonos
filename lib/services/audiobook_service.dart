// Lưu vào lib/api/audiobook_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/models/audio/audiobook_models.dart';



class AudiobookService {
  static Future<AudiobookDetail> getAudiobookDetail(String audiobookId) async {
    final url = Uri.parse('http://10.0.2.2:5022/api/Audiobook/detail?audiobookId=$audiobookId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return AudiobookDetail.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load audiobook: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching audiobook: $e');
    }
  }
}
