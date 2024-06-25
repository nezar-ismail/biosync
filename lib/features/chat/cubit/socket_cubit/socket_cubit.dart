import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../api_packages/chat_service/api/chat_api.dart';
import '../../../../api_packages/chat_service/chat_service.dart';
import '../../../../api_packages/model/chat_model.dart';
import '../../../../api_packages/model/message.dart';

import '../../../../core/database/local_user_model.dart';
import '../../../../core/notification_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  late final IO.Socket _socket;
  final StreamController<List<Message>> _messageStreamController =
      StreamController<List<Message>>.broadcast();
  final StreamController<List<ChatBox>> _chatBoxStreamController =
      StreamController<List<ChatBox>>.broadcast();
  List<Message> messages = [];
  List<ChatBox> chatBoxes = [];

  SocketCubit() : super(SocketInitial()) {
    _connect();
  }

  Stream<List<Message>> get messageStream => _messageStreamController.stream;
  Stream<List<ChatBox>> get chatBoxStream => _chatBoxStreamController.stream;

  void _connect() {
    _socket = IO.io('http://192.168.213.253:5001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': true,
      'timeout': 500,
    });

    _socket.connect();

    _socket.onDisconnect((_) {
      log('Disconnected');
    });

    _socket.on('connect', (_) {
      log('Connected');
      emit(SocketConnected());
    });

    _socket.on('reconnect', (attempt) {
      log('reconnected after $attempt attempts');
    });

    _socket.on('connect_error', (data) {
      log('Connect Error: $data');
      emit(SocketError('Connection Error: $data'));
    });

    _socket.on('message', (data) async {
      log(data.toString());
      addMessage(Message.fromMap(data));
      if (data['receiver_id'] == LocalUserModel.getUserId() &&
          data['sender_type'] != LocalUserModel.getUserType()) {
        if (data['is_read'] == false) {
          await NotificationService.showNotification(
            title: data['user_name'],
            body: data['message'],
            summary: "New Message",
            notificationLayout: NotificationLayout.Messaging,
          );
        }
      }
    });

    _socket.on('room_joined', (data) async {
      await getRoomMessage(roomId: data['room_id']);
      if (data['sender_type'] != LocalUserModel.getUserType()) {
        if (messages.isNotEmpty && messages.last.room_id == data['room_id']) {
          int i = 1;
          while (messages[messages.length - i].is_read == false &&
              i < messages.length) {
            messages[messages.length - i].is_read = true;
            i++;
          }
        }
        ////////////////////////////////!
        await getChatBoxes(Id: LocalUserModel.getUserId());
        for (var x in chatBoxes) {
          if (x.roomId == messages.last.room_id) {
            x.lastMessage = messages.last.message!;
            x.lastMessageTime = messages.last.created_at!;
            if (messages.last.is_read == true) {
              x.isRead = true;
            }
            break;
          }
        }
      }
    });

    _socket.on('typing', (data) {
      emit(IsTyping(data['is_typing']));
    });

    _socket.on('paymentSuccess', (data) async {
      log('payment success${data.toString()}');
      if (LocalUserModel.getUserType() == 'doctor') {
        log('this is doctor');
        if (data['doctor_id'] == LocalUserModel.getUserId()) {
          log('doctor created');
          Map<String, dynamic> joinData = {
            "room_id": data['room_id'],
            'sender_type': LocalUserModel.getUserType()
          };
          await NotificationService.showNotification(
            title: "Your have new patient request ",
            body: 'Please check your patient list',
            summary: "Thank you for using our app",
            notificationLayout: NotificationLayout.BigText,
          );
          _socket.emit('join', joinData);
          _socket.emit('leave', joinData);
          userConnected();
        }
      } else {
        log('this is patient');
        if (data['patient_id'] == LocalUserModel.getUserId()) {
          log('same patient');
          log('user created');
          Map<String, dynamic> joinData = {
            "room_id": data['room_id'],
            'sender_type': LocalUserModel.getUserType()
          };
          await NotificationService.showNotification(
            title: "Your payment done successfully",
            body: 'Your Doctor will contact with you soon',
            summary: "Thank you for using our app",
            notificationLayout: NotificationLayout.Messaging,
          );
          _socket.emit('join', joinData);
          _socket.emit('leave', joinData);
          userConnected();
        }
      }
    });

    _socket.on('room_joined', (data) async {
      log(data.toString());
    });

    _socket.on('room_left', (data) {
      log('leave ${data.toString()}');
    });

    _socket.on('error', (error) {
      log('Socket Error: $error');
      emit(SocketError(error.toString()));
    });

    _socket.on('active', (data) {
      log('User Active: $data');
    });

    _socket.on('inactive', (data) {
      log('User inactive: $data');
    });
  }

  void isTyping({required bool isTyping, required int roomId}) {
    Map<String, dynamic> data = {"room_id": roomId, 'is_typing': isTyping};
    _socket.emit('typing', data);
  }

  void addMessage(Message message) async {
    messages.add(message);
    _messageStreamController.add(messages);
  }

  Future<void> sendMessage({
    required String message,
    required int senderId,
    required int receiverId,
    required int roomId,
    required String senderType,
  }) async {
    Map<String, dynamic> data = {
      'user_name': LocalUserModel.getUserName(),
      'message': message,
      'room_id': roomId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'sender_type': senderType,
      'created_at':
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
    };
    try {
      _socket.emit('message', data);
    } on SocketException catch (e) {
      log(e.toString());
      throw SocketException(e.message);
    }
  }

  Future<void> sendImageMessage({
    required File message,
    required int receiverId,
    required int roomId,
    required String senderType,
  }) async {
    final bytes = await message.readAsBytes();
    final base64 = base64Encode(bytes);
    log(base64);
    Map<String, dynamic> data = {
      'image': base64,
      'image_name': message.path.split('/').last,
      'room_id': roomId,
      'sender_id': LocalUserModel.getUserId(),
      'sender_type': LocalUserModel.getUserType(),
      'receiver_id': receiverId,
      'created_at':
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()).toString(),
    };
    try {
      _socket.emit('image', data);
    } on SocketException catch (e) {
      log(e.toString());
      throw SocketException(e.message);
    }
  }

  void disconnect() {
    _socket.disconnect();
  }

  Future<void> getRoomMessage({required int roomId}) async {
    try {
      messages = await ChatService(chatAPI: ChatAPI()).getRoomMessages(roomId);
      log(messages.toString());
      _messageStreamController.add(messages);
      emit(RoomJoined());
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

  Future<void> getChatBoxes({required int Id}) async {
    try {
      chatBoxes = await ChatService(chatAPI: ChatAPI())
          .getPatientChatBoxes(Id.toString());
      _chatBoxStreamController.add(chatBoxes);
    } catch (e) {
      emit(SocketError(e.toString()));
    }
  }

  void roomJoin({
    required int roomId,
  }) async {
    try {
      Map<String, dynamic> data = {
        "room_id": roomId,
        "sender_type": LocalUserModel.getUserType(),
      };
      _socket.emit('join', data);
    } on SocketException catch (e) {
      log(e.toString());
      throw SocketException(e.message);
    }
  }

  Future leaveRoom({
    required int roomId,
  }) async {
    try {
      Map<String, dynamic> data = {
        "room_id": roomId,
        "sender_type": LocalUserModel.getUserType(),
      };
      _socket.emit('leave', data);
    } on SocketException catch (e) {
      log(e.toString());
      throw SocketException(e.message);
    }
  }

  void roomCreate({
    required int userId,
    required int docId,
  }) {
    Map<String, dynamic> data = {
      "patient_id": userId,
      "doctor_id": docId,
    };
    try {
      _socket.emit('create_room', data);
    } on SocketException catch (e) {
      log(e.toString());
      throw SocketException(e.message);
    }
  }

  void userConnected() {
    Map<String, dynamic> data = {
      'sender_id': LocalUserModel.getUserId(),
      'sender_type': LocalUserModel.getUserType()
    };
    try {
      _socket.emit('active', data);
    } on SocketException catch (e) {
      log(e.toString());
      throw SocketException(e.message);
    }
  }

  void userDisconnected() {
    Map<String, dynamic> data = {
      'sender_id': LocalUserModel.getUserId(),
      'sender_type': LocalUserModel.getUserType()
    };
    try {
      _socket.emit('inactive', data);
    } on SocketException catch (e) {
      log(e.toString());
      throw SocketException(e.message);
    }
  }

  void setPaymentSuccess() {
    emit(PaymentDone());
  }

  void joinAll({required int userId, required String userType}) {
    Map<String, dynamic> data = {"sender_id": userId, "sender_type": userType};
    _socket.emit('join_all', data);
  }

  @override
  Future<void> close() {
    log('Socket Cubit Closed');
    _messageStreamController.close();
    _chatBoxStreamController.close();
    _socket.dispose();
    return super.close();
  }
}
