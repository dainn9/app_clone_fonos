import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import 'local_storage_service.dart';

class AuthService {
  final LocalStorage _localStorage;
  final Dio _dio;

  AuthService(this._localStorage) : _dio = ApiClient.dio;

  Future<bool> postGoogleLogin(String idToken) async {
    try {
      final response = await _dio.post(
        '/Auth/google-login',
        data: {'idToken': idToken},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        final tokensMap = data?['tokens'] as Map<String, dynamic>?;
        final userId = data?['id'] as String?;

        final accessToken = tokensMap?['accessToken'] as String?;
        final refreshToken = tokensMap?['refreshToken'] as String?;

        if (accessToken != null) {
          await _localStorage.saveAuthToken(accessToken);
        }
        if (refreshToken != null) {
          await _localStorage.saveAuthRefreshToken(refreshToken);
        }
        if (userId != null) {
          await _localStorage.saveAuthUserId(userId);
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Error in postGoogleLogin: $e');
      return false;
    }
  }
}
