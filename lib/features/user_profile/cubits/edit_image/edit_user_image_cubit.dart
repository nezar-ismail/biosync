import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../api_packages/doctor_service/doctor_api/doctor_api.dart';
import '../../../../api_packages/doctor_service/doctor_service.dart';

import '../../../../api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import '../../../../api_packages/patient_service/patient_api/patient_api.dart';
import '../../../../api_packages/patient_service/patient_service.dart';
import '../../../../core/database/local_user_model.dart';
import 'package:meta/meta.dart';

part 'edit_user_image_state.dart';

class UserImageCubit extends Cubit<EditUserImageState> {
  UserImageCubit() : super(EditUserImageInitial());

  final ImagePicker _imagePicker = ImagePicker();
  Future<void> pickImage({required ImageSource source}) async {
    try {
      final pickedImage = await _imagePicker.pickImage(source: source);
      if (pickedImage != null) {
        File file = File(pickedImage.path);
        // LocalUserModel.setUserImage(pickedImage.path);

        emit(UserImageLoaded(file));
      } else {
        emit(UserImageError("No image selected."));
      }
    } catch (e) {
      emit(UserImageError(e.toString()));
    }
  }

  Future<MultipartFile> getMultipartFile(File file) async {
    return MultipartFile.fromFileSync(file.path,
        filename: file.path.split(Platform.pathSeparator).last);
  }

  void set() {
    if (state is UserImageLoaded) {
      emit(EditUserImageInitial());
    }
  }

  Map<String, dynamic>? user;
  postPatientImage({required File file, required int userId}) async {
    try {
      if (state is UserImageLoaded) {
        MultipartFile imageFile = await getMultipartFile(file);
        user =
            await PatientService(usersAPI: PatientAPI(), imageAPI: ImageAPI())
                .updateImage(file: imageFile, userId: userId);
        if (user?['message'] == 'Image uploaded successfully') {
          // await LocalUserModel.deleteUserImage();
          await LocalUserModel.setUserImage(user?['image-url']);
          emit(UserImageUpdated());
        }
      }
    } catch (e) {
      emit(UserImageNotUpdated(e.toString()));
    }
  }

  postDoctorImage({required File file, required int doctorId}) async {
    try {
      if (state is UserImageLoaded) {
        MultipartFile imageFile = await getMultipartFile(file);
        user = await DoctorService(imageAPI: ImageAPI(), doctorAPI: DoctorAPI())
            .updateDoctorImage(file: imageFile, id: doctorId);
        if (user?['message'] == 'Image uploaded successfully') {
          await LocalUserModel.setUserImage(user?['image-url']);
          emit(UserImageUpdated());
        }
      }
    } catch (e) {
      emit(UserImageNotUpdated(e.toString()));
    }
  }
}
