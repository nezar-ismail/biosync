import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/database/local_user_model.dart';
import '../../../chat/cubit/chat_service_cubit/chat_service_cubit.dart';
import '../../../chat/views/select_chat.dart';

class NaviBar extends StatelessWidget {
  const NaviBar({
    super.key,
    required this.itsHome,
  });
  final bool itsHome;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: itsHome ? Colors.orange.shade400 : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.homeUser,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  itsHome == false ? Navigator.of(context).pop() : null;
                },
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ChatServiceCubit(),
            child: BlocListener<ChatServiceCubit, ChatServiceState>(
              listener: (context, state) {
                if (state is FitchChatBoxesSuccess) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectChat(
                        chatBoxList: state.chatBoxes,
                      ),
                    ),
                  );
                }
              },
              child: Builder(builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    color: itsHome == false
                        ? Colors.orange.shade400
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCommentDots,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () async {
                        itsHome == true
                            ? await context
                                .read<ChatServiceCubit>()
                                .getAllPatientChatBoxes(
                                  doctorId:
                                      LocalUserModel.getUserId().toString(),
                                )
                            : null;
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
