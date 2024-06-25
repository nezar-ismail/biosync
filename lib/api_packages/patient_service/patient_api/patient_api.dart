// ignore_for_file: unused_field, unused_import

import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../../core/database/local_database.dart';
import 'package:meta/meta.dart';

class PatientAPI extends API {
  final String baseRoute = 'users';

  /// Updates a user.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> updateUser(
      {required int uid,
      required String username,
      required String phone,
      required String password}) async {
    // Construct the URL for the updateUser request.
    final String url = '${LocalDataBase.getIPAddress()}/user/edit/$uid';

    // Construct the body for the updateUser request.
    final Map<String, dynamic> body = {
      'username': username,
      'phone': phone,
      'password': password,
    };

    // Send a PUT request to the server and await the response.
    final Response response = await put(url, body: body);

    return response;
  }

  /// Update Password.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> updatePassword({
    required int uid,
    required String newpassword,
    required String oldpassword,
  }) async {
    // Construct the URL for the updateUser request.
    final String url = '${LocalDataBase.getIPAddress()}/user/password/$uid';

    // Construct the body for the updateUser request.
    final Map<String, dynamic> body = {
      'newpassword': newpassword,
      'oldpassword': oldpassword,
    };

    // Send a PUT request to the server and await the response.
    final Response response = await put(url, body: body);

    return response;
  }

  Future<Response> loggedIn(String? id) async {
    String url = '${LocalDataBase.getIPAddress()}/loggedin';
    final Map<String, dynamic> body = {"type": "patient", "id": id!};
    final Response response = await post(url, body: body);
    return response;
  }
}
