// ignore_for_file: unnecessary_getters_setters

import 'dart:async';

import 'package:dio/dio.dart';

import '../bio_auth_service/utils/log_info.dart';
import 'model_image_api/model_image_api.dart';
import '../model/ai_image_model.dart';

import '../exception_handler/auth_exception.dart';

class ModelImageService {
  static late final ModelImageService instance;

  final ImageAPI imageAPI;

  ModelImageService({
    required this.imageAPI,
    AIModel? image,
  });

  static Future<void> init() async {
    instance = ModelImageService(
      imageAPI: ImageAPI(),
    );

    // }
  }

  /// post image.
  ///
  /// Returns a [Future<image>] containing the server response.
  Future<AIModel> postModelImage({
    required MultipartFile file,
  }) async {
    try {
      final Response response = await imageAPI.postModelImage(file);

      switch (response.statusCode) {
        case 201:
          // success
          final data = response.data as Map<String, dynamic>;
          AIModel image = AIModel.fromMap(data);
          return image;

        case 200:
          final data = response.data as Map<String, dynamic>;
          AIModel image = AIModel.fromMap(data);
          return image;

        case 400:
          //Unknown error
          throw AuthException.fromRespone(response);
        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to sign in.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }
}
