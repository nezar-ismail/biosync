import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/custom_snackbar.dart';
import '../../../cubits/edit_password/edit_password_cubit.dart';
import '../widgets/edit_container.dart';

class EditPatientPasswordView extends StatelessWidget {
  const EditPatientPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPasswordCubit(),
      child: BlocListener<EditPasswordCubit, EditPasswordState>(
        listener: (context, state) {
          if (state is EditPasswordSuccess) {
            GoRouter.of(context).pop();
            customSnackBar(context,
                title: 'Success',
                message: 'Password has been changed successfully',
                type: ContentType.success);
          } else if (state is OldPasswordError) {
            customSnackBar(context,
                title: 'WARNING',
                message:
                    'Old password must be at least 8 characters long and contain at least one letter.',
                type: ContentType.warning);
          } else if (state is NewPasswordError) {
            customSnackBar(context,
                title: 'WARNING',
                message:
                    'New password must be at least 8 characters long and contain at least one letter.',
                type: ContentType.warning);
          } else if (state is WrongOldPassword) {
            customSnackBar(context,
                title: 'Invalid Password',
                message: 'Please Enter The Correct Password',
                type: ContentType.failure);
          } else if (state is EditPasswordSError) {
            customSnackBar(context,
                title: 'Something went wrong',
                message: 'Please try again ',
                type: ContentType.failure);
          } else {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        child: ContainerEditPassword(),
      ),
    );
  }
}
