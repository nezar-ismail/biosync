import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/edit_image/edit_user_image_cubit.dart';
import 'confirm_image.dart';
import 'user_profile_list.dart';

File? imageFile;

class UserProfilePathes extends StatelessWidget {
  const UserProfilePathes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserImageCubit(),
      child: BlocBuilder<UserImageCubit, EditUserImageState>(
        builder: (context, state) {
          if (state is EditUserImageInitial) {
            return const UserProfileList();
          }
          if (state is UserImageLoaded) {
            return const ConfirmImage();
          }
          if (state is UserImageUpdated) {
            return const UserProfileList();
          }
          if (state is UserImageError) {
            return const UserProfileList();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
