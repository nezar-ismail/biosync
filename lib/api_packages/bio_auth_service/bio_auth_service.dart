// ignore_for_file: unnecessary_getters_setters

import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/database/local_user_model.dart';

import 'auth_api/auth_api.dart';
import '../exception_handler/auth_exception.dart';
import '../model/user_model.dart';

import 'utils/log_info.dart';

class BioAuthService {
  static late final BioAuthService instance;

  final AuthAPI authAPI;
  // final UsersAPI usersAPI;
  PatientModel? _user;
  BioAuthService({
    required this.authAPI,
    // required this.usersAPI,
    PatientModel? user,
  }) : _user = user;

  // Stream controller to notify listeners when the user changes
  final _userController = StreamController<PatientModel?>.broadcast();

  // Stream getter for external classes to listen for user changes
  Stream<PatientModel?> get onUserChanged => _userController.stream;

  PatientModel? get currentUser => _user;
  set currentUser(PatientModel? user) {
    _user = user;

    // Notify listeners that the user has changed
    _userController.add(user);
  }

  static Future<void> init() async {
    // Initialize the WaveAuthService instance.
    instance = BioAuthService(
      authAPI: AuthAPI(),
      // usersAPI: UsersAPI(),
    );

    // Check if the user is already signed in.
    // final uid = await LocalDatabase.getUserUid();
    // if (uid != null) {
    //   try {
    //     // Get the user from the server.
    //     final User user = await instance.getUser(uid: uid);
  }

  /// Checks if the server is running.
  ///
  /// Returns a [Future<Map<String, dynamic>>] containing the server response.
  Future<bool> checkServer() async {
    try {
      bool connected = false;
      final bool response = await authAPI.checkServer();

      switch (response) {
        case true:
          connected = true;
          return connected;
        default:
          connected = false;
          return connected;
      }
    } catch (e) {
      throw Exception('Failed to check server.');
    }
  }

  /// Signs in a user.
  ///
  /// Returns a [Future<User>] containing the server response.
  Future<PatientModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final Response response = await authAPI.signIn(email, password);

      switch (response.statusCode) {
        case 201:
          final data = response.data as Map<String, dynamic>;
          PatientModel user = PatientModel.fromMap(data);
          _storeUserData(user);

          return user;
        case 400:
          //wrong email
          //wrong password
          throw AuthException.fromRespone(response);

        case 401:
          //invalid credentials
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

  void _storeUserData(PatientModel user) {
    LocalUserModel.setUserName(user.username);
    LocalUserModel.setUserEmail(user.useremail);
    LocalUserModel.setUserPhone(user.phone);
    LocalUserModel.setUserImage(user.image);
    LocalUserModel.setUserGender(user.gender);
    LocalUserModel.setUserId(user.id);
  }

  Future<PatientModel> loggedIn(String? id) async {
    try {
      final Response response = await authAPI.loggedIn(id!);
      switch (response.statusCode) {
        case 201:
          final data = response.data as Map<String, dynamic>;
          PatientModel user = PatientModel.fromMap(data);
          _storeUserData(user);
          return user;
        case 400:
          //wrong email
          //wrong password
          throw AuthException.fromRespone(response);

        case 401:
          //invalid credentials
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

  /// Signs up a user.
  ///
  /// Returns a [Future<User>] containing the server response.
  Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required String gender,
    required String phone,
  }) async {
    try {
      final Response response =
          await authAPI.signUp(email, password, username, gender, phone);

      switch (response.statusCode) {
        case 201:
          final data = response.data as Map<String, dynamic>;
          String message = data['message'];
          return message;
        case 409:
          throw AuthException.fromRespone(response);
        case 400:
          throw AuthException.fromRespone(response);
        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign up.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  /// Signs out the current user.
  ///
  /// Returns a [Future<void>] containing the server response.
  Future<void> signOut() async {
    try {
      // Set the current user to null.
      instance.currentUser = null;
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  // Close the stream controller when the service is disposed
  void dispose() {
    _userController.close();
  }
}
