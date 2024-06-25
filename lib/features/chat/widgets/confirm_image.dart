import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../core/database/local_user_model.dart';
import '../cubit/socket_cubit/socket_cubit.dart';
import '../../user_profile/cubits/edit_image/edit_user_image_cubit.dart';

class ConfirmChatImage extends StatelessWidget {
  const ConfirmChatImage(
      {super.key,
      required this.imageFile,
      required this.roomId,
      required this.receiverId});

  final int receiverId;
  final File imageFile;
  final int roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm image'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.teal.shade300,
                      spreadRadius: 1,
                      blurRadius: 12)
                ],
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: FileImage(imageFile), fit: BoxFit.cover),
              ),
              child: DottedBorder(
                borderType: BorderType.Circle,
                strokeWidth: 5,
                dashPattern: const [
                  70,
                  80,
                ],
                strokeCap: StrokeCap.square,
                color: Colors.teal,
                borderPadding: const EdgeInsets.all(1),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocProvider(
                  create: (context) => UserImageCubit(),
                  child: Builder(builder: (context) {
                    return TextButton.icon(
                      onPressed: () {
                        context.read<UserImageCubit>().set();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                      label: const Text('Ignore'),
                    );
                  }),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await getIt<SocketCubit>().sendImageMessage(
                        message: imageFile,
                        roomId: roomId,
                        receiverId: receiverId,
                        senderType: LocalUserModel.getUserType());
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    // log(LocalUserModel.getUserImage());
                    log(imageFile.path);
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                  ),
                  label: const Text('Confirm'),
                ),
              ],
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
