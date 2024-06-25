import 'package:bloc/bloc.dart';
import '../../../../api_packages/doctor_service/doctor_api/doctor_api.dart';
import '../../../../api_packages/doctor_service/doctor_service.dart';
import '../../../../api_packages/exception_handler/auth_exception.dart';
import '../../../../api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import '../../../../api_packages/patient_service/patient_api/patient_api.dart';
import '../../../../api_packages/patient_service/patient_service.dart';
import 'package:meta/meta.dart';

part 'edit_password_state.dart';

class EditPasswordCubit extends Cubit<EditPasswordState> {
  EditPasswordCubit() : super(EditPasswordInitial());
  String? success;
  updatePatientPassword({
    required String oldPassword,
    required String newPassword,
    required int userId,
  }) async {
    try {
      success = await PatientService(
        usersAPI: PatientAPI(),
        imageAPI: ImageAPI(),
      ).updatePassword(
          userId: userId, newpassword: newPassword, oldpassword: oldPassword);

      emit(EditPasswordSuccess());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 400) {
          if (e.message ==
              "Old password must be at least 8 characters long and contain at least one letter.") {
            emit(OldPasswordError());
          } else {
            emit(NewPasswordError());
          }
        } else if (e.statusCode == 401) {
          emit(WrongOldPassword());
        }
      } else {
        emit(EditPasswordSError());
      }
    }
  }



  updateDoctorPassword({
    required String oldPassword,
    required String newPassword,
    required int userId,
  }) async {
    try {
      success =
          await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
              .updateDoctorPassword(
                  id: userId,
                  newpassword: newPassword,
                  oldpassword: oldPassword);

      emit(EditPasswordSuccess());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 400) {
          if (e.message ==
              "Old password must be at least 8 characters long and contain at least one letter.") {
            emit(OldPasswordError());
          } else {
            emit(NewPasswordError());
          }
        } else if (e.statusCode == 401) {
          emit(WrongOldPassword());
        }
      } else {
        emit(EditPasswordSError());
      }
    }
  }
}
