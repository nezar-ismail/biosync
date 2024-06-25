// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../api_packages/dependency_injection/get_it_locator.dart';

import '../../../../core/database/doctor_hive/local_doctor_model.dart';
import '../../../../core/database/local_database.dart';
import '../../../../core/database/local_user_model.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../chat/cubit/chat_service_cubit/chat_service_cubit.dart';
import '../../../chat/cubit/socket_cubit/socket_cubit.dart';

import '../cubit/doctor_cubit_cubit.dart';
import 'web_view.dart';
import 'widgets/check_days.dart';
import 'widgets/doctor_about.dart';
import 'widgets/reviews_info.dart';
import '../../../../core/utils/standered_bottom.dart';

// ignore: must_be_immutable
class DoctorView extends StatelessWidget {
  DoctorView({
    super.key,
    required this.doctor,
    required this.isDoctor,
  });
  LocalDoctorModel doctor;
  final isDoctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        right: false,
        left: false,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.01),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Stack(
              children: [
                ///  container for gradient
                ///
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.24,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.teal,
                      Colors.teal.shade300,
                      Colors.teal.shade400,
                    ]),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 147, 147, 147),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      )
                    ],
                    color: Colors.teal,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.02),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              GoRouter.of(context).pop();
                            },
                            icon: Icon(
                              FontAwesomeIcons.circleArrowLeft,
                              color: Colors.white,
                              size: MediaQuery.sizeOf(context).width * 0.12,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 130,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              child: Center(
                                child: Text(
                                  'Dr.${doctor.doctorName}',
                                  style: const TextStyle(
                                      letterSpacing: 3,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),

                ///  image and specialization
                ///
                Positioned(
                  top: 125,
                  left: MediaQuery.sizeOf(context).width / 2 - 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          LocalDataBase.getIPAddress() + doctor.image!,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),

                      /// Specialization
                      ///
                      Text(
                        doctor.specialization!.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                ///  Reviews  And Experience
                ///
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.32,
                  left: MediaQuery.sizeOf(context).width / 2 - 160,
                  child: BlocProvider(
                    create: (context) => DoctorCubitCubit(),
                    child: ReviewsInfo(
                      localDoctorModel: doctor,
                      isDoctor: isDoctor,
                    ),
                  ),
                ),

                ///  About
                ///
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.45,
                  left: 0,
                  child: DoctorAbout(doctor: doctor),
                ),

                ///  Divider
                ///
                Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.72,
                  left: MediaQuery.sizeOf(context).width / 2 - 180,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade300,
                      indent: 50,
                      endIndent: 50,
                    ),
                  ),
                ),

                ///  Check Days
                ///
                Positioned(
                  top: 610,
                  left: 0,
                  child: ListDays(
                    doctor:  doctor,
                  ),
                ),

                ///  Bottom
                ///
                isDoctor == true
                    ? const SizedBox()
                    : BlocProvider(
                        create: (context) => ChatServiceCubit(),
                        child: BlocListener<ChatServiceCubit, ChatServiceState>(
                          listener: (context, state) {
                            //
                            if (state is RoomDoesNotExist) {
                              context.read<ChatServiceCubit>().sendUsersId(
                                  doctorId: doctor.id!,
                                  patientId: LocalUserModel.getUserId());
                            }
                            //
                            else if (state is RoomExist) {
                              customSnackBar(context,
                                  title: 'Room Already Exist',
                                  message: 'Please Join Chat From Chats List',
                                  type: ContentType.help);
                            }
                            //
                            else if (state is PaymentCheckOut) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentWebViews(
                                    url: LocalDataBase.getIPAddress() +
                                        state.link,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Positioned(
                            bottom: 0,
                            left: MediaQuery.sizeOf(context).width / 2 - 125,
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: BlocProvider(
                                create: (context) => getIt<SocketCubit>(),
                                child: Builder(
                                  builder: (context) {
                                    return StanderBottom(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      text: "Start Chat \$",
                                      onPressed: () {
                                        context
                                            .read<ChatServiceCubit>()
                                            .checkRoomExist(
                                                doctorId: doctor.id!,
                                                patientId:
                                                    LocalUserModel.getUserId());
                                      },
                                      fontSize: 18,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
