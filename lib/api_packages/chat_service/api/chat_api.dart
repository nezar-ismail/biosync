// ignore_for_file: unused_field, unused_import

import 'dart:io';

import 'package:dio/dio.dart';
import '../../../core/database/local_database.dart';

import '../../api/api.dart';

class ChatAPI extends API {
  ///Get All Chat
  ///
  /// Returns a [Future<Response>] containing the server response.
  Future<Response> getDoctorChat(String id) async {
    String url = '${LocalDataBase.getIPAddress()}/doctor/conversation_box/$id';

    final Response response = await get(url);
    return response;
  }

  Future<Response> getPatientChat(String id) async {
    String url = '${LocalDataBase.getIPAddress()}/patient/conversation_box/$id';

    final Response response = await get(url);
    return response;
  }

  Future<Response> getRoomMessages(int roomId) async {
    String url = '${LocalDataBase.getIPAddress()}/get/chat_message/$roomId';

    final Response response = await get(url);
    return response;
  }

  Future<Response> checkRoomExist(int patientId, int doctorId) async {
    String url = '${LocalDataBase.getIPAddress()}/chack/room';
    Map<String, dynamic> body = {
      'patient_id': patientId,
      'doctor_id': doctorId
    };
    final Response response = await post(url, body: body);
    return response;
  }

  Future<Response> sendUserId(int patientId, int doctorId) async {
    String url = '${LocalDataBase.getIPAddress()}/checkout';
    Map<String, dynamic> body = {
      'patient_id': patientId,
      'doctor_id': doctorId
    };
    final Response response = await post(url, body: body);
    return response;
  }
}
