import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/database/doctor_hive/local_doctor_model.dart';
import '../../../../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../../../../core/database/local_database.dart';

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    super.key,
    required this.doctor,
  });

  final LocalDoctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ///  back button
            ///
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                onPressed: () {
                  LocalDoctorModelService.clearDoctors();
                  GoRouter.of(context).pop();
                },
                icon: const Icon(
                  FontAwesomeIcons.circleArrowLeft,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),

            ///  image
            Positioned(
              top: 200,
              left: MediaQuery.sizeOf(context).width / 2 - 50,
              child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    LocalDataBase.getIPAddress() + doctor.image!,
                  )),
            ),

            ///  Name
            ///
            Positioned(
              top: 40,
              left: MediaQuery.sizeOf(context).width / 2 - 35,
              child: Text(
                doctor.doctorName!,
                style: const TextStyle(
                    letterSpacing: 2,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),

            ///  Specialization
            ///
            Positioned(
              top: 100,
              left: 20,
              child: Text(
                doctor.specialization!,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
