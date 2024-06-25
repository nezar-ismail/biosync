import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../api_packages/model/chat_model.dart';
import '../../../core/database/local_user_model.dart';
import '../cubit/socket_cubit/socket_cubit.dart';
import 'confirm_image.dart';
import 'custom_send_message.dart';
import '../../user_profile/cubits/edit_image/edit_user_image_cubit.dart';

class SendBox extends StatelessWidget {
  final TextEditingController messageController;
  final ChatBox chatBox;
  final ScrollController controller;
  final int typingDelay = 1000; // delay in milliseconds
  final ValueNotifier<Timer?> typingTimerNotifier = ValueNotifier<Timer?>(null);

  SendBox({
    super.key,
    required this.messageController,
    required this.chatBox,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.01,
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        children: <Widget>[
          Expanded(
            child: BlocProvider(
              create: (context) => UserImageCubit(),
              child: BlocListener<UserImageCubit, EditUserImageState>(
                listener: (context, state) {
                  if (state is UserImageLoaded) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ConfirmChatImage(
                        imageFile: state.file,
                        roomId: chatBox.roomId,
                        receiverId: chatBox.doctorId,
                      );
                    }));
                  }
                },
                child: TextField(
                  controller: messageController,
                  onChanged: (value) => _onTyping(value, context),
                  decoration: InputDecoration(
                    hintText: "Send a message...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      //
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    // contentPadding:
                    //     EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => UserImageCubit(),
            child: BlocListener<UserImageCubit, EditUserImageState>(
              listener: (context, state) {
                if (state is UserImageLoaded) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ConfirmChatImage(
                      imageFile: state.file,
                      roomId: chatBox.roomId,
                      receiverId: chatBox.doctorId,
                    );
                  }));
                }
              },
              child: Row(
                children: [
                  Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.attach_file),
                      color: Colors.grey,
                      onPressed: () {
                        context
                            .read<UserImageCubit>()
                            .pickImage(source: ImageSource.gallery);
                      },
                      splashColor: Colors.green.withOpacity(0.3),
                      highlightColor: Colors.green.withOpacity(0.2),
                      hoverColor: Colors.green.withOpacity(0.1),
                    );
                  }),
                ],
              ),
            ),
          ),
          CustomSendMessageButton(
            messageController: messageController,
            senderId: LocalUserModel.getUserType() == 'patient'
                ? chatBox.patientId
                : chatBox.doctorId,
            receiverId: LocalUserModel.getUserType() == 'patient'
                ? chatBox.doctorId
                : chatBox.patientId,
            roomId: chatBox.roomId,
            controller: controller,
          ),
        ],
      ),
    );
  }

  void _onTyping(String value, BuildContext context) {
    if (value.isNotEmpty) {
      getIt<SocketCubit>().isTyping(isTyping: true, roomId: chatBox.roomId);
      _resetTypingTimer(context);
    } else {
      _triggerStopTyping(context);
    }
  }

  void _resetTypingTimer(BuildContext context) {
    typingTimerNotifier.value?.cancel();
    typingTimerNotifier.value = Timer(
        Duration(milliseconds: typingDelay), () => _triggerStopTyping(context));
  }

  void _triggerStopTyping(BuildContext context) {
    getIt<SocketCubit>().isTyping(isTyping: false, roomId: chatBox.roomId);
  }
}
