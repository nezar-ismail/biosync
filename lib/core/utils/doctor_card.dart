// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database/doctor_hive/local_doctor_model.dart';
import '../database/local_database.dart';

import '../../features/doctor/doctor_info/view/doctor_view.dart';

import 'standered_bottom.dart';

class DoctorCard extends StatelessWidget {
  DoctorCard({
    super.key,
    required this.shadowBox,
    required this.localDoctorModel,
  });
  LocalDoctorModel localDoctorModel;
  bool shadowBox;
  int? id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        padding: const EdgeInsets.only(bottom: 4),
        height: MediaQuery.sizeOf(context).height * 0.15,
        width: MediaQuery.sizeOf(context).width - 50,
        decoration: BoxDecoration(
          color: shadowBox == true ? Colors.white : Colors.transparent,
          borderRadius: shadowBox == true
              ? BorderRadius.circular(10)
              : BorderRadius.circular(0),
          boxShadow: [
            shadowBox == true
                ? BoxShadow(
                    blurRadius: 3,
                    color: const Color.fromARGB(255, 136, 136, 136)
                        .withOpacity(0.3),
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  )
                : const BoxShadow(
                    blurRadius: 0,
                    color: Colors.transparent,
                  )
          ],
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ///Doctor Image
            ///
            Container(
              width: MediaQuery.sizeOf(context).width * 0.2,
              height: MediaQuery.sizeOf(context).height * 0.11,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey,
                    spreadRadius: 1,
                    offset: Offset(0, 1),
                  )
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    LocalDataBase.getIPAddress() + localDoctorModel.image!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            ///Doctor Info
            ///
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Name
                  ///
                  Text(
                    localDoctorModel.doctorName!,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),

                  ///Specialization
                  ///
                  Text(
                    localDoctorModel.specialization!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),

                  ///Info Row
                  ///
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.60,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///Icon
                        ///
                        const Icon(
                          FontAwesomeIcons.starHalfStroke,
                          color: Colors.orange,
                        ),

                        ///Rating
                        ///
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Text(
                            localDoctorModel.averageRating.toString()[0] +
                                localDoctorModel.averageRating.toString()[1] +
                                localDoctorModel.averageRating.toString()[2],
                            style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        ///View Profile
                        ///
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: StanderBottom(
                            height: 30,
                            text: 'View Profile',
                            width: 90,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DoctorView(
                                    doctor: localDoctorModel,
                                    isDoctor: false,
                                  ),
                                ),
                              );
                            },
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
