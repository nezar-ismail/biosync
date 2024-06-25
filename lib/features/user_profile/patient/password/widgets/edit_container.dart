// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/database/local_user_model.dart';
import '../../../../../core/utils/custom_snackbar.dart';

import '../../../../../core/utils/standered_bottom.dart';
import '../../../../auth/utils/custom_textfield.dart';
import '../../../cubits/edit_password/edit_password_cubit.dart';

// ignore: must_be_immutable
class ContainerEditPassword extends StatelessWidget {
  ContainerEditPassword({super.key});
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 265,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 13,
                        spreadRadius: 1,
                        offset: Offset(1, 5),
                        // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: CustomTextField(
                            hintText: ' Old password',
                            icon: Icons.password,
                            pass: true,
                            myController: oldPasswordController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: CustomTextField(
                            hintText: ' New password',
                            pass: true,
                            icon: Icons.password,
                            myController: newPasswordController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: CustomTextField(
                            hintText: ' Confirm your password',
                            icon: Icons.password,
                            pass: true,
                            myController: confirmPasswordController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              StanderBottom(
                height: 75,
                width: 300,
                text: 'Submit',
                onPressed: () {
                  if (oldPasswordController.text.isNotEmpty &&
                      newPasswordController.text.isNotEmpty &&
                      confirmPasswordController.text.isNotEmpty) {
                    if (newPasswordController.text ==
                        confirmPasswordController.text) {
                      var editCubit =
                          BlocProvider.of<EditPasswordCubit>(context);
                      LocalUserModel.getUserType() == 'patient'
                          ? editCubit.updatePatientPassword(
                              oldPassword: oldPasswordController.text,
                              newPassword: newPasswordController.text,
                              userId: LocalUserModel.getUserId())
                          : editCubit.updateDoctorPassword(
                              oldPassword: oldPasswordController.text,
                              newPassword: newPasswordController.text,
                              userId: LocalUserModel.getUserId());
                    } else {
                      customSnackBar(context,
                          title: 'The new passwords do not match',
                          message: 'Please Enter The Correct Password',
                          type: ContentType.failure);
                    }
                  } else {
                    customSnackBar(context,
                        title: 'All fields are required',
                        message: 'Please Fill All Fields',
                        type: ContentType.help);
                  }
                },
                fontSize: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
