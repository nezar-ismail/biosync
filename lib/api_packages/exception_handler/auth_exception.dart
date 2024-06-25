import 'package:dio/dio.dart';

class AuthException implements Exception {
  String message;
  int? statusCode;
  AuthException({this.message = 'unknown error', this.statusCode});
  @override
  String toString() => '[$statusCode].$message}';

  static AuthException fromRespone(Response response) {
    final String message =
        response.data['message'] ?? 'An unknown error occurred.';
    final int? statusCode = response.statusCode;

    return AuthException(
      message: message,
      statusCode: statusCode,
    );
  }
}
