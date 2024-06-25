import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../api_packages/model/chat_model.dart';

import '../../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../../core/database/local_database.dart';
import '../cubit/chat_service_cubit/chat_service_cubit.dart';
import '../cubit/socket_cubit/socket_cubit.dart';
import 'select_chat.dart';
import '../widgets/send_box.dart';
import '../../doctor/doctor_info/cubit/doctor_cubit_cubit.dart';
import '../../doctor/doctor_info/view/doctor_view.dart';
import 'package:lottie/lottie.dart';
import '../../../api_packages/model/message.dart';
import '../../../core/database/local_user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatBox chatBox;
  final ScrollController _controller = ScrollController();
  ChatScreen({
    super.key,
    required this.chatBox,
  });

  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatServiceCubit(),
        child: BlocListener<ChatServiceCubit, ChatServiceState>(
          listener: (context, state) {
            if (state is FitchChatBoxesSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SelectChat(
                    chatBoxList: state.chatBoxes,
                  ),
                ),
              );
            }
          },
          child: Builder(builder: (context) {
            return PopScope(
              canPop: false,
              child: BlocProvider(
                create: (context) => DoctorCubitCubit(),
                child: BlocListener<DoctorCubitCubit, DoctorCubitState>(
                  listener: (context, state) {
                    if (state is DoctorCubitLoadedById) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DoctorView(
                          doctor: LocalDoctorModelService.getDoctors().first,
                          isDoctor: false,
                        );
                      }));
                    }
                  },
                  child: Scaffold(
                    resizeToAvoidBottomInset: true,
                    appBar: AppBar(
                      shadowColor: Colors.black,
                      elevation: MediaQuery.of(context).size.height * 0.01,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      centerTitle: true,
                      title: Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            if (LocalUserModel.getUserType() == 'patient') {
                              var doctor =
                                  BlocProvider.of<DoctorCubitCubit>(context);
                              doctor.getDoctorInfoByID(id: chatBox.doctorId);
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * 0.03,
                                backgroundImage: NetworkImage(
                                  LocalUserModel.getUserType() == 'patient'
                                      ? LocalDataBase.getIPAddress() +
                                          chatBox.doctorImage
                                      : LocalDataBase.getIPAddress() +
                                          chatBox.patientImage,
                                ),
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ///User name
                                  ///
                                  Text(
                                    LocalUserModel.getUserType() == 'patient'
                                        ? 'Dr. ${chatBox.doctorName}'
                                        : chatBox.patientName,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),

                                  ///Typing...
                                  ///
                                  BlocBuilder<SocketCubit, SocketState>(
                                    builder: (context, state) {
                                      if (state is IsTyping &&
                                          state.isTyping == true) {
                                        return const Text(
                                          "typing...",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        );
                                      } else {
                                        return const Text(
                                          "typing...",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  0, 0, 174, 174),
                                              fontSize: 12),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () async {
                          LocalUserModel.getUserType() == 'patient'
                              ? await context
                                  .read<ChatServiceCubit>()
                                  .getAllPatientChatBoxes(
                                      doctorId:
                                          LocalUserModel.getUserId().toString())
                              : await context
                                  .read<ChatServiceCubit>()
                                  .getAllDoctorChatBoxes(
                                      doctorId: LocalUserModel.getUserId()
                                          .toString());
                          await getIt<SocketCubit>()
                              .leaveRoom(roomId: chatBox.roomId);
                        },
                      ),
                    ),
                    body: SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color(0xfff6f6f6),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01),
                          child: Column(
                            children: [
                              Expanded(
                                child: StreamBuilder<List<Message>>(
                                  stream: getIt<SocketCubit>().messageStream,
                                  builder: (context,
                                      AsyncSnapshot<List<Message>> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Lottie.asset(
                                          'assets/lottie/news_loading.json');
                                    } else if (snapshot.hasData) {
                                      var myList = snapshot.data!.toList();
                                      return MessageListView(myList, snapshot);
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else if (snapshot.data == null) {
                                      return const Center(
                                          child: Text(
                                              'Welcome! Start a new conversation here!'));
                                    } else if (snapshot.data!.isEmpty) {
                                      return const Center(
                                        child: Text(
                                            'Welcome! Start a new conversation here!'),
                                      );
                                    } else {
                                      return Text(snapshot.data.toString());
                                    }
                                  },
                                ),
                              ),
                              SendBox(
                                  messageController: messageController,
                                  chatBox: chatBox,
                                  controller: _controller),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }

  ListView MessageListView(
      List<Message> myList, AsyncSnapshot<List<Message>> snapshot) {
    return ListView.builder(
      reverse: true,
      controller: _controller,
      itemCount: myList.length,
      itemBuilder: (context, index) {
        int reverse = myList.length - index - 1;
        bool isSender =
            snapshot.data![reverse].sender_type == LocalUserModel.getUserType();

        return MessageCard(isSender, context, myList, reverse, snapshot);
      },
    );
  }

  Align MessageCard(bool isSender, BuildContext context, List<Message> myList,
      int reverse, AsyncSnapshot<List<Message>> snapshot) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.01,
          right: isSender ? MediaQuery.of(context).size.width * 0.01 : 0,
          left: isSender ? 0 : MediaQuery.of(context).size.width * 0.01,
        ),
        child: IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width *
                  0.7, // Maximum width of the message container
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: isSender
                    ? const Radius.circular(15)
                    : const Radius.circular(0),
                bottomRight: isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
              ),
              color:
                  isSender ? const Color(0xfff1eee7) : const Color(0xff00aeae),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                myList[reverse].message!.contains('/Static/MessageImages/')
                    ? InteractiveViewer(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: InteractiveViewer(
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                        imageUrl: LocalDataBase.getIPAddress() +
                                            myList[reverse].message!,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            imageUrl: LocalDataBase.getIPAddress() +
                                myList[reverse].message!,
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.6,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Text(
                        myList[reverse].message!,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400,
                          color: isSender ? Colors.black : Colors.white,
                        ),
                        maxLines: null,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        textAlign: isSender ? TextAlign.right : TextAlign.left,
                      ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    Text(
                      '${snapshot.data![reverse].created_at.toString().split(' ').last.split(':').first}:${snapshot.data![reverse].created_at.toString().split(' ').last.split(':')[1]}',
                      style: TextStyle(
                        fontSize: 10,
                        color: isSender ? Colors.teal : Colors.white,
                      ),
                      textAlign: isSender ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    myList[reverse].sender_type == LocalUserModel.getUserType()
                        ? myList[reverse].is_read!
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 12,
                              )
                            : const Icon(FontAwesomeIcons.circleCheck,
                                color: Colors.grey, size: 12)
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
