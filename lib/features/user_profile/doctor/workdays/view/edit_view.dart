// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/utils/custom_snackbar.dart';
import 'package:login/features/user_profile/doctor/workdays/cubit/workdays_cubit.dart';
import 'package:login/features/user_profile/doctor/workdays/widgets/standerd_button.dart';

class EditDoctorWorkDays extends StatefulWidget {
  const EditDoctorWorkDays({super.key});

  @override
  _EditDoctorWorkDaysState createState() => _EditDoctorWorkDaysState();
}

class _EditDoctorWorkDaysState extends State<EditDoctorWorkDays> {
  bool Sunday = false;
  bool Monday = false;
  bool Tuesday = false;
  bool Wednesday = false;
  bool Thursday = false;
  bool Friday = false;
  bool Saturday = false;

  TextEditingController myDoctorNameController = TextEditingController();
  TextEditingController myDoctorEmailController = TextEditingController();
  TextEditingController myDoctorPasswordController = TextEditingController();
  TextEditingController myDoctorPhoneController = TextEditingController();
  TextEditingController myDoctorSpecializationController =
      TextEditingController();
  TextEditingController myDoctorExperienceController = TextEditingController();
  TextEditingController myDoctorAboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkdaysCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<WorkdaysCubit, WorkdaysState>(
            listener: (context, state) {
              if (state is UpdatedWorkDaysFailed) {
                customSnackBar(context,
                    title: 'Error',
                    message:
                        'Something went wrong, please try again and if the problem persists contact support',
                    type: ContentType.failure);
              } else if (state is UpdatedWorkDaysSuccess) {
                customSnackBar(context,
                    title: 'Success',
                    message: 'Work days updated successfully',
                    type: ContentType.success);
                Navigator.pop(context);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ]),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 30),
                        child: Center(
                          child: Text(
                            'Work Days:',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      ...[
                        "Sunday",
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Saturday"
                      ].asMap().entries.map((entry) {
                        int idx = entry.key;
                        String day = entry.value;
                        return CheckboxListTile(
                          title: Text(
                            day,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          value: getDayValue(idx),
                          onChanged: (bool? value) {
                            setDayValue(idx, value);
                          },
                        );
                      }),
                      Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 100),
                          child: StanderButton(
                            text: 'Submit',
                            onPressed: () => submitForm(context),
                            height: 50,
                            width: 100,
                            fontSize: 22,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool? getDayValue(int idx) {
    switch (idx) {
      case 0:
        return Sunday;
      case 1:
        return Monday;
      case 2:
        return Tuesday;
      case 3:
        return Wednesday;
      case 4:
        return Thursday;
      case 5:
        return Friday;
      case 6:
        return Saturday;
      default:
        return false;
    }
  }

  void setDayValue(int idx, bool? value) {
    setState(() {
      switch (idx) {
        case 0:
          Sunday = value ?? false;
          break;
        case 1:
          Monday = value ?? false;
          break;
        case 2:
          Tuesday = value ?? false;
          break;
        case 3:
          Wednesday = value ?? false;
          break;
        case 4:
          Thursday = value ?? false;
          break;
        case 5:
          Friday = value ?? false;
          break;
        case 6:
          Saturday = value ?? false;
          break;
      }
    });
  }

  void submitForm(BuildContext context) {
    List<bool> workDays = [
      Sunday,
      Monday,
      Tuesday,
      Wednesday,
      Thursday,
      Friday,
      Saturday,
    ];
    context
        .read<WorkdaysCubit>()
        .EDITWorkDays(workdays: checkWorkDays(workDays));
    // Optionally navigate back or to another page
  }

  bool isNumeric(String str) {
    return RegExp(r'^\d+$').hasMatch(str);
  }

  Map<String, dynamic> checkWorkDays(List<bool?> days) {
    List<String> daysList = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    Map<String, dynamic> daysMap = {};
    for (int i = 0; i < daysList.length; i++) {
      if (days[i] == true) {
        daysMap[daysList[i].toLowerCase()] = daysList[i];
      }
    }
    log(daysMap.toString());
    return daysMap;
  }
}
