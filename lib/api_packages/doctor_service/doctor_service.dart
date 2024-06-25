// ignore_for_file: unnecessary_getters_setters

import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../bio_auth_service/utils/log_info.dart';
import 'doctor_api/doctor_api.dart';
import '../model_image_api_service/model_image_api/model_image_api.dart';
import '../model/doctor_model.dart';
import '../../core/database/doctor_hive/local_doctor_model.dart';
import '../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../core/database/local_user_model.dart';

import '../exception_handler/auth_exception.dart';

class DoctorService {
  static late final DoctorService instance;

  final DoctorAPI doctorAPI;
  final ImageAPI imageAPI;

  DoctorService({
    required this.doctorAPI,
    required this.imageAPI,
    DoctorModel? doctor,
  });

  static Future<void> init() async {
    instance = DoctorService(
      doctorAPI: DoctorAPI(),
      imageAPI: ImageAPI(),
    );

    // }
  }

  /// signIn.
  ///
  /// Returns a [Future<image>] containing the server response.
  Future<DoctorModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final Response response = await doctorAPI.signIn(
        email: email,
        password: password,
      );

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          DoctorModel doctorModel = DoctorModel.fromMap(data);
          _storeUserData(doctorModel);
          return doctorModel;

        case 401:
          //Invalid credentials.
          throw AuthException.fromRespone(response);

        case 400:
          //Password must be at least 8 characters long and contain at least one letter.
          //Invalid email address.
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

  Future<DoctorModel> loggedIn(String id) async {
    try {
      final Response response = await doctorAPI.loggedIn(id);
      switch (response.statusCode) {
        case 201:
          final data = response.data as Map<String, dynamic>;
          DoctorModel user = DoctorModel.fromMap(data);
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

  void _storeUserData(DoctorModel user) {
    LocalUserModel.setUserName(user.doctorname);
    LocalUserModel.setUserEmail(user.doctoremail);
    LocalUserModel.setUserPhone(user.phone);
    LocalUserModel.setUserImage(user.image);
    LocalUserModel.setUserGender(user.gender);
    LocalUserModel.setUserId(user.id);
    LocalUserModel.setWorkday(user.workday!);
    LocalUserModel.setExperience(user.experience);
    LocalUserModel.setAbout(user.about);
    LocalUserModel.setRating(user.averageRating);
    LocalUserModel.setSpecialization(user.specialization);
    LocalUserModel.setUserId(user.id);
  }

  /// post review.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<String> addReview({
    required int pID,
    required int dID,
    required double ratting,
  }) async {
    try {
      final Response response = await doctorAPI.doctorReview(
        pID: pID,
        dID: dID,
        ratting: ratting,
      );

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          return data['message'];

        case 409:
          //review already exist.
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

  /// edit works day.
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<void> editDays({
    required int ID,
    required Map<String, dynamic> day,
  }) async {
    try {
      final Response response = await doctorAPI.editWorksDay(ID: ID, day: day);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          log(data['workday'].toString());
          List<String> workDayList = [];
          for (int i = 0; i < data['workday'].length; i++) {
            workDayList.add(data['workday'][i].toString());
          }

          LocalUserModel.setWorkday(workDayList);
          log(LocalUserModel.getWorkday().toString());

        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to edit days.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  /// get all doctor.
  ///
  /// Returns a [Future<List<DoctorModel>>] containing the server response.
  Future<List<DoctorModel>> getAllDoctor() async {
    try {
      final Response response = await doctorAPI.getAllDoctor();

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as List<dynamic>;
          List<DoctorModel> doctorList = [];
          DoctorModel doctorModel;

          for (int i = 0; i < data.length; i++) {
            doctorModel = DoctorModel.fromMap(data[i]);
            LocalDoctorModel localDoctorModel = storeLocalModel(doctorModel, i);
            doctorList.add(doctorModel);
            LocalDoctorModelService.addOrUpdateDoctor(localDoctorModel);
          }

          return doctorList;

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

  /// get best doctor.
  ///
  /// Returns a [Future<List<DoctorModel>>] containing the server response.
  Future<List<DoctorModel>> getBestDoctor() async {
    try {
      final Response response = await doctorAPI.getBestDoctor();

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as List<dynamic>;
          List<DoctorModel> doctorList = [];
          DoctorModel doctorModel;

          for (int i = 0; i < data.length; i++) {
            doctorModel = DoctorModel.fromMap(data[i]);

            doctorList.add(doctorModel);
          }

          return doctorList;

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

  LocalDoctorModel localBestDoctor(List<dynamic> data, int i) {
    return LocalDoctorModel(
      averageRating: data[i]['average_rating'],
      doctorEmail: data[i]['doctoremail'],
      doctorName: data[i]['doctorname'],
      gender: data[i]['gender'],
      id: data[i]['id'],
      image: data[i]['image'],
      phone: data[i]['phone'],
      specialization: data[i]['specialization'],
      workDay: data[i]['workday'],
      experience: data[i]['experience'],
      about: data[i]['about'],
    );
  }

  LocalDoctorModel storeLocalModel(DoctorModel data, int i) {
    var localDoctorModel = LocalDoctorModel(
      averageRating: data.averageRating,
      doctorEmail: data.doctoremail,
      doctorName: data.doctorname,
      gender: data.gender,
      id: data.id,
      image: data.image,
      phone: data.phone,
      specialization: data.specialization,
      workDay: data.workday,
      experience: data.experience,
      about: data.about,
    );
    return localDoctorModel;
  }

  /// get doctor by id.
  ///
  /// Returns a [Future<DoctorModel>] containing the server response.
  Future<DoctorModel> getDoctorById({required int id}) async {
    try {
      final Response response = await doctorAPI.getDoctorById(id: id);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          DoctorModel doctorModel = DoctorModel.fromMap(data);
          LocalDoctorModelService.addOrUpdateDoctor(
              storeLocalModel(doctorModel, 0));
          return doctorModel;

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

  /// update doctor password.
  ///
  /// Returns a [Future<String>] containing the server response.
  Future<String> updateDoctorPassword(
      {required int id,
      required String newpassword,
      required String oldpassword}) async {
    try {
      final Response response = await doctorAPI.updateDoctorPassword(
          id: id, newpassword: newpassword, oldpassword: oldpassword);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;

          return data['message'] as String;

        case 401:
          //Invalid credentials.
          throw AuthException.fromRespone(response);

        case 400:
          //Password must be at least 8 characters long and contain at least one letter.

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

  /// send doctor request.
  ///
  /// Returns a [Future<String>] containing the server response.
  Future<String> sendDoctorRequest({required String email}) async {
    try {
      final Response response = await doctorAPI.sendDoctorRequest(email: email);

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as Map<String, dynamic>;
          return data['message'] as String;

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

  /// update doctor phone.
  ///
  /// Returns a [Future<String>] containing the server response.
  Future<String> updateDoctorPhone({
    required int id,
    required String phone,
  }) async {
    try {
      final Response response =
          await doctorAPI.updateDoctorPhone(id: id, phone: phone);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          String message = data['message'] as String;
          LocalUserModel.setUserPhone(message);
          return message;

        case 401:
          //Invalid credentials.
          throw AuthException.fromRespone(response);

        case 400:
          //Password must be at least 8 characters long and contain at least one letter.

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

  /// update doctor image.
  ///
  /// Returns a [Future<String>] containing the server response.
  Future<Map<String, dynamic>> updateDoctorImage({
    required int id,
    required MultipartFile file,
  }) async {
    try {
      final Response response = await imageAPI.updateDoctorImage(
        id: id,
        file: file,
      );

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;

          return data;

        case 400:
          //Password must be at least 8 characters long and contain at least one letter.

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
