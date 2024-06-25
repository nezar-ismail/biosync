import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/doctor/doctor_info/cubit/doctor_cubit_cubit.dart';
import '../../../../core/database/doctor_hive/local_doctor_model_service.dart';
import '../../../../core/route.dart';
import '../../../../core/utils/title_view.dart';
import '../../utils/p_cat_card.dart';
import '../../utils/top_doctors.dart';
import '../../../news_health/views/card_news_health.dart';
import '../../../news_health/views/news_health_page.dart';

class PatientHomeWidget extends StatelessWidget {
  const PatientHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.02,
          vertical: MediaQuery.sizeOf(context).height * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //*News with title and view all button
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const NewsHealth(category: 'health');
                  }));
                },
                icon: const Icon(Icons.chevron_right, size: 18),
                label:
                    const Text('View All News', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: double.infinity,
            child: const CardNewsHealth(category: 'health'),
          ),

          //*service title
          // const CustomCard(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Services For You',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          //*service cards
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                PatientCatCard(
                  txt:
                      'Diagnose your disease \nand get highly accurate \nresults.',
                  icon: FontAwesomeIcons.heartPulse,
                  widgetRoute: AppRoutes.kModelInfoRoute,
                  isDoctor: false,
                ),
                SizedBox(height: 4.0),
                PatientCatCard(
                  txt:
                      'Find the right doctor to \nfollow up your medical \ncondition. ',
                  icon: FontAwesomeIcons.userDoctor,
                  widgetRoute: AppRoutes.kDoctorListRoute,
                  isDoctor: true,
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocProvider(
              create: (context) => DoctorCubitCubit(),
              child: BlocListener<DoctorCubitCubit, DoctorCubitState>(
                listener: (context, state) {
                  if (state is DoctorCubitLoaded) {
                    GoRouter.of(context).push(AppRoutes.kDoctorListRoute);
                  }
                },
                child: Builder(builder: (context) {
                  return TitleWithViewAll(
                    txt: 'Top Doctors For You',
                    onPressed: () {
                      LocalDoctorModelService.clearDoctors();
                      var doctor = BlocProvider.of<DoctorCubitCubit>(context);
                      doctor.getAllDoctorInfo();
                    },
                    text: 'View All',
                  );
                }),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.25,
            width: double.infinity,
            child: const TopDoctors(),
          ),
        ],
      ),
    );
  }
}
