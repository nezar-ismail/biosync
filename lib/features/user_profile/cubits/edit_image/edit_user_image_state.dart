part of 'edit_user_image_cubit.dart';

@immutable
sealed class EditUserImageState {}

final class EditUserImageInitial extends EditUserImageState {}

final class UserImageLoaded extends EditUserImageState {
  final File file;
  UserImageLoaded(this.file);
}

final class UserImageError extends EditUserImageState {
  final String message;
  UserImageError(this.message);
}

final class UserImageConfirmed extends EditUserImageState {}

final class UserImageUpdated extends EditUserImageState {}

final class UserImageNotUpdated extends EditUserImageState {
  final String message;
  UserImageNotUpdated(this.message);
}
