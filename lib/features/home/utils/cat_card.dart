import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../../core/database/local_user_model.dart';
import '../../doctor/doctor_info/cubit/doctor_cubit_cubit.dart';

class CatCard extends StatelessWidget {
  const CatCard({
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
        width: LocalUserModel.getUserType() == 'patient'
            ? MediaQuery.sizeOf(context).width * 0.44
            : MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * 0.22,
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: LocalUserModel.getUserType() == 'patient'
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: LocalUserModel.getUserType() == 'patient'
                          ? MediaQuery.sizeOf(context).width * 0.02
                          : MediaQuery.sizeOf(context).width * 0.07,
                      top: MediaQuery.sizeOf(context).height * 0.02),
                  //*Describe text
                  child: Text(
                    textAlign: TextAlign.start,
                    txt,
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width * 0.037,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.008),
                  //Try now button
                  child: Builder(builder: (context) {
                    return TextButton.icon(
                      onPressed: () async {
                        if (isDoctor) {
                          LocalDoctorModelService.clearDoctors();
                          var doctor =
                              BlocProvider.of<DoctorCubitCubit>(context);
                          doctor.getAllDoctorInfo();
                        }
                        GoRouter.of(context).push(widgetRoute);
                      },
                      icon: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.amber,
                        size: MediaQuery.sizeOf(context).width * 0.04,
                      ),
                      label: Text(
                        'Try now',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: MediaQuery.sizeOf(context).width * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ),
              ],
            ),
            LocalUserModel.getUserType() == 'patient'
                ? const SizedBox()
                : const Spacer(
                    flex: 1,
                  ),
            //Fade container
            Container(
              height: MediaQuery.sizeOf(context).height * 0.22,
              width: LocalUserModel.getUserType() == 'patient'
                  ? MediaQuery.sizeOf(context).width * 0.16
                  : MediaQuery.sizeOf(context).width * 0.4,
              decoration: BoxDecoration(
                color: Colors.teal.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(100),
                  bottomLeft: const Radius.circular(100),
                  topRight: LocalUserModel.getUserType() == 'patient'
                      ? const Radius.circular(40)
                      : const Radius.circular(20),
                  bottomRight: LocalUserModel.getUserType() == 'patient'
                      ? const Radius.circular(40)
                      : const Radius.circular(20),
                ),
              ),
              //icon
              child: Icon(
                icon,
                color: Colors.orange,
                size: MediaQuery.sizeOf(context).width * 0.14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
