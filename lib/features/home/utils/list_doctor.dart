import 'package:flutter/material.dart';

import '../../../api_packages/model/doctor_model.dart';
import 'top_doctor_card.dart';

class VerticalDoctorList extends StatelessWidget {
  final List<DoctorModel> doctors;

  const VerticalDoctorList({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TopDoctorCard(doctor: doctors[index]),
            );
          }),
    );
  }
}
