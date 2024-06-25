import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../../core/database/local_database.dart';

class ImageAPI extends API {
  Future<Response> postModelImage(MultipartFile file) async {
    // Construct the URL for the file request.
    String url = '${LocalDataBase.getIPAddress()}/model';

    // Construct the body for the file request.
    var formData = FormData.fromMap({
      'image': file,
    });

    // Send a POST request to the server and await the response.
    final Response response = await post(
      url,
      body: formData,
    );

    return response;
  }

  ///Update user image
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> updatePatientImage(MultipartFile file, int id) async {
    // Construct the URL for the file request.
    String url = '${LocalDataBase.getIPAddress()}/user/image/$id';

    // Construct the body for the file request.
    var formData = FormData.fromMap({
      'image': file,
    });

    // Send a POST request to the server and await the response.
    final Response response = await putImage(
      url,
      body: formData,
    );

    return response;
  }

  ///Update doctor image
  ///
  /// Returns a [Future<Response>] containing the server response.

  Future<Response> updateDoctorImage(
      {required int id, required MultipartFile file}) async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/image/$id';

    var formData = FormData.fromMap({
      'image': file,
    });

    Response response = await putImage(url, body: formData);
    return response;
  }
}
