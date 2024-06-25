import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/database/local_user_model.dart';
import '../../../chat/cubit/chat_service_cubit/chat_service_cubit.dart';

import '../../../chat/views/select_chat.dart';
import '../widget/dortor_drawer.dart';

class DoctorHomeView extends StatelessWidget {
  const DoctorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatServiceCubit(),
      child: Scaffold(
        floatingActionButton: Container(
          height: MediaQuery.sizeOf(context).height * 0.07,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 125, 125, 125),
                blurRadius: 5,
                spreadRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
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
            child: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () async {
                    await context
                        .read<ChatServiceCubit>()
                        .getAllDoctorChatBoxes(
                          doctorId: LocalUserModel.getUserId().toString(),
                        );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.message,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ),
        body: DoctorCustomDrawer(),
      ),
    );
  }
}
