// ignore_for_file: deprecated_member_use

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/route.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../cubit/cubit/auth_cubit.dart';
import '../widgets/sign_up_card.dart';

class PatientSignUpView extends StatelessWidget {
  const PatientSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        GoRouter.of(context).pushReplacement(AppRoutes.kPatientLoginRoute);
        return Future.value(false);
      },
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/Background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignUpCubitSuccess) {
                  GoRouter.of(context)
                      .pushReplacement(AppRoutes.kPatientLoginRoute);
                  customSnackBar(context,
                      title: ' Success',
                      message: 'Sign Up Success Please Login',
                      type: ContentType.success);
                }
                if (state is SignUpCubitError) {
                  customSnackBar(context,
                      title: 'Something Wrong',
                      message: 'Please try again later !',
                      type: ContentType.failure);
                }
                if (state is SignUpCubitEmailIsExist) {
                  customSnackBar(context,
                      title: 'Email Check',
                      message: 'Email is already exists !',
                      type: ContentType.warning);
                }
                if (state is SignUpCubitEmailInvalid) {
                  customSnackBar(context,
                      title: 'Email Error',
                      message: 'Email Must Contain @ and .com',
                      type: ContentType.failure);
                }
                if (state is SignUpCubitPassInvalid) {
                  customSnackBar(
                    context,
                    title: 'Password Error',
                    message:
                        'Password must contain at least 8 characters\nat least one number and one letter',
                    type: ContentType.failure,
                  );
                }
                if (state is SignUpCubitErrorPhone) {
                  customSnackBar(context,
                      title: 'Phone Error',
                      message: 'Phone Must Be Jordanian Number',
                      type: ContentType.failure);
                }
                if (state is SignUpCubitErrorUserName) {
                  customSnackBar(context,
                      title: 'UserName Error',
                      message: 'UserName Must Be At Least 3 Characters',
                      type: ContentType.failure);
                }
              },
              child: SignUpCard(),
            ),
          ),
        ),
      ),
    );
  }
}
