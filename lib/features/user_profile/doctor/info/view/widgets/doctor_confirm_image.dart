import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/database/local_user_model.dart';
import '../../../../../../core/utils/custom_snackbar.dart';
import 'doctor_profile_path.dart';
import '../../../../cubits/edit_image/edit_user_image_cubit.dart';

class DoctorConfirmImage extends StatelessWidget {
  const DoctorConfirmImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserImageCubit, EditUserImageState>(
        listener: (context, state) {
          if (state is UserImageUpdated) {
            customSnackBar(context,
                title: 'Success',
                message: 'Image has been changed successfully',
                type: ContentType.success);
          }
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              const Text(
                'Confirm your image',
                style: TextStyle(fontSize: 30, color: Colors.teal),
              ),
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
                      image: FileImage(doctorImageFile!), fit: BoxFit.cover),
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
                  TextButton.icon(
                    onPressed: () {
                      context.read<UserImageCubit>().set();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                    label: const Text('Ignore'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context.read<UserImageCubit>().postDoctorImage(
                            file: doctorImageFile!,
                            doctorId: LocalUserModel.getUserId(),
                          );
                      log(LocalUserModel.getUserImage());
                      log(doctorImageFile!.path);
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
      ),
    );
  }
}
