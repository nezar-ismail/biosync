import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:login/api_packages/doctor_service/doctor_api/doctor_api.dart';
import 'package:login/api_packages/doctor_service/doctor_service.dart';
import 'package:login/api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import 'package:login/core/database/local_user_model.dart';
import 'package:meta/meta.dart';
part 'workdays_state.dart';

class WorkdaysCubit extends Cubit<WorkdaysState> {
  WorkdaysCubit() : super(WorkdaysInitial());

  void EDITWorkDays({required Map<String, dynamic> workdays}) async {
    try {
      await DoctorService(doctorAPI: DoctorAPI(), imageAPI: ImageAPI())
          .editDays(ID: LocalUserModel.getUserId(), day: workdays);

      emit(UpdatedWorkDaysSuccess());
    } on Exception catch (e) {
      log(e.toString());

      emit(UpdatedWorkDaysFailed(error: e.toString()));
    }
  }
}
