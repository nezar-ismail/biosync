import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../../core/database/doctor_hive/local_doctor_model.dart';
import '../../../../core/database/local_secure_storage.dart';
import '../../../../core/database/local_user_model.dart';
import '../../../../core/route.dart';
import '../../../chat/cubit/socket_cubit/socket_cubit.dart';
import '../../../doctor/doctor_info/cubit/doctor_cubit_cubit.dart';
import '../../../doctor/doctor_info/view/doctor_view.dart';
import 'doctor_home_page.dart';
import '../../../privacy/privacy.dart';

class DoctorCustomDrawer extends StatelessWidget {
  const DoctorCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    LocalDoctorModel localDoctorModel = LocalDoctorModel(
      about: LocalUserModel.getAbout(),
      experience: LocalUserModel.getExperience(),
      image: LocalUserModel.getUserImage(),
      doctorEmail: LocalUserModel.getUserEmail(),
      doctorName: LocalUserModel.getUserName(),
      id: LocalUserModel.getUserId(),
      phone: LocalUserModel.getUserPhone(),
      gender: LocalUserModel.getUserGender(),
      specialization: LocalUserModel.getSpecialization(),
      workDay: LocalUserModel.getWorkday(),
      averageRating: LocalUserModel.getRating(),
    );
    log(localDoctorModel.workDay.toString());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SliderDrawer(
          slideDirection: SlideDirection.LEFT_TO_RIGHT,
          appBar: SliderAppBar(
            appBarHeight: MediaQuery.sizeOf(context).height * 0.1,
            drawerIconSize: MediaQuery.sizeOf(context).height * 0.04,
            appBarColor: Colors.white,
            title: const Image(
              image: AssetImage('assets/image/logo.png'),
            ),
          ),
          sliderOpenSize: MediaQuery.sizeOf(context).width * 0.28,
          slider: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.teal,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    GoRouter.of(context).push(AppRoutes.kDoctorProfileRoute);
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        FontAwesomeIcons.userLarge,
                        color: Colors.white,
                        size: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                      const Text(
                        ' Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Privacy()));
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.privacy_tip,
                        color: Colors.white,
                        size: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                      const Text(
                        ' Privacy',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              'Logout',
                            ),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    getIt<SocketCubit>().userDisconnected();
                                    LocalUserModel.deleteUser();
                                    LocalSecureStorage.delete();
                                    GoRouter.of(context).pushReplacement(
                                        AppRoutes.kkDoctorLoginRoute);
                                  },
                                  child: const Text('Yes')),
                            ]);
                      },
                    );
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                      const Text(
                        ' Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )

                ///profile
                ,

                ///doctor info
                BlocProvider(
                  create: (context) => DoctorCubitCubit(),
                  child: Builder(
                    builder: (context) {
                      return TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorView(
                                  doctor: localDoctorModel,
                                  isDoctor: true,
                                ),
                              ));
                        },
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              FontAwesomeIcons.userDoctor,
                              color: Colors.white,
                              size: MediaQuery.sizeOf(context).width * 0.08,
                            ),
                            const Text(
                              ' Profile',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          child: const DoctorHomeWidget(),
        ),
      ),
    );
  }
}
