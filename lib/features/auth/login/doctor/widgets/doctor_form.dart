import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/custom_snackbar.dart';
import '../../../../../core/utils/standered_bottom.dart';
import '../../../cubit/cubit/auth_cubit.dart';

class FormDoctor extends StatelessWidget {
  FormDoctor({super.key});
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/Background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 149, 149, 149),
                      offset: Offset(1, 1),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      child: Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('assets/image/logo.png'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    const Text.rich(
                      TextSpan(
                        text: 'Welcome to the BioSync health community.\n',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign-up',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' like a doctor',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Email',
                          icon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: BlocProvider(
                            create: (context) => AuthCubit(),
                            child: BlocListener<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is SignUpRequestSuccess) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Thank you for request.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                'Check your email for the Signup Permission.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                } else if (state is SignUpRequestReject) {
                                  customSnackBar(context,
                                      title: 'There is something wrong',
                                      message: 'please try again',
                                      type: ContentType.failure);
                                }
                              },
                              child: Builder(builder: (context) {
                                return StanderBottom(
                                    height: 50,
                                    width: 100,
                                    text: 'Continue',
                                    onPressed: () {
                                      if (_emailController.text.isNotEmpty) {
                                        context
                                            .read<AuthCubit>()
                                            .sendSignUpRequest(
                                                email: _emailController.text);
                                      }
                                    },
                                    fontSize: 12);
                              }),
                            ),
                          )),
                    ),
                    const Spacer(
                      flex: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
