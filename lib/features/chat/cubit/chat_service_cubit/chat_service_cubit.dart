import 'package:bloc/bloc.dart';
import '../../../../api_packages/chat_service/api/chat_api.dart';
import '../../../../api_packages/chat_service/chat_service.dart';
import '../../../../api_packages/model/chat_model.dart';
import '../../../../api_packages/model/message.dart';

part 'chat_service_state.dart';

class ChatServiceCubit extends Cubit<ChatServiceState> {
  ChatServiceCubit() : super(ChatServiceInitial());
  List<ChatBox>? chatBoxes = [];
  List<Message> messages = [];
  ChatBox? chatBox;

  Future<void> getAllDoctorChatBoxes({required String doctorId}) async {
    try {
      chatBoxes =
          await ChatService(chatAPI: ChatAPI()).getDoctorChatBoxes(doctorId);
      emit(FitchChatBoxesSuccess(chatBoxes!));
    } catch (e) {
      emit(FitchChatBoxesError(e.toString()));
    }
  }

  Future<void> getAllPatientChatBoxes({required String doctorId}) async {
    try {
      chatBoxes =
          await ChatService(chatAPI: ChatAPI()).getPatientChatBoxes(doctorId);

      emit(FitchChatBoxesSuccess(chatBoxes!));
    } catch (e) {
      emit(FitchChatBoxesError(e.toString()));
    }
  }

  Future<void> checkRoomExist(
      {required int doctorId, required int patientId}) async {
    try {
      String message = await ChatService(chatAPI: ChatAPI())
          .checkRoomExist(patientId, doctorId);
      if (message == 'There is a room') {
        emit(RoomExist());
      } else {
        emit(RoomDoesNotExist());
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> sendUsersId(
      {required int doctorId, required int patientId}) async {
    try {
      String link = await ChatService(chatAPI: ChatAPI())
          .sendUsersId(patientId, doctorId);
      emit(PaymentCheckOut(link));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
