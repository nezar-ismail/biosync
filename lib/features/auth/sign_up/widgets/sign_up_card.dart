// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/local_user_model.dart';
import '../../../../core/route.dart';

import '../../../../core/utils/RegExceprission/reg_exceprission.dart';
import '../../../../core/utils/standered_bottom.dart';

import '../../cubit/cubit/auth_cubit.dart';

import '../../utils/custom_gradient_button.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../utils/custom_textfield.dart';
import '../../utils/radio_button.dart';
import 'package:lottie/lottie.dart';

bool samePass = true;

class SignUpCard extends StatelessWidget {
  SignUpCard({
    super.key,
  });
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();

  String gender = 'Male';
  @override
  Widget build(BuildContext context) {
    String finalCode = '0';
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerificationEmailError) {
          customSnackBar(context,
              title: 'Email Already Exists',
              message: 'Please try With Another Email',
              type: ContentType.failure);
        }
      },
      builder: (context, state) {
        if (state is VerificationLoading) {
          return Lottie.asset('assets/lottie/news_loading.json');
        }
        if (state is VerificationEmailSuccess) {
          return VerifyEmail(context, finalCode, state);
        }
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 25, left: 25, bottom: 15, top: 30),
              child: Container(
                height: 710,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 77, 77, 77),
                      offset: Offset(-7, 10),
                      blurRadius: 15,
                      spreadRadius: -10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.asset('assets/image/logo.png'),
                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 35, left: 25),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.7,
                            child: Image.asset('assets/image/logo.png'),
                          ),
                        ),
                        //Email
                        //
                        CustomTextField(
                          hintText: 'Email',
                          icon: Icons.email,
                          myController: _emailController,
                        ),
                        //User Name
                        //
                        CustomTextField(
                          hintText: 'User Name',
                          icon: Icons.person,
                          myController: _userNameController,
                        ),
                        //Phone
                        //
                        CustomTextField(
                          hintText: 'Phone Number',
                          icon: Icons.phone,
                          myController: _phoneController,
                        ),
                        //Gender
                        //
                        const RadioButton(),
                        //Password
                        //
                        CustomTextField(
                          hintText: 'Password',
                          icon: Icons.lock,
                          myController: _passwordController,
                        ),
                        //Password Hint
                        //
                        const Padding(
                          padding: EdgeInsets.only(left: 25, bottom: 5),
                          child: Text(
                            "'at least 8 characters, one number and one letter",
                            style: TextStyle(
                              color: Colors.black26,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Confirm Password
                        //
                        CustomTextField(
                          hintText: 'Confirm Password',
                          icon: Icons.lock,
                          myController: _confirmPasswordController,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        //Sign Up Button
                        //
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
                              onPressed(context);
                            },
                            borderRadius: BorderRadius.circular(50),
                            height: 60,
                            width: 180,
                            child: const Center(
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Sign In
                        //
                        Center(
                          child: TextButton(
                            onPressed: () {
                              GoRouter.of(context).pushReplacement(
                                  AppRoutes.kPatientLoginRoute);
                            },
                            child: const Text(
                              "Do you have an account ? SIGN IN",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// ** Verify Email Card ///
  ///
  Center VerifyEmail(
      BuildContext context, String finalCode, VerificationEmailSuccess state) {
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
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Enter verification Code',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.green,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                VerificationCode(
                  itemSize: 40,
                  fullBorder: true,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                  keyboardType: TextInputType.number,
                  underlineColor: Colors.teal,
                  length: 5,
                  cursorColor: Colors.teal,
                  clearAll: Text(
                    'clear all',
                    style: TextStyle(
                        fontSize: 18.0,
                        decoration: TextDecoration.underline,
                        color: Colors.teal[700]),
                  ),
                  margin: const EdgeInsets.all(12),
                  onCompleted: (String value) {
                    finalCode = value;
                    log(value.toString());
                    log(finalCode.toString());
                  },
                  onEditing: (bool value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                StanderBottom(
                    height: 50,
                    width: 150,
                    text: 'Confirm',
                    onPressed: () async {
                      if (finalCode == state.code.verificationCode) {
                        var authCubit = BlocProvider.of<AuthCubit>(context);
                        await authCubit.signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _userNameController.text,
                            gender: genderType(),
                            phone: _phoneController.text);
                      } else {
                        customSnackBar(context,
                            title: 'Code Warning',
                            message: 'Code doesn\'t match',
                            type: ContentType.warning);
                      }
                    },
                    fontSize: 15),
              ],
            ),
            TextButton.icon(
                onPressed: () {
                  var authCubit = BlocProvider.of<AuthCubit>(context);
                  authCubit.setInit();
                  LocalUserModel.deleteUser();
                },
                label: const Text('Back'),
                icon: const Icon(Icons.arrow_back)),
          ],
        ),
      ),
    );
  }

  /// *Methods ///
  ///
  void onPressed(BuildContext context) {
    requiredFieldCheck(context);
  }

  /// Required Field Check
  ///
  void requiredFieldCheck(BuildContext context) {
    if (_emailController.text.isNotEmpty &&
        _userNameController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      confirmPasswordCheck(context);
    } else {
      customSnackBar(
        context,
        title: 'Required Field',
        message: 'All field are required !',
        type: ContentType.warning,
      );
    }
  }

  /// Confirm Password Check
  ///
  void confirmPasswordCheck(BuildContext context) {
    if (_passwordController.text == _confirmPasswordController.text) {
      emailCheck(context);
    } else {
      customSnackBar(
        context,
        title: 'Password Warning',
        message: 'Password doesn\'t match',
        type: ContentType.warning,
      );
    }
  }

  /// Email Check
  ///
  void emailCheck(BuildContext context) {
    if (RegExceprission.isValidEmail(_emailController.text) == true) {
      passwordCheck(context);
    } else {
      customSnackBar(
        context,
        title: 'Wrong Email',
        message: 'Please Enter Correct Email',
        type: ContentType.failure,
      );
    }
  }

  /// Password Check
  ///
  void passwordCheck(BuildContext context) {
    if (RegExceprission.isValidPassword(_passwordController.text) == true) {
      phoneCheck(context);
    } else {
      customSnackBar(
        context,
        title: 'Password Warning',
        message:
            'Password Must be at least 8 characters long and contain at least one letter.',
        type: ContentType.failure,
      );
    }
  }

  /// Phone Check
  ///
  void phoneCheck(BuildContext context) {
    if (RegExceprission.validatePhoneNumberOne(_phoneController.text) == true ||
        RegExceprission.validatePhoneNumberTwo(_phoneController.text) == true) {
      storeInHive();
      sendCodeToEmail(context);
    } else {
      customSnackBar(
        context,
        title: 'Wrong Phone Number ',
        message:
            'Phone Number Must be 10 digits long and start with 07 OR Must be 9 number +962********',
        type: ContentType.failure,
      );
    }
  }

  /// Send Verification Code To Email
  ///
  void sendCodeToEmail(BuildContext context) async {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    authCubit.setLoding();
    authCubit.verificationEmail(email: _emailController.text);
  }

  /// Store The Patient Information In Hive
  ///
  void storeInHive() {
    LocalUserModel.setUserType('patient');
    LocalUserModel.setUserEmail(_emailController.text);
    LocalUserModel.setUserName(_userNameController.text);
    LocalUserModel.setUserGender(genderType());
    LocalUserModel.setUserPhone(_phoneController.text);
  }
}
