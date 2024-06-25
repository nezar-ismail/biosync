import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import 'package:go_router/go_router.dart';
import '../../../../../core/route.dart';
import '../../../../../core/utils/standered_bottom.dart';

class VerifyCodeCard extends StatelessWidget {
  const VerifyCodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.02),
            child: Center(
              child: Text(
                'Enter your code',
                style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.025),
              ),
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

            // If this is null it will use primaryColor: Colors.red from Theme
            length: 5,
            cursorColor:
                Colors.blue, // If this is null it will default to the ambient
            // clearAll is NOT required, you can delete it
            // takes any widget, so you can implement your design
            clearAll: Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.02),
              child: Text(
                'clear all',
                style: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.025,
                    decoration: TextDecoration.underline,
                    color: Colors.blue[700]),
              ),
            ),
            margin: EdgeInsets.all(MediaQuery.sizeOf(context).width * 0.02),
            onCompleted: (String value) {
              log(value);
            },
            onEditing: (bool value) {},
          ),
          StanderBottom(
              height: MediaQuery.sizeOf(context).height * 0.07,
              width: MediaQuery.sizeOf(context).width * 0.8,
              text: 'Next',
              onPressed: () {
                GoRouter.of(context).push(AppRoutes.kConfirmCodeRoute);
              },
              fontSize: 15),
        ],
      ),
    );
  }
}
