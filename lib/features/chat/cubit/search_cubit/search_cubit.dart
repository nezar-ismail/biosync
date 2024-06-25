import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../api_packages/model/chat_model.dart';
import '../../../../core/database/local_user_model.dart';

class ChatCubit extends Cubit<List<ChatBox>> {
  ChatCubit(super.initialChatBoxList);

  void filterChatBoxes(String query, List<ChatBox> allChatBoxes) {
    if (query.isEmpty) {
      emit(allChatBoxes);
    } else {
      emit(allChatBoxes.where((chatBox) {
        final name = LocalUserModel.getUserType() == 'patient'
            ? chatBox.doctorName.toLowerCase()
            : chatBox.patientName.toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList());
    }
  }
}
