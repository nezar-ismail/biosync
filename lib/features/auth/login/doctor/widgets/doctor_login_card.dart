import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import 'package:go_router/go_router.dart';
import '../../../../../core/route.dart';
import '../../../../../core/utils/standered_bottom.dart';
import '../../../cubit/cubit/auth_cubit.dart';

import '../../../utils/custom_gradient_button.dart';
import '../../../../../core/utils/custom_snackbar.dart';
import '../../../utils/custom_textfield.dart';
import 'package:lottie/lottie.dart';

class DoctorLoginCard extends StatelessWidget {
  DoctorLoginCard({
    super.key,
  });
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String finalCode = '0';
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerificationPasswordError) {
          customSnackBar(context,
              title: 'Email Not Exists',
              message: 'Please Insert Correct Email',
              type: ContentType.failure);
        }
        if (state is PasswordUpdated) {
          customSnackBar(context,
              title: 'Password Updated',
              message: 'Login Now',
              type: ContentType.success);
        }
      },
      builder: (context, state) {
        if (state is VerificationLoading) {
          return Lottie.asset('assets/lottie/news_loading.json');
        }
        if (state is ForgetPassword || state is VerificationPasswordError) {
          return ForgetPasswordView(emailController: _emailController);
        }
        if (state is VerificationPasswordSuccess) {
          return Center(
            child: Container(
              height: MediaQuery.sizeOf(context).width,
              width: MediaQuery.sizeOf(context).width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
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
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.sizeOf(context).height * 0.03),
                    child: Text(
                      'Enter Your Code',
                      style: TextStyle(
                          fontSize: MediaQuery.sizeOf(context).height * 0.025,
                          color: Colors.green,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  VerificationCode(
                    fullBorder: true,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                    keyboardType: TextInputType.number,
                    underlineColor: Colors.teal,
                    length: 5,
                    cursorColor: Colors.blue,
                    onCompleted: (value) {
                      finalCode = value;
                    },
                    onEditing: (bool value) {},
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.06,
                  ),
                  StanderBottom(
                      height: MediaQuery.sizeOf(context).height * 0.06,
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      text: 'Verify Code',
                      onPressed: () async {
                        var authCubit = BlocProvider.of<AuthCubit>(context);
                        if (finalCode == state.code.verificationCode) {
                          authCubit.setCodeVerified();
                        } else {
                          customSnackBar(context,
                              title: 'Code Does Not Match',
                              message: 'Try Again',
                              type: ContentType.failure);
                        }
                      },
                      fontSize: MediaQuery.sizeOf(context).height * 0.025),
                ],
              ),
            ),
          );
        }
        if (state is CodeVerified) {
          return CodeVerify(
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              emailController: _emailController);
        }
        return DoctorLogin(
            emailController: _emailController,
            passwordController: _passwordController);
      },
    );
  }
}

/// Doctor Login
///
class DoctorLogin extends StatelessWidget {
  const DoctorLogin({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.12,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 149, 149, 149),
                  offset: Offset(1, 1),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.05),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.79,
                    child: Image.asset('assets/image/logo.png'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                const Center(
                    child: Text('Login As Doctor',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CustomTextField(
                  hintText: 'Email',
                  icon: Icons.email,
                  myController: _emailController,
                ),
                CustomTextField(
                  hintText: 'Password',
                  icon: Icons.lock,
                  myController: _passwordController,
                  pass: true,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: TextButton(
                    onPressed: () {
                      var cubit = BlocProvider.of<AuthCubit>(context);
                      cubit.setForget();
                    },
                    child: Text(
                      'Forgot password ?',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                  child: GradientButton(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade900,
                        Colors.green,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    onPressed: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        var authCubit = BlocProvider.of<AuthCubit>(context);
                        authCubit.doctorSignIn(
                            email: _emailController.text,
                            password: _passwordController.text);
                      } else {
                        customSnackBar(
                          context,
                          title: 'Required Field',
                          message: 'All field are required !',
                          type: ContentType.warning,
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRoutes.kDoctorFormRoute);
                    },
                    child: const Text(
                      "Don't have a doctor account ? SIGN WITH US",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Forget Password
///
class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.sizeOf(context).width,
        width: MediaQuery.sizeOf(context).width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 13,
              spreadRadius: 1,
              offset: Offset(1, 5),
              // Shadow position
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.01),
                  child: Text(
                    'Enter Your Email Address',
                    style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).height * 0.025,
                        color: Colors.green,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                CustomTextField(
                  hintText: 'Email',
                  icon: Icons.email,
                  myController: _emailController,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                StanderBottom(
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    text: 'Send Code',
                    onPressed: () async {
                      var authCubit = BlocProvider.of<AuthCubit>(context);
                      authCubit.setLoding();
                      await authCubit.verificationPassword(
                          email: _emailController.text);
                    },
                    fontSize: 15),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
              ],
            ),
            TextButton.icon(
                onPressed: () {
                  var authCubit = BlocProvider.of<AuthCubit>(context);
                  authCubit.setInit();
                },
                label: const Text('Back'),
                icon: const Icon(Icons.arrow_back)),
          ],
        ),
      ),
    );
  }
}

/// Code Verify
///
class CodeVerify extends StatelessWidget {
  const CodeVerify({
    super.key,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required TextEditingController emailController,
  })  : _passwordController = passwordController,
        _confirmPasswordController = confirmPasswordController,
        _emailController = emailController;

  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.sizeOf(context).width,
        width: MediaQuery.sizeOf(context).width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
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
            CustomTextField(
              hintText: 'Enter Your New Password',
              icon: Icons.email,
              myController: _passwordController,
            ),
            CustomTextField(
              hintText: 'Confirm Your New Password',
              icon: Icons.email,
              myController: _confirmPasswordController,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.06,
            ),
            StanderBottom(
                height: MediaQuery.sizeOf(context).height * 0.06,
                width: MediaQuery.sizeOf(context).width * 0.5,
                text: 'Set Password',
                onPressed: () async {
                  if ((_passwordController.text ==
                          _confirmPasswordController.text) &&
                      _passwordController.text.isNotEmpty &&
                      _confirmPasswordController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty) {
                    var authCubit = BlocProvider.of<AuthCubit>(context);
                    authCubit.setLoding();
                    await authCubit.setNewPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      userType: 'doctor',
                    );
                  } else {
                    customSnackBar(context,
                        title: 'Password Does Not Match',
                        message: 'Try Again',
                        type: ContentType.failure);
                  }
                },
                fontSize: MediaQuery.sizeOf(context).height * 0.025),
          ],
        ),
      ),
    );
  }
}
