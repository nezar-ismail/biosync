import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../../api_packages/doctor_service/doctor_api/doctor_api.dart';
import '../../../../api_packages/doctor_service/doctor_service.dart';
import '../../../../api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import '../../../../api_packages/model/doctor_model.dart';

import 'package:meta/meta.dart';

part 'doctor_cubit_state.dart';

class DoctorCubitCubit extends Cubit<DoctorCubitState> {
  DoctorCubitCubit() : super(DoctorCubitInitial());
  List<DoctorModel>? doctor;
  DoctorModel? doctorModel;
  void getAllDoctorInfo() async {
    try {
      doctor = await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
          .getAllDoctor();
      emit(DoctorCubitLoaded(doctor!));
    } catch (e) {
      emit(DoctorCubitError(e.toString()));
    }
  }

  Future<void> getDoctorInfoByID({required int id}) async {
    try {
      doctorModel =
          await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
              .getDoctorById(id: id);
      log(doctorModel.toString());
      emit(DoctorCubitLoadedById());
    } catch (e) {
      emit(DoctorCubitError(e.toString()));
    }
  }

  Future<List<DoctorModel>> getBestDoctorInfo() async {
    try {
      doctor = await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
          .getBestDoctor();
      emit(DoctorCubitLoaded(doctor!));
      return doctor!;
    } catch (e) {
      emit(DoctorCubitError(e.toString()));
      rethrow;
    }
  }

  void addReview(
      {required int pID, required int dID, required double ratting}) async {
    try {
      String message =
          await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
              .addReview(pID: pID, dID: dID, ratting: ratting);
      emit(ReviewAdded(message));
    } catch (e) {
      emit(ReviewAlreadyExists(e.toString()));
    }
  }
}
