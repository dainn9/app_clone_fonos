import 'package:app_clone_fonos/core/utils/app_constants.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30  ),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}
