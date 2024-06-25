import 'dart:async';

import 'package:dio/dio.dart';

import '../bio_auth_service/utils/log_info.dart';
import 'api/chat_api.dart';
import '../model/chat_model.dart';
import '../model/message.dart';

import '../exception_handler/auth_exception.dart';

class ChatService {
  static late final ChatService instance;

  final ChatAPI chatAPI;

  ChatService({
    required this.chatAPI,
    ChatBox? doctor,
  });

  static Future<void> init() async {
    instance = ChatService(
      chatAPI: ChatAPI(),
    );

    // }
  }



  /// Gets all doctor chat boxes.
  ///
  /// Returns a [Future<list<ChatBox>] containing the server response.
  Future<List<ChatBox>> getDoctorChatBoxes(String id) async {
    try {
      final Response response = await chatAPI.getDoctorChat(id);

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as List<dynamic>;
          List<ChatBox> chatBoxList = [];
          ChatBox chatBox;
          for (int i = 0; i < data.length; i++) {
            chatBox = ChatBox.fromMap(data[i]);

            chatBoxList.add(chatBox);
          }
          return chatBoxList;

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

  /// Gets all patient chat boxes.
  ///
  /// Returns a [Future<list<ChatBox>] containing the server response.
  Future<List<ChatBox>> getPatientChatBoxes(String id) async {
    try {
      final Response response = await chatAPI.getPatientChat(id);

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as List<dynamic>;
          List<ChatBox> chatBoxList = [];
          ChatBox chatBox;
          for (int i = 0; i < data.length; i++) {
            chatBox = ChatBox.fromMap(data[i]);

            chatBoxList.add(chatBox);
          }
          return chatBoxList;

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

  Future<List<Message>> getRoomMessages(int roomId) async {
    try {
      final Response response = await chatAPI.getRoomMessages(roomId);

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as List<dynamic>;
          List<Message> messageList = [];
          Message message;
          for (dynamic data1 in data) {
            message = Message.fromMap(data1);

            messageList.add(message);
          }
          return messageList;

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

  Future<String> checkRoomExist(int patientId, int doctorId) async {
    try {
      final Response response =
          await chatAPI.checkRoomExist(patientId, doctorId);

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as Map<String, dynamic>;
          return data['message'] as String;

        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to check room.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }

  Future<String> sendUsersId(int patientId, int doctorId) async {
    try {
      final Response response = await chatAPI.sendUserId(patientId, doctorId);

      switch (response.statusCode) {
        case 200:
          // success
          final data = response.data as Map<String, dynamic>;
          return data['link'] as String;

        default:
          if (response.data is Map<String, dynamic>) {
            throw AuthException.fromRespone(response);
          }
          throw Exception('[${response.statusCode}].Failed to have link.');
      }
    } catch (e) {
      logError(e.toString());
      rethrow; // Rethrow the exception to propagate it further if needed.
    }
  }
}
