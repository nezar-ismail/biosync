import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../../../core/database/local_secure_storage.dart';
import '../../../../core/database/local_user_model.dart';
import '../../../../core/route.dart';
import '../../../chat/cubit/socket_cubit/socket_cubit.dart';
import '../../utils/home_heder.dart';
import '../../../privacy/privacy.dart';

class PatientCustomDrawer extends StatelessWidget {
  const PatientCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //*Header Widget (Home Header) user pic, name and option list
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.teal[400],
          ),
          child: const HomeHeader(),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                FontAwesomeIcons.userLarge,
                color: Colors.teal,
                size: MediaQuery.sizeOf(context).height * 0.03,
              ),
              const Text(
                ' Profile',
                style: TextStyle(color: Colors.teal),
              ),
            ],
          ),
          onTap: () {
            GoRouter.of(context).push(AppRoutes.kPatientProfileRoute);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.privacy_tip,
                color: Colors.teal,
                size: MediaQuery.sizeOf(context).height * 0.03,
              ),
              const Text(
                ' Privacy',
                style: TextStyle(color: Colors.teal),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Privacy()));
          },
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.logout,
                color: Colors.teal,
                size: MediaQuery.sizeOf(context).height * 0.03,
              ),
              const Text(
                ' Logout',
                style: TextStyle(color: Colors.teal),
              ),
            ],
          ),
          onTap: () {
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
                            LocalDoctorModelService.clearDoctors();
                            GoRouter.of(context)
                                .pushReplacement(AppRoutes.kPatientLoginRoute);
                          },
                          child: const Text('Yes')),
                    ]);
              },
            );
          },
        ),
      ],
    );
  }
}
