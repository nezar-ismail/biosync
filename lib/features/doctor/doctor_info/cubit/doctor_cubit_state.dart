part of 'doctor_cubit_cubit.dart';

@immutable
sealed class DoctorCubitState {}

final class DoctorCubitInitial extends DoctorCubitState {}

final class DoctorCubitLoaded extends DoctorCubitState {
  final List<DoctorModel> doctorInfo;
  DoctorCubitLoaded(this.doctorInfo);
}
final class DoctorCubitLoadedById extends DoctorCubitState {}
final class DoctorCubitLoading extends DoctorCubitState {}

final class DoctorCubitError extends DoctorCubitState {
  final String message;
  DoctorCubitError(this.message);
}

final class ReviewAdded extends DoctorCubitState {
  final String message;
  ReviewAdded(this.message);
}

final class ReviewAlreadyExists extends DoctorCubitState {
  final String message;
  ReviewAlreadyExists(this.message);
}
