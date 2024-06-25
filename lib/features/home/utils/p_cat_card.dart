import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../doctor/doctor_info/cubit/doctor_cubit_cubit.dart';

class PatientCatCard extends StatelessWidget {
  const PatientCatCard({
    super.key,
    required this.txt,
    required this.icon,
    required this.widgetRoute,
    required this.isDoctor,
  });
  final String txt;
  final IconData icon;
  final String widgetRoute;
  final bool isDoctor;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubitCubit(),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(colors: [
            Colors.teal.shade300,
            Colors.teal.shade400,
            Colors.teal.shade500,
            Colors.teal.shade600,
            Colors.teal.shade700,
            Colors.teal.shade800,
          ]),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.teal.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
                //icon
                child: Icon(
                  icon,
                  color: Colors.amber,
                  size: 35,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  textAlign: TextAlign.start,
                  txt,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Spacer(
                flex: 5,
              ),
              Builder(builder: (context) {
                return TextButton.icon(
                  onPressed: () async {
                    if (isDoctor) {
                      LocalDoctorModelService.clearDoctors();
                      var doctor = BlocProvider.of<DoctorCubitCubit>(context);
                      doctor.getAllDoctorInfo();
                    }
                    GoRouter.of(context).push(widgetRoute);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.orange,
                    size: 18,
                  ),
                  label: const Text(
                    'Try now',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
