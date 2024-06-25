import 'package:flutter/material.dart';

import '../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../core/database/local_user_model.dart';
import '../cubit/socket_cubit/socket_cubit.dart';

class CustomSendMessageButton extends StatelessWidget {
  final TextEditingController messageController;
  final int senderId;
  final int receiverId;
  final int roomId;
  final ScrollController? controller;

  const CustomSendMessageButton({
    super.key,
    required this.controller,
    required this.messageController,
    required this.senderId,
    required this.receiverId,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Color(0xff00aeae)),
      child: IconButton(
        icon: const Icon(Icons.send, color: Colors.white),
        onPressed: () async {
          if (messageController.text.isNotEmpty) {
            final message = messageController.text;
            await getIt<SocketCubit>().sendMessage(
                message: message,
                senderId: senderId,
                receiverId: receiverId,
                roomId: roomId,
                senderType: LocalUserModel
                    .getUserType()); // context.read<ChatCubit>().setupMessageListener();
            messageController
                .clear(); // Clear the text field after sending the message
            scrollDown();
          }
        },
      ),
    );
  }

  void scrollDown() {
    controller!.jumpTo(
      controller!.position.minScrollExtent,
    );
  }
}
