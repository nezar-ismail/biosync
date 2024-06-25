part of 'workdays_cubit.dart';

@immutable
sealed class WorkdaysState {}

final class WorkdaysInitial extends WorkdaysState {}

final class UpdatedWorkDaysSuccess extends WorkdaysState {}

final class UpdatedWorkDaysFailed extends WorkdaysState {
  final String error;

  UpdatedWorkDaysFailed({required this.error});
}
