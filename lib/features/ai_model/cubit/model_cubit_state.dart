// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'model_cubit_cubit.dart';

@immutable
sealed class ModelCubitState {}

//*Picker State
final class ModelCubitInitial extends ModelCubitState {}

final class ModelCubitLoaded extends ModelCubitState {
  final File file;
  ModelCubitLoaded(this.file);
}

final class ModelCubitLoading extends ModelCubitState {}

//*Response from API State
final class ModelCubitError extends ModelCubitState {
  final String message;
  ModelCubitError(this.message);
}

class SuccessPneumoniaImage extends ModelCubitState {
  final AIModel aiModel;
  SuccessPneumoniaImage({
    required this.aiModel,
  });
}

class NotPneumoniaImage extends ModelCubitState {}

// State for when the image upload fails
class FailureImageUploaded extends ModelCubitState {
  final String message;
  FailureImageUploaded(this.message);
}
