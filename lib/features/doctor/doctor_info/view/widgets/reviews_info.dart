// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../core/database/doctor_hive/local_doctor_model.dart';
import '../../../../../core/database/local_user_model.dart';
import '../../../../../core/utils/custom_snackbar.dart';
import '../../../../../core/utils/standered_bottom.dart';
import '../../cubit/doctor_cubit_cubit.dart';

class ReviewsInfo extends StatelessWidget {
  final LocalDoctorModel? localDoctorModel;
  ReviewsInfo(
      {super.key, required this.localDoctorModel, required this.isDoctor});
  String rating = '0.5';
  String experience = '0.2';
  final bool isDoctor;
  @override
  Widget build(BuildContext context) {
    checkRatingAndExperience();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///Reviews
        ///
        SizedBox(
          height: 115,
          width: 150,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  if (isDoctor == false) {
                    ratingDialog(context);
                  }
                },
                child: const Text(
                  'Reviews',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                overflow: TextOverflow.fade,
                maxLines: 1,
                rating[0] + rating[1] + rating[2],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),

        ///Divider
        ///
        const SizedBox(
          height: 80,
          child: VerticalDivider(
            indent: 10,
            endIndent: 10,
            color: Colors.black12,
            thickness: 2.0,
          ),
        ),

        ///Experience
        ///
        SizedBox(
          height: 100,
          width: 150,
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Experience',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              experience.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.teal,
              ),
            ),
          ]),
        ),
      ],
    );
  }

  void ratingDialog(BuildContext context) {
    var doctorRating = 2.5;
    showDialog(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (context) => DoctorCubitCubit(),
            child: AlertDialog(
              backgroundColor: Colors.white,
              shadowColor: Colors.teal,
              title: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Rate Doctor',
                    style: TextStyle(color: Colors.teal, fontSize: 24),
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.all(0),
              content: SizedBox(
                height: 150,
                child: BlocListener<DoctorCubitCubit, DoctorCubitState>(
                  listener: (context, state) {
                    if (state is ReviewAdded) {
                      log(state.toString());
                      customSnackBar(context,
                          title: 'Thank You',
                          message: 'Review has been added successfully',
                          type: ContentType.success);
                    }
                    if (state is ReviewAlreadyExists) {
                      customSnackBar(context,
                          title: 'Already Exists',
                          message: 'You have already reviewed this doctor',
                          type: ContentType.failure);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RatingBar.builder(
                        initialRating: 2.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          log(rating.toString());
                          doctorRating = rating;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Builder(builder: (context) {
                          return StanderBottom(
                              height: 30,
                              width: 100,
                              text: 'Rate',
                              onPressed: () {
                                var cubit = BlocProvider.of<DoctorCubitCubit>(
                                  context,
                                );
                                cubit.addReview(
                                  pID: LocalUserModel.getUserId(),
                                  dID: localDoctorModel?.id ??
                                      LocalUserModel.getUserId(),
                                  ratting: doctorRating,
                                );
                                Navigator.pop(context);
                              },
                              fontSize: 18);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void checkRatingAndExperience() {
    if (localDoctorModel?.averageRating == null) {
      rating = LocalUserModel.getRating().toString();
    } else {
      rating = localDoctorModel!.averageRating.toString();
    }
    if (localDoctorModel?.experience == null) {
      experience = LocalUserModel.getExperience().toString();
    } else {
      experience = localDoctorModel!.experience.toString();
    }
  }
}
