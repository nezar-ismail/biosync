import 'package:flutter/material.dart';
import '../../../../../core/database/doctor_hive/local_doctor_model.dart';

class DoctorAbout extends StatelessWidget {
  const DoctorAbout({super.key, required this.doctor});
  final LocalDoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.05),
            child: const Text(
              'About',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400,
                decorationColor: Colors.black,
              ),
            ),
          ),
          //container for text about doctor
          Container(
            height: MediaQuery.sizeOf(context).height * 0.22,
            width: MediaQuery.sizeOf(context).width - 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade50,
            ),
            margin: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width * 0.05,
                right: MediaQuery.sizeOf(context).width * 0.05),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text(
                    doctor.about!,
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).height * 0.022,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
