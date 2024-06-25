import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/database/doctor_hive/local_doctor_model.dart';
import '../../../../core/database/doctor_hive/local_doctor_model_service.dart';
import 'widgets/doctor_card_with_divider.dart';
import '../../../../core/utils/header_back.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    // var userProfileBox = Hive.box('localDoctorModelBox');
    return PopScope(
      child: ValueListenableBuilder(
        valueListenable:
            Hive.box<LocalDoctorModel>('localDoctorModelBox').listenable(),
        builder: (BuildContext context, value, Widget? child) {
          var doctorList = LocalDoctorModelService.getDoctors();
          return Scaffold(
            
            backgroundColor: Colors.teal,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeaderWithBack(
                    isDocList: true,
                    txtColor: Colors.white,
                    iconColor: Colors.white,
                    txt: 'Doctor List',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Container(
                      height : MediaQuery.of(context).size.height * 0.85,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: ListView.builder(
                        itemCount: doctorList.length,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          return DoctorWithDivider(
                            localDoctorModel: doctorList[index],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      onPopInvoked: (didPop) {
        if (didPop) {
          LocalDoctorModelService.clearDoctors();
        }
      },
    );
  }
}
