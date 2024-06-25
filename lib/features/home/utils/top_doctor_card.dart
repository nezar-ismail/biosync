import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_packages/model/doctor_model.dart';
import '../../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../../core/database/local_database.dart';
import '../../doctor/doctor_info/cubit/doctor_cubit_cubit.dart';
import '../../doctor/doctor_info/view/doctor_view.dart';

class TopDoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const TopDoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            BlocProvider(
              create: (context) => DoctorCubitCubit(),
              child: BlocListener<DoctorCubitCubit, DoctorCubitState>(
                listener: (context, state) {
                  if (state is DoctorCubitLoadedById) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DoctorView(
                        doctor: LocalDoctorModelService.getDoctors()
                            .where((e) => e.id == doctor.id)
                            .first,
                        isDoctor: false,
                      );
                    }));
                  }
                },
                child: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      var doctor1 = BlocProvider.of<DoctorCubitCubit>(context);
                      doctor1.getDoctorInfoByID(id: doctor.id);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: Colors.teal,
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: Row(children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                        LocalDataBase.getIPAddress() + doctor.image,
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        doctor.specialization,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Dr.${doctor.doctorname}',
                        style: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 24,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            doctor.averageRating.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
