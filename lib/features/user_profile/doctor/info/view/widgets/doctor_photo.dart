import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/database/local_database.dart';
import '../../../../../../core/database/local_user_model.dart';
import '../../../../cubits/edit_image/edit_user_image_cubit.dart';

class DoctorPhoto extends StatelessWidget {
  const DoctorPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 20),
      child: Column(
        children: [
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
              //**** here image path ****//
              // image:  we will use link image
              image: DecorationImage(
                  image: NetworkImage(LocalDataBase.getIPAddress() +
                      LocalUserModel.getUserImage()),
                  fit: BoxFit.cover),
            ),
            //**** Dotted border ****//
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
          TextButton.icon(
            onPressed: () {
              context
                  .read<UserImageCubit>()
                  .pickImage(source: ImageSource.gallery);
            },
            icon: const Icon(Icons.add_a_photo_rounded, color: Colors.black),
            label: const Text(
              'Edit Profile Picture',
              style: TextStyle(color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }
}
