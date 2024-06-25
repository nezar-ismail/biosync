// ignore_for_file: unnecessary_getters_setters

import 'dart:async';

import 'package:dio/dio.dart';

import '../bio_auth_service/utils/log_info.dart';

import '../model/user_model.dart';
import '../model_image_api_service/model_image_api/model_image_api.dart';
import 'patient_api/patient_api.dart';

import '../exception_handler/auth_exception.dart';

class PatientService {
  static late final PatientService instance;

  final PatientAPI usersAPI;
  final ImageAPI imageAPI;

  PatientService({
    required this.usersAPI,
    required this.imageAPI,
    PatientModel? user,
  });

  static Future<void> init() async {
    instance = PatientService(
      imageAPI: ImageAPI(),
      usersAPI: PatientAPI(),
    );

    // }
  }

  /// post image.
  ///
  /// Returns a [Future<image>] containing the server response.
  Future<PatientModel> updateInfo({
    required int userId,
    required String name,
    required String phone,
    required String password,
  }) async {
    try {
      final Response response = await usersAPI.updateUser(
          username: name, phone: phone, password: password, uid: userId);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          PatientModel userModel = PatientModel.fromMap(data);
          return userModel;

        case 401:
          //password wrong
          throw AuthException.fromRespone(response);

        case 400:
          //phone error or username error
          throw AuthException.fromRespone(response);

        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  //
  Future<String> updatePassword({
    required int userId,
    required String newpassword,
    required String oldpassword,
  }) async {
    try {
      final Response response = await usersAPI.updatePassword(
          newpassword: newpassword, oldpassword: oldpassword, uid: userId);

      switch (response.statusCode) {
        case 201:
          // success
          return 'success';

        case 400:
          //password wrong
          throw AuthException.fromRespone(response);

        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  Future<Map<String, dynamic>> updateImage({
    required MultipartFile file,
    required int userId,
  }) async {
    try {
      final Response response = await imageAPI.updatePatientImage(file, userId);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;

          return data;

        case 400:
          //No image
          throw AuthException.fromRespone(response);
        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  Future<Map<String, dynamic>> updateDoctorImage({
    required MultipartFile file,
    required int userId,
  }) async {
    try {
      final Response response = await imageAPI.updatePatientImage(file, userId);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;

          return data;

        case 400:
          //No image
          throw AuthException.fromRespone(response);
        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }
}
