import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/notification_service.dart';

import 'core/route.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/chat/cubit/socket_cubit/socket_cubit.dart';

import 'api_packages/dependency_injection/get_it_locator.dart';
import 'core/database/doctor_hive/local_doctor_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await NotificationService.initializeNotification();
  await Hive.initFlutter();
  await Hive.openBox('local_database');
  await Hive.openBox('local_secure_database');
  await Hive.openBox('LocalUserModel');
  Hive.registerAdapter(LocalDoctorModelAdapter());
  await Hive.openBox<LocalDoctorModel>('localDoctorModelBox');

  runApp(BlocProvider(
    create: (context) => getIt<SocketCubit>(),
    child: const BioSync(),
  ));
}

class BioSync extends StatelessWidget {
  const BioSync({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
    );
  }
}
