part of 'edit_info_cubit.dart';

@immutable
sealed class EditInfoState {}

final class EditInfoInitial extends EditInfoState {}

final class EditInfoSuccess extends EditInfoState {}

final class ErrorPassword extends EditInfoState {}

final class ErrorPhone extends EditInfoState {}

final class ErrorUsername extends EditInfoState {}

final class EditInfoError extends EditInfoState {}
