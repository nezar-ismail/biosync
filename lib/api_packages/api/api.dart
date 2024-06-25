// ignore_for_file: unused_field, recursive_getters

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../core/database/local_database.dart';

class API {
  final dio = Dio();
  String get baseUrl => baseUrl.toString();

  // Options for the Dio instance.
  Options jsonOptions = Options(
    headers: {'Content-type': 'application/json; charset=UTF-8'},
    responseType: ResponseType.json,
  );

  Options formOptions = Options(
    headers: {'Content-type': 'multipart/form-data'},
    responseType: ResponseType.json,
  );

  /// Checks if the server is running.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<bool> checkServer() async {
    // Construct the URL for the checkServer request.
    BaseOptions baseOptions = BaseOptions(
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        sendTimeout: const Duration(seconds: 3));
    Dio dio1 = Dio(baseOptions);
    // Send a GET request to the server and await the response.
    try {
      final Response response = await dio1.get(LocalDataBase.getIPAddress());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (_) {
      return false;
}
}

  /// get request
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> get(String url, {Map<String, dynamic>? headers}) async {
    // Send a GET request to the server and await the response.
    try {
      final Response response = await dio.get(
        url,
        options: jsonOptions.copyWith(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      if (e.response == null) rethrow;
      return e.response!;
    }
  }

  /// post request
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> post(
    String url, {
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    try {
      final Response response;
      // Check if the body is a dio FormData.
      if (body is FormData) {
        // Send a POST request to the server and await the response.
        response = await dio.post(
          url,
          options: formOptions.copyWith(headers: headers),
          data: body,
        );
      } else {
        // Send a POST request to the server and await the response.
        response = await dio.post(
          url,
          options: jsonOptions.copyWith(headers: headers),
          data: body != null ? jsonEncode(body) : null,
        );
      }

      return response;
    } on DioException catch (e) {
      log('message: ${e.message}');
      if (e.response == null) rethrow;
      return e.response!;
    }
  }

  /// put request
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> put(String url,
      {Map<String, dynamic>? headers, Map<String, dynamic>? body}) async {
    // Send a PUT request to the server and await the response.

    try {
      final Response response = await dio.put(
        url,
        options: jsonOptions.copyWith(headers: headers),
        data: body != null ? jsonEncode(body) : null,
      );

      return response;
    } on DioException catch (e) {
      if (e.response == null) rethrow;
      return e.response!;
    }
  }

  /// putImage request
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> putImage(String url,
      {Map<String, dynamic>? headers, Object? body}) async {
    // Send a PUT request to the server and await the response.

    try {
      final Response response = await dio.put(
        url,
        options: formOptions.copyWith(headers: headers),
        data: body,
      );

      return response;
    } on DioException catch (e) {
      if (e.response == null) rethrow;
      return e.response!;
    }
  }

  /// delete request
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> delete(String url, {Map<String, dynamic>? headers}) async {
    // Send a DELETE request to the server and await the response.
    try {
      final Response response = await dio.delete(
        url,
        options: jsonOptions.copyWith(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      if (e.response == null) rethrow;
      return e.response!;
    }
  }
}
