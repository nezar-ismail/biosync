import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../api_packages/model/chat_model.dart';
import '../../../core/database/local_database.dart';
import '../../../core/database/local_user_model.dart';
import '../cubit/search_cubit/search_cubit.dart';
import '../cubit/socket_cubit/socket_cubit.dart';
import 'chat_screen.dart';

import '../../home/patient/widget/navibar.dart';

class SelectChat extends StatelessWidget {
  SelectChat({super.key, required this.chatBoxList});
  final List<ChatBox> chatBoxList;
  final ScrollController controller = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(chatBoxList),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const NaviBar(
          itsHome: false,
        ),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 50,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: MediaQuery.sizeOf(context).width * 0.06,
            ),
          ),
          title: Image.asset('assets/image/logo.png',
              width: MediaQuery.sizeOf(context).width * 0.4,
              fit: BoxFit.fitWidth),
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ///SizedBox
                ///
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),

                ///Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Builder(builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.teal),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Center(
                          child: TextField(
                            cursorColor: Colors.green,
                            controller: searchController,
                            onChanged: (value) {
                              context
                                  .read<ChatCubit>()
                                  .filterChatBoxes(value, chatBoxList);
                            },
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.teal,
                              contentPadding: const EdgeInsets.all(8.0),
                              hintText: 'Search Chats...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                ///SizedBox
                ///
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                ///Online Users
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Online Users',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),

                ///Online Users Photo
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: chatBoxList.length,
                        itemBuilder: (context, index) {
                          return PhotoOnline(
                            image: LocalUserModel.getUserType() == 'patient'
                                ? chatBoxList[index].doctorImage
                                : chatBoxList[index].patientImage,
                            isOnline: LocalUserModel.getUserType() == 'patient'
                                ? chatBoxList[index].isDoctorOnline
                                : chatBoxList[index].isPatientOnline,
                          );
                        }),
                  ),
                ),

                ///divider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Divider(
                    color: Colors.grey[200],
                    thickness: 1,
                    indent: 50,
                    endIndent: 50,
                  ),
                ),

                ///Chats
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Chats',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),

                ///Conversation Box List
                Expanded(
                  child: BlocBuilder<ChatCubit, List<ChatBox>>(
                    builder: (context, filteredChatBoxList) {
                      return ListView.builder(
                        itemCount: filteredChatBoxList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: GestureDetector(
                              onTap: () async {
                                getIt<SocketCubit>().roomJoin(
                                    roomId: filteredChatBoxList[index].roomId);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      chatBox: filteredChatBoxList[index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ///User Photo
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.075,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                            LocalUserModel.getUserType() ==
                                                    'patient'
                                                ? LocalDataBase.getIPAddress() +
                                                    filteredChatBoxList[index]
                                                        .doctorImage
                                                : LocalDataBase.getIPAddress() +
                                                    filteredChatBoxList[index]
                                                        .patientImage,
                                          ),
                                        ),
                                      ),
                                    ),

                                    ///Spacer
                                    const Spacer(
                                      flex: 1,
                                    ),

                                    ///Name and Last Message
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ///Name
                                        Text(
                                          LocalUserModel.getUserType() ==
                                                  'patient'
                                              ? filteredChatBoxList[index]
                                                  .doctorName
                                              : filteredChatBoxList[index]
                                                  .patientName,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),

                                        ///SizeBox
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.009,
                                        ),

                                        ///Last Message
                                        SizedBox(
                                          width: 200,
                                          child: Expanded(
                                            child: Text(
                                              filteredChatBoxList[index]
                                                      .lastMessage
                                                      .contains(
                                                          '/Static/MessageImages/')
                                                  ? '📷 Photo'
                                                  : filteredChatBoxList[index]
                                                      .lastMessage,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: filteredChatBoxList[
                                                              index]
                                                          .lastMessage
                                                          .contains(
                                                              '/Static/MessageImages/')
                                                      ? 12
                                                      : 16.0,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      filteredChatBoxList[index]
                                                                  .isRead ==
                                                              true
                                                          ? FontWeight.w400
                                                          : FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///Spacer
                                    const Spacer(
                                      flex: 5,
                                    ),

                                    ///time
                                    Text(
                                      filteredChatBoxList[index]
                                                  .lastMessageTime ==
                                              ' '
                                          ? ''
                                          : filteredChatBoxList[index]
                                                  .lastMessageTime![11] +
                                              filteredChatBoxList[index]
                                                  .lastMessageTime![12] +
                                              filteredChatBoxList[index]
                                                  .lastMessageTime![13] +
                                              filteredChatBoxList[index]
                                                  .lastMessageTime![14] +
                                              filteredChatBoxList[index]
                                                  .lastMessageTime![15],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.018,
                                          color: Colors.black,
                                          fontWeight: filteredChatBoxList[index]
                                                      .isRead ==
                                                  true
                                              ? FontWeight.w400
                                              : FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhotoOnline extends StatelessWidget {
  const PhotoOnline({
    super.key,
    required this.image,
    required this.isOnline,
  });
  final bool isOnline;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Container(
        alignment: Alignment.bottomRight,
        height: MediaQuery.of(context).size.width * 0.06,
        width: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                LocalDataBase.getIPAddress() + image),
            fit: BoxFit.contain,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.height * 0.03,
          height: MediaQuery.of(context).size.height * 0.02,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            shape: BoxShape.circle,
            color: isOnline ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}
