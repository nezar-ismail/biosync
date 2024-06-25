import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/database/local_user_model.dart';
import '../../../../../core/utils/standered_bottom.dart';
import '../../../../auth/utils/custom_textfield.dart';
import '../../../cubits/edit_info/edit_info_cubit.dart';

class ContainerEdit extends StatelessWidget {
  const ContainerEdit({
    super.key,
    required TextEditingController userNameController,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
  })  : _userNameController = userNameController,
        _phoneController = phoneController,
        _passwordController = passwordController;

  final TextEditingController _userNameController;
  final TextEditingController _phoneController;
  final TextEditingController _passwordController;

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
                            hintText: 'User Name',
                            icon: FontAwesomeIcons.user,
                            myController: _userNameController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: CustomTextField(
                            hintText: LocalUserModel.getUserPhone(),
                            icon: Icons.phone,
                            myController: _phoneController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: CustomTextField(
                            hintText: 'Password',
                            icon: Icons.password,
                            pass: true,
                            myController: _passwordController,
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
                  if (_userNameController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    var editCubit = BlocProvider.of<EditInfoCubit>(context);
                    editCubit.editPatientInfo(
                        userName: _userNameController.text,
                        phone: _phoneController.text,
                        password: _passwordController.text,
                        id: LocalUserModel.getUserId());
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
