import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../../core/database/local_database.dart';

class VerificationAPI extends API {
  final String baseRoute = 'verification';

  Future<Response> verificationEmail({required String email}) async {
    // ignore: unnecessary_brace_in_string_interps
    final String url = '${LocalDataBase.getIPAddress()}/${baseRoute}/email';

    Map<String, dynamic> body = {'email': email};

    final Response response = await post(url, body: body);

    return response;
  }

  Future<Response> forgetPassword({required String email}) async {
    final String url = '${LocalDataBase.getIPAddress()}/$baseRoute/forget';

    Map<String, dynamic> body = {'email': email};

    final Response response = await post(url, body: body);

    return response;
  }

  Future<Response> setNewPassword(
      {required String email,
      required String password,
      required String userType}) async {
    final String url =
        '${LocalDataBase.getIPAddress()}/$baseRoute/forget/password';

    Map<String, dynamic> body = {
      'email': email,
      'password': password,
      'user_type': userType
    };

    final Response response = await post(url, body: body);

    return response;
  }
}
