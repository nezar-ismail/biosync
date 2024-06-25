import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../database/doctor_hive/local_doctor_model_service.dart';

class HeaderWithBack extends StatelessWidget {
  const HeaderWithBack({
    super.key,
    this.isDocList = false,
    required this.txt,
    required this.txtColor,
    required this.iconColor,
  });
  final bool isDocList;
  final String txt;
  final Color txtColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //*Back Button
        Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10, top: 15),
            child: IconButton(
              onPressed: () {
                if (isDocList == false) {
                  log(isDocList.toString());
                  GoRouter.of(context).pop();
                } else {
                  LocalDoctorModelService.clearDoctors();
                  Navigator.pop(context);
                }
              },
              iconSize: MediaQuery.sizeOf(context).width * 0.12,
              color: iconColor,
              icon: Icon(
                FontAwesomeIcons.circleArrowLeft,
                color: iconColor,
              ),
            )),
        //*Page Title
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Text(
            txt,
            style: TextStyle(
              color: txtColor,
              fontSize: MediaQuery.sizeOf(context).height * 0.033,
            ),
          ),
        ),
      ],
    );
  }
}
