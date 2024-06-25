import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api_packages/model_image_api_service/model_image_api/model_image_api.dart';
import '../../../api_packages/model_image_api_service/model_image_api_service.dart';
import '../../../api_packages/model/ai_image_model.dart';
import 'package:meta/meta.dart';

part 'model_cubit_state.dart';

class ModelCubitCubit extends Cubit<ModelCubitState> {
  ModelCubitCubit() : super(ModelCubitInitial());

  final ImagePicker _imagePicker = ImagePicker();
  Future<void> pickImage() async {
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        emit(ModelCubitLoaded(File(pickedImage.path)));
      } else {
        emit(ModelCubitError("No image selected."));
      }
    } catch (e) {
      emit(ModelCubitError(e.toString()));
    }
  }

  setLoding() {
    emit(ModelCubitLoading());
  }

  void reset() {
    emit(ModelCubitInitial());
  }

  Future<MultipartFile> getMultipartFile(File file) async {
    return MultipartFile.fromFileSync(file.path,
        filename: file.path.split(Platform.pathSeparator).last);
  }

  AIModel? aiModel;
  Future<void> postImage({required File file}) async {
    try {
      if (state is ModelCubitLoading) {
        MultipartFile imageFile = await getMultipartFile(file);
        aiModel = await ModelImageService(imageAPI: ImageAPI())
            .postModelImage(file: imageFile);

        if (aiModel!.result == 'not_pneumonia') {
          emit(NotPneumoniaImage());
        } else {
          emit(SuccessPneumoniaImage(aiModel: aiModel!));
        }
      } else {
        log('No image selected');
      }
    } catch (e) {
      emit(FailureImageUploaded(e.toString()));
    }
  }
}
