// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../../../../../core/database/doctor_hive/local_doctor_model.dart';
import '../../../../../core/database/local_user_model.dart';

class DaysContainer extends StatelessWidget {
  const DaysContainer({
    super.key,
    required this.doctor,
    required this.i,
  });
  final int i;
  final LocalDoctorModel? doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade100, width: 3),
            color: Colors.teal,
            shape: BoxShape.circle),
        child: Center(
            child: Text(
          doctor?.workDay?[i] ?? LocalUserModel.getWorkday()![i].toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white),
        )),
      ),
    );
  }
}


class DaysUserContainer extends StatelessWidget {
  const DaysUserContainer({
    super.key,
    required this.i,
  });
  final int i;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade100, width: 3),
            color: Colors.teal,
            shape: BoxShape.circle),
        child: Center(
            child: Text(
          LocalUserModel.getWorkday()![i].toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 12, color: Colors.white),
        )),
      ),
    );
  }
}
