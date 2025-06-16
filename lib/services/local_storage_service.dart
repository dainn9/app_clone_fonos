import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveEmailForSignIn(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailForSignIn', email);
  }

  Future<String?> getEmailForSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('emailForSignIn');
  }

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> saveAuthRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_refreshToken', token);
  }

  Future<String?> getAuthRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_refreshToken');
  }

  Future<void> saveAuthUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_userId', id);
  }

  Future<String?> getAuthUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_userId');
  }

  Future<void> removeEmailForSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('emailForSignIn');
  }
}
