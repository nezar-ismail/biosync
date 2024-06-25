import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/database/local_user_model.dart';
import '../../../../../core/utils/custom_snackbar.dart';
import '../../../cubits/edit_info/edit_info_cubit.dart';

import '../widgets/edit_container.dart';

class EditPatientInfoView extends StatelessWidget {
  EditPatientInfoView({super.key});
  final TextEditingController _userNameController =
      TextEditingController(text: LocalUserModel.getUserName());
  final TextEditingController _phoneController =
      TextEditingController(text: LocalUserModel.getUserPhone());
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditInfoCubit(),
      child: BlocListener<EditInfoCubit, EditInfoState>(
        listener: (context, state) {
          if (state is EditInfoSuccess) {
            // Using Navigator.pushReplacement to replace the current route
            GoRouter.of(context).pop();
          } else if (state is ErrorPhone) {
            customSnackBar(context,
                title: 'Error Phone',
                message: 'Phone must be 9 number 7********',
                type: ContentType.warning);
          } else if (state is ErrorUsername) {
            customSnackBar(context,
                title: 'Error Username',
                message: 'Username must have characters only',
                type: ContentType.warning);
          } else if (state is ErrorPassword) {
            customSnackBar(context,
                title: 'Wrong Password',
                message: 'Please Enter Correct Password',
                type: ContentType.failure);
          } else if (state is EditInfoError) {
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
        child: ContainerEdit(
          userNameController: _userNameController,
          phoneController: _phoneController,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}
