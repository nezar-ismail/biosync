import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/user_profile/doctor/workdays/view/edit_view.dart';
import '../../../../../../core/route.dart';

import '../../../../cubits/edit_info/edit_info_cubit.dart';
import '../../model/profile_container_info.dart';

class DoctorInfoContainer extends StatelessWidget {
  const DoctorInfoContainer({
    super.key,
    required this.textModels,
  });
  final DoctorProfileContainerInfoModel textModels;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditInfoCubit(),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 15,
          left: 30,
          right: 30,
        ),
        child: Container(
          height: 100,
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(96, 108, 108, 108),
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //*Container Title
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      textModels.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //*User Info and Icon Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //The Text Where Info Is
                      Text(
                        textModels.userInfo,
                        style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      //The Edit Icon Button To Navigate Edit Page
                      textModels.isPassword
                          ? IconButton(
                              onPressed: () {
                                GoRouter.of(context)
                                    .push(AppRoutes.kEditDoctorPasswordRoute);
                              },
                              icon: const Icon(
                                Icons.edit_square,
                                color: Colors.black26,
                              ),
                            )
                          : textModels.isEditable
                              ? IconButton(
                                  onPressed: () {
                                    GoRouter.of(context)
                                        .push(AppRoutes.kEditDoctorInfoRoute);
                                  },
                                  icon: const Icon(
                                    Icons.edit_square,
                                    color: Colors.black26,
                                  ),
                                )
                              : textModels.isDays
                                  ? IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const EditDoctorWorkDays()));
                                      },
                                      icon: const Icon(
                                        Icons.edit_square,
                                        color: Colors.black26,
                                      ),
                                    )
                                  : const Text('')
                    ],
                  ),
                  const Divider(
                    color: Colors.black38,
                    thickness: 0.5,
                    endIndent: 6,
                    indent: 4,
                    height: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
