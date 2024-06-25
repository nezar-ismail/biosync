// ignore_for_file: unused_field, unused_import

import 'package:dio/dio.dart';
import '../../../core/database/local_database.dart';

import '../../api/api.dart';

class AuthAPI extends API {
  /// Signs in a user.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> signIn(String email, String password) async {
    // Construct the URL for the signIn request.
    String url = '${LocalDataBase.getIPAddress()}/user/login';

    // Construct the body for the signIn request.
    final Map<String, dynamic> body = {
      'useremail': email,
      'password': password,
    };

    // Send a POST request to the server and await the response.
    final Response response = await post(
      url,
      body: body,
    );

    return response;
  }

  /// Signs up a user.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> signUp(
    String email,
    String password,
    String username,
    String gender,
    String phone,
  ) async {
    // Construct the URL for the signUp request.
    String url = '${LocalDataBase.getIPAddress()}/user/register';

    // Construct the body for the signUp request.
    final Map<String, dynamic> body = {
      'useremail': email,
      'password': password,
      'username': username,
      'gender': gender,
      'phone': phone,
    };

    // Send a POST request to the server and await the response.
    final Response response = await post(
      url,
      body: body,
    );

    return response;
  }

  Future<Response> loggedIn(String? id) async {
    String url = '${LocalDataBase.getIPAddress()}/loggedin';
    final Map<String, dynamic> body = {"type": "patient", "id": id!};
    final Response response = await post(url, body: body);
    return response;
  }
}
