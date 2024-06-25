import 'package:bloc/bloc.dart';
import '../../../../api_packages/doctor_service/doctor_api/doctor_api.dart';
import '../../../../api_packages/doctor_service/doctor_service.dart';
import '../../../../api_packages/exception_handler/auth_exception.dart';
import '../../../../api_packages/model/doctor_model.dart';
import '../../../../api_packages/model/user_model.dart';
import '../../../../api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import '../../../../api_packages/patient_service/patient_api/patient_api.dart';
import '../../../../api_packages/patient_service/patient_service.dart';
import '../../../../core/database/local_user_model.dart';
import 'package:meta/meta.dart';

part 'edit_info_state.dart';

class EditInfoCubit extends Cubit<EditInfoState> {
  EditInfoCubit() : super(EditInfoInitial());
  PatientModel? patient;
  DoctorModel? doctor;

  editPatientInfo(
      {required String userName,
      required String phone,
      required String password,
      required int id}) async {
    try {
      patient = await PatientService(
        usersAPI: PatientAPI(),
        imageAPI: ImageAPI(),
      ).updateInfo(
          userId: id, name: userName, phone: phone, password: password);
      LocalUserModel.setUserName(patient!.username);
      LocalUserModel.setUserPhone(patient!.phone);

      emit(EditInfoSuccess());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 400) {
          if (e.message == "Invalid phone number.") {
            emit(ErrorPhone());
          } else {
            emit(ErrorUsername());
          }
        } else if (e.statusCode == 401) {
          emit(ErrorPassword());
        }
      } else {
        emit(EditInfoError());
      }
    }
  }

  editDoctorInfo(
      {required String phone,
      required String password,
      required int id}) async {
    try {
      await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
          .updateDoctorPhone(id: id, phone: phone);

      emit(EditInfoSuccess());
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == 400) {
          if (e.message == "Invalid phone number.") {
            emit(ErrorPhone());
          } else {
            emit(ErrorUsername());
          }
        } else if (e.statusCode == 401) {
          emit(ErrorPassword());
        }
      } else {
        emit(EditInfoError());
      }
    }
  }
}
