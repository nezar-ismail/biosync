import 'package:bloc/bloc.dart';
import '../../../../api_packages/bio_auth_service/auth_api/auth_api.dart';
import '../../../../api_packages/bio_auth_service/bio_auth_service.dart';
import '../../../../api_packages/doctor_service/doctor_api/doctor_api.dart';
import '../../../../api_packages/doctor_service/doctor_service.dart';
import '../../../../api_packages/exception_handler/auth_exception.dart';
import '../../../../api_packages/model/verification_model.dart';
import '../../../../api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import '../../../../api_packages/model/doctor_model.dart';
import '../../../../api_packages/model/user_model.dart';
import '../../../../api_packages/verification_service/verification_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  PatientModel? user;
  DoctorModel? doctor;
  VerificationModel? verificationModel;

  String? message;
  Future signIn({required String email, required String password}) async {
    try {
      user = await BioAuthService(authAPI: AuthAPI())
          .signIn(email: email, password: password);
      emit(LoginCubitSuccess());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 401) {
          emit(LoginCubitInvalid());
        } else if (e.statusCode == 400) {
          if (e.message ==
              "Password must be at least 8 characters long and contain at least one letter.") {
            emit(LoginCubitWrongPassword());
          } else {
            emit(LoginCubitWrongEmail());
          }
        }
      } else {
        emit(SignUpCubitError(message: 'this is error $e'));
      }
    }
  }

  setLoding() {
    emit(VerificationLoading());
  }

  setForget() {
    emit(ForgetPassword());
  }

  setCodeVerified() {
    emit(CodeVerified());
  }

  setInit() {
    emit(AuthInitial());
  }

  signUp(
      {required String email,
      required String password,
      required String username,
      required String gender,
      required String phone}) async {
    try {
      message = await BioAuthService(authAPI: AuthAPI()).signUp(
          email: email,
          password: password,
          username: username,
          gender: gender,
          phone: phone);
      emit(SignUpCubitSuccess());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 409) {
          emit(SignUpCubitEmailIsExist());
        } else if (e.statusCode == 400) {
          if (e.message ==
              "Password must be at least 8 characters long and contain at least one letter.") {
            emit(SignUpCubitPassInvalid());
          } else if (e.message == "Invalid email address.") {
            emit(SignUpCubitEmailInvalid());
          } else if (e.message == "Invalid phone number.") {
            emit(SignUpCubitErrorPhone());
          } else if (e.message ==
              "Username must be at least 3 characters long and contain only letters.") {
            emit(SignUpCubitErrorUserName());
          } else {
            emit(SignUpCubitError(message: 'this is error $e'));
          }
        } else {
          emit(SignUpCubitError(message: 'this is error $e'));
        }
      } else {
        emit(SignUpCubitError(message: 'this is error $e'));
      }
    }
  }

  verificationEmail({required String email}) async {
    try {
      verificationModel =
          await VerificationService().verificationEmail(email: email);
      emit(VerificationEmailSuccess(code: verificationModel!));
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 409) {
          emit(VerificationEmailError(message: 'this is error $e'));
        } else {
          throw Exception('this is error $e');
        }
      }
      emit(VerificationPasswordError(message: 'this is error $e'));
    }
  }

  sendSignUpRequest({required String email}) async {
    try {
      final String response =
          await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
              .sendDoctorRequest(email: email);
      emit(SignUpRequestSuccess(message: response));
    } catch (e) {
      if (e is AuthException) {
        emit(SignUpRequestReject(message: 'this is error $e'));
      }
      emit(SignUpRequestReject(message: 'this is error $e'));
    }
  }

  ///verify
  verificationPassword({required String email}) async {
    try {
      verificationModel =
          await VerificationService().forgetPassword(email: email);
      emit(VerificationPasswordSuccess(code: verificationModel!));
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 404) {
          emit(VerificationPasswordError(message: 'this is error $e'));
        } else {
          throw Exception('this is error $e');
        }
      }
      emit(VerificationPasswordError(message: 'this is error $e'));
    }
  }

  setNewPassword(
      {required String email,
      required String password,
      required String userType}) async {
    try {
      verificationModel = await VerificationService()
          .setNewPassword(email: email, password: password, userType: userType);
      emit(PasswordUpdated());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 400) {
          emit(PasswordUpdateError(message: 'this is error $e'));
        } else {
          throw Exception('this is error $e');
        }
      }
      emit(PasswordUpdateError(message: 'this is error $e'));
    }
  }

  Future doctorSignIn({required String email, required String password}) async {
    try {
      doctor = await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
          .signIn(email: email, password: password);
      emit(LoginDoctorCubitSuccess());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 401) {
          emit(LoginCubitInvalid());
        } else if (e.statusCode == 400) {
          if (e.message ==
              "Password must be at least 8 characters long and contain at least one letter.") {
            emit(LoginCubitWrongPassword());
          } else {
            emit(LoginCubitWrongEmail());
          }
        }
      } else {
        emit(SignUpCubitError(message: 'this is error $e'));
      }
    }
  }
}
