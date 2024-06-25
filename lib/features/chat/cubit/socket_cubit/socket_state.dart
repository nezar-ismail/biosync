part of 'socket_cubit.dart';

abstract class SocketState {}

class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {}

class SocketDisconnected extends SocketState {}

class SocketError extends SocketState {
  final String message;
  SocketError(this.message);
}

class RoomJoined extends SocketState {}

class ChatEntered extends SocketState {}

class SocketMessageReceived extends SocketState {
  final Stream<List<Message>> messageStream;
  SocketMessageReceived(this.messageStream);
}

class SocketConnectedReceived extends SocketState {
  SocketConnectedReceived();
}

final class PaymentDone extends SocketState {}

final class PaymentFailed extends SocketState {}

final class RoomCreated extends SocketState {}

final class IsTyping extends SocketState {
  final bool isTyping;
  IsTyping(this.isTyping);
}
