// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../../../../core/database/doctor_hive/local_doctor_model.dart';

import '../../../../../core/database/local_user_model.dart';
import 'days_container.dart';

class ListDays extends StatelessWidget {
  const ListDays({
    Key? key,
    required this.doctor,
  });
  final LocalDoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.15,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                'Work Days',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            LocalUserModel.getUserType() == 'patient'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < doctor.workDay!.length; i++)
                        DaysContainer(
                          i: i,
                          doctor: doctor,
                        )
                    ],
                  )
                : LocalUserModel.getWorkday()!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0;
                              i < LocalUserModel.getWorkday()!.length;
                              i++)
                            DaysUserContainer(
                                i: LocalUserModel.getWorkday()!.length - 1)
                        ],
                      )
                    : const Text('')
          ],
        ),
      ),
    );
  }
}
