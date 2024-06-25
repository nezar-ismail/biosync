import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api_packages/model/doctor_model.dart';
import '../../doctor/doctor_info/cubit/doctor_cubit_cubit.dart';
import 'list_doctor.dart';
import '../../news_health/widgets/error_message.dart';
import 'package:lottie/lottie.dart';

class TopDoctors extends StatelessWidget {
  const TopDoctors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorCubitCubit(),
      child: Builder(builder: (context) {
        return FutureBuilder<List<DoctorModel>>(
          future: context
              .read<DoctorCubitCubit>()
              .getBestDoctorInfo(), // Directly calling the future here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset('assets/lottie/news_loading.json'));
            } else if (snapshot.hasError) {
              return const ErrorMessage();
            } else if (snapshot.hasData) {
              return VerticalDoctorList(doctors: snapshot.data!);
            } else {
              return const Center(child: Text('No Doctors For Today'));
            }
          },
        );
      }),
    );
  }
}

