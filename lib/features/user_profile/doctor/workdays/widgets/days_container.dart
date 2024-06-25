// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:login/api_packages/model/doctor_model.dart';

class DaysContainer extends StatelessWidget {
  const DaysContainer({
    super.key,
    required this.doctor,
    required this.i,
  });
  final int i;
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.05,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade100, width: 3),
            color: Colors.teal,
            shape: BoxShape.circle),
        child: Center(
            child: Text(
          doctor.workday![i],
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: MediaQuery.textScalerOf(context).textScaleFactor * 20,
              color: Colors.white),
        )),
      ),
    );
  }
}
