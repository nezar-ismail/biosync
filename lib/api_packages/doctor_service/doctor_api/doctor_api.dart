// ignore_for_file: unused_field, unused_import

import 'dart:io';

import 'package:dio/dio.dart';
import '../../../core/database/local_database.dart';

import '../../api/api.dart';

class DoctorAPI extends API {
  /// Signs in a doctor.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> signIn(
      {required String email, required String password}) async {
    // Construct the URL for the signIn request.
    String url = '${LocalDataBase.getIPAddress()}/doctor/login';

    // Construct the body for the signIn request.
    final Map<String, dynamic> body = {
      'doctoremail': email,
      'password': password,
    };

    // Send a POST request to the server and await the response.
    final Response response = await post(
      url,
      body: body,
    );

    return response;
  }

  Future<Response> loggedIn(String id) async {
    String url = '${LocalDataBase.getIPAddress()}/loggedin';
    final Map<String, dynamic> body = {"type": "doctor", "id": id};
    final Response response = await post(url, body: body);
    return response;
  }

  ///Get all doctor
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> getAllDoctor() async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/getall';

    final Response response = await get(url);
    return response;
  }

  ///Get best doctor
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> getBestDoctor() async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/best';

    final Response response = await get(url);
    return response;
  }

  ///Get doctor by id
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> getDoctorById({required int id}) async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/$id';

    final Response response = await get(url);
    return response;
  }

  ///Update doctor password
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> updateDoctorPassword(
      {required int id,
      required String newpassword,
      required String oldpassword}) async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/password/$id';

    final Map<String, dynamic> body = {
      'newpassword': newpassword,
      'oldpassword': oldpassword,
    };

    Response response = await put(url, body: body);
    return response;
  }

  ///Update doctor phone
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> updateDoctorPhone(
      {required int id, required String phone}) async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/phone/$id';

    final Map<String, dynamic> body = {
      'phone': phone,
    };

    Response response = await put(url, body: body);
    return response;
  }

  /// Send doctor request
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> sendDoctorRequest({required String email}) async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/signup/request';

    final Map<String, dynamic> body = {
      'email': email,
    };

    Response response = await post(url, body: body);
    return response;
  }

  ///doctor review
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> doctorReview({
    required int pID,
    required int dID,
    required double ratting,
  }) async {
    // Construct the URL for the signIn request.
    String url = '${LocalDataBase.getIPAddress()}/review/add';

    // Construct the body for the signIn request.
    final Map<String, dynamic> body = {
      "doctor_id": dID,
      "user_id": pID,
      "ratting": ratting
    };

    // Send a POST request to the server and await the response.
    final Response response = await post(
      url,
      body: body,
    );

    return response;
  }

  ///doctor review
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> editWorksDay({
    required int ID,
    required Map<String, dynamic> day,
  }) async {
    // Construct the URL for the signIn request.
    String url = '${LocalDataBase.getIPAddress()}/doctor/edit/workday/$ID';

    // Construct the body for the signIn request.
    final Map<String, dynamic> body = {
      "workday": day,
    };

    // Send a POST request to the server and await the response.
    final Response response = await put(
      url,
      body: body,
    );

    return response;
  }
}
