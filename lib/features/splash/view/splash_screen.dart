import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/route.dart';
import '../../../core/utils/custom_snackbar.dart';
import '../cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SplashCubit();
        Future.delayed(const Duration(seconds: 3), () async {
          await cubit.checkServer();
        });
        return cubit;
      },
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is InternetError) {
            context.read<SplashCubit>().setLoadding();
            log('Connection Error');
          } else if (state is InternetConnected) {
            context.read<SplashCubit>().loggedIn();
          } else if (state is PatientAlreadyLogin) {
            log('Splash Loaded');
            GoRouter.of(context).pushReplacement(
              AppRoutes.kPatientHomeRoute,
            );
          } else if (state is DoctorAlreadyLogin) {
            log('Splash Loaded');
            GoRouter.of(context).pushReplacement(
              AppRoutes.kDoctorHomeRoute,
            );
          } else if (state is UserLoggedOut) {
            GoRouter.of(context).pushReplacement(
              AppRoutes.kPatientLoginRoute,
            );
          } else if (state is SplashError) {
            customSnackBar(context,
                title: "There is something wrong",
                message: "Please Try Again later",
                type: ContentType.failure);
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading) {
                      return IconButton(
                        onPressed: () {
                          context.read<SplashCubit>().setInit();
                          context.read<SplashCubit>().checkServer();
                        },
                        icon: const Icon(Icons.refresh),
                        iconSize: 48,
                        color: Colors.blue,
                      );
                    }
                    const colorizeColors = [
                      Color(0xff004c4c),
                      Color(0xff006666),
                      Color(0xffb2d8d8),
                      Color(0xff66b2b2),
                      Color(0xff008080),
                    ];

                    const colorizeTextStyle = TextStyle(
                      fontSize: 45.0,
                      fontFamily: 'Anton',
                    );

                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xffb2d8d8),
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'BioSync Diagnosis',
                                textStyle: colorizeTextStyle,
                                colors: colorizeColors,
                                speed: const Duration(milliseconds: 700),
                              ),
                            ],
                            isRepeatingAnimation: true,
                            onTap: () {
                              log("Tap Event");
                            },
                          ),
                        ),
                      )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
