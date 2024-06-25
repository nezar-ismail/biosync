import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_confirm_image.dart';
import 'doctor_profile_list.dart';
import '../../../../cubits/edit_image/edit_user_image_cubit.dart';

File? doctorImageFile;

class DoctorProfilePathes extends StatelessWidget {
  const DoctorProfilePathes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserImageCubit(),
      child: BlocBuilder<UserImageCubit, EditUserImageState>(
        builder: (context, state) {
          if (state is EditUserImageInitial) {
            return const DoctorProfileList();
          }
          if (state is UserImageLoaded) {
            return const DoctorConfirmImage();
          }
          if (state is UserImageUpdated) {
            return const DoctorProfileList();
          }
          if (state is UserImageError) {
            return const DoctorProfileList();
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
