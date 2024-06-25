part of 'chat_service_cubit.dart';

sealed class ChatServiceState {}

final class ChatServiceInitial extends ChatServiceState {}

final class FitchChatBoxesSuccess extends ChatServiceState {
  List<ChatBox> chatBoxes;

  FitchChatBoxesSuccess(this.chatBoxes);
}

final class FitchChatBoxesError extends ChatServiceState {
  String error;

  FitchChatBoxesError(this.error);
}

final class FitchMessagesSuccess extends ChatServiceState {
  List<Message> messagesList;

  FitchMessagesSuccess(this.messagesList);
}

final class FitchMessagesError extends ChatServiceState {
  String error;

  FitchMessagesError(this.error);
}

final class RoomExist extends ChatServiceState {}

final class RoomDoesNotExist extends ChatServiceState {}

final class Error extends ChatServiceState {
  final String error;
  Error(this.error);
}

final class PaymentCheckOut extends ChatServiceState {
  String link;

  PaymentCheckOut(this.link);
}
