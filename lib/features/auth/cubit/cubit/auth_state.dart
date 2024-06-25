part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginCubitInitial extends AuthState {}

final class LoginCubitSuccess extends AuthState {}

final class LoginDoctorCubitSuccess extends AuthState {}

final class LoginCubitInvalid extends AuthState {}

final class LoginCubitWrongPassword extends AuthState {}

final class LoginCubitWrongEmail extends AuthState {}

final class LoginCubitError extends AuthState {
  final String message;
  LoginCubitError({required this.message});
}

final class SignUpCubitInitial extends AuthState {}

final class SignUpCubitSuccess extends AuthState {}

final class VerificationLoading extends AuthState {}

final class ForgetPassword extends AuthState {}

final class CodeVerified extends AuthState {}

final class SignUpCubitError extends AuthState {
  final String message;
  SignUpCubitError({required this.message});
}

final class SignUpCubitEmailIsExist extends AuthState {}

final class SignUpCubitPassInvalid extends AuthState {}

final class SignUpCubitEmailInvalid extends AuthState {}

final class SignUpCubitErrorPhone extends AuthState {}

final class SignUpCubitErrorUserName extends AuthState {}

final class VerificationEmailSuccess extends AuthState {
  final VerificationModel code;
  VerificationEmailSuccess({required this.code});
}

final class VerificationEmailError extends AuthState {
  final String message;
  VerificationEmailError({required this.message});
}

final class PasswordUpdated extends AuthState {}

final class PasswordUpdateError extends AuthState {
  final String message;
  PasswordUpdateError({required this.message});
}

final class VerificationPasswordSuccess extends AuthState {
  final VerificationModel code;
  VerificationPasswordSuccess({required this.code});
}

final class VerificationPasswordError extends AuthState {
  final String message;
  VerificationPasswordError({required this.message});
}

final class SignUpRequestSuccess extends AuthState {
  final String message;
  SignUpRequestSuccess({required this.message});
}
final class SignUpRequestReject extends AuthState {
  final String message;
  SignUpRequestReject({required this.message});
}
