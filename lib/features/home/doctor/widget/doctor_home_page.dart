import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/route.dart';
import '../../../../core/utils/title_view.dart';

import '../../utils/cat_card.dart';
import '../../utils/home_heder.dart';
import '../../../news_health/views/card_news_health.dart';
import '../../../news_health/views/news_health_page.dart';

class DoctorHomeWidget extends StatelessWidget {
  const DoctorHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.02,
          vertical: MediaQuery.sizeOf(context).height * 0.01),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          //*Header Widget (Home Header) user pic, name and option list
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: HomeHeader(),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          const CatCard(
            txt: 'Diagnose your disease \nand get highly accurate \nresults.',
            icon: FontAwesomeIcons.heartPulse,
            widgetRoute: AppRoutes.kModelInfoRoute,
            isDoctor: false,
          ),

          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),

          //*Container with title and view all button
          TitleWithViewAll(
            txt: 'Top News For You',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const NewsHealth(category: 'health');
              }));
            },
            text: 'View All',
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.23,
            width: double.infinity,
            child: const CardNewsHealth(category: 'health'),
          ),
        ],
      ),
    );
  }
}
