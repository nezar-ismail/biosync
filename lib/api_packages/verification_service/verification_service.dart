import 'package:dio/dio.dart';
import '../exception_handler/auth_exception.dart';
import '../model/verification_model.dart';
import 'verification_api/verification_api.dart';

class VerificationService {
  VerificationAPI verificationAPI = VerificationAPI();

  Future<VerificationModel> verificationEmail({required String email}) async {
    try {
      final Response response =
          await verificationAPI.verificationEmail(email: email);

      switch (response.statusCode) {
        case 200:
          final data = response.data as Map<String, dynamic>;
          VerificationModel verificationModel = VerificationModel.fromMap(data);
          return verificationModel;
        case 409:
          throw AuthException.fromRespone(response);
        default:
          throw Exception(
              '[${response.statusCode}].Failed to send verification email.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<VerificationModel> forgetPassword({required String email}) async {
    try {
      final Response response =
          await verificationAPI.forgetPassword(email: email);
      switch (response.statusCode) {
        case 200:
          final data = response.data as Map<String, dynamic>;
          VerificationModel verificationModel = VerificationModel.fromMap(data);
          return verificationModel;

        case 404:
          throw AuthException.fromRespone(response);

        default:
          throw Exception(
              '[${response.statusCode}].Failed to send verification email.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<VerificationModel> setNewPassword(
      {required String email, required String password, required String userType}) async {
    try {
      final Response response = await verificationAPI.setNewPassword(
          email: email, password: password, userType: userType);
      switch (response.statusCode) {
        case 200:
          final data = response.data as Map<String, dynamic>;
          VerificationModel verificationModel = VerificationModel.fromMap(data);
          return verificationModel;

        case 400:
          throw AuthException.fromRespone(response);

        default:
          throw Exception(
              '[${response.statusCode}].Failed to send verification email.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
