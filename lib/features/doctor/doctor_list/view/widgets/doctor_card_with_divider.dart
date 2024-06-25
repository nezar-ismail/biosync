import 'package:flutter/material.dart';
import '../../../../../core/database/doctor_hive/local_doctor_model.dart';
import '../../../../../core/utils/doctor_card.dart';

class DoctorWithDivider extends StatelessWidget {
  const DoctorWithDivider({
    super.key,
    required this.localDoctorModel,
  });
  final LocalDoctorModel localDoctorModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DoctorCard(
          shadowBox: false,
          localDoctorModel: localDoctorModel,
        ),
        Divider(
          color: Colors.grey.shade300,
          thickness: 1,
          indent: 40,
          endIndent: 40,
        )
      ],
    );
  }
}
