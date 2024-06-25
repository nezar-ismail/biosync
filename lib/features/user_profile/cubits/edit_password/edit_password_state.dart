part of 'edit_password_cubit.dart';

@immutable
sealed class EditPasswordState {}

final class EditPasswordInitial extends EditPasswordState {}

final class EditPasswordSuccess extends EditPasswordState {}

final class EditPasswordSError extends EditPasswordState {}

final class WrongOldPassword extends EditPasswordState {}

final class OldPasswordError extends EditPasswordState {}

final class NewPasswordError extends EditPasswordState {}
