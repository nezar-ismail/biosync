import 'package:bloc/bloc.dart';
import '../../../api_packages/bio_auth_service/auth_api/auth_api.dart';
import '../../../api_packages/bio_auth_service/bio_auth_service.dart';
import '../../../api_packages/doctor_service/doctor_api/doctor_api.dart';
import '../../../api_packages/doctor_service/doctor_service.dart';

import '../../../api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import '../../../core/database/local_secure_storage.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkServer() async {
    try {
      final bool bioCheckServer =
          await BioAuthService(authAPI: AuthAPI()).checkServer();
      if (bioCheckServer == true) {
        emit(InternetConnected());
      } else {
        emit(InternetError());
      }
    } catch (e) {
      emit(SplashError());
    }
  }

  setLoadding() {
    emit(SplashLoading());
  }

  setInit() {
    emit(SplashInitial());
  }

  Future<void> loggedIn() async {
    String? uid = await LocalSecureStorage.getUserUid();
    try {
      if (await LocalSecureStorage.isUserLoggedIn() == true) {
        if (await LocalSecureStorage.getUserType() == 'patient') {
          await BioAuthService(authAPI: AuthAPI()).loggedIn(uid!);
          emit(PatientAlreadyLogin());
        } else {
          await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
              .loggedIn(uid!);
          emit(DoctorAlreadyLogin());
        }
      } else {
        emit(UserLoggedOut());
      }
    } catch (e) {
      emit(SplashError());
}
}
}