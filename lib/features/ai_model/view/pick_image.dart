// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/custom_snackbar.dart';

import '../../../core/utils/header_back.dart';
import '../../../core/utils/standered_bottom.dart';
import '../cubit/model_cubit_cubit.dart';
import 'model_result.dart';
import 'package:lottie/lottie.dart';

class PickImageWidget extends StatelessWidget {
  PickImageWidget({super.key});
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    File? imageFile;
    return BlocProvider(
      create: (context) => ModelCubitCubit(),
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/Background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const HeaderWithBack(
                    txt: 'Pick Image',
                    txtColor: Colors.white,
                    iconColor: Colors.white),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                  child: Container(
                    height: 490,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 13,
                          spreadRadius: 1,
                          offset: Offset(1, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              height: 350,
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: Colors.black26),

                              ///*Bloc Builder for image and submit button to request *\\\
                              ///
                              ///
                              child: BlocConsumer<ModelCubitCubit,
                                  ModelCubitState>(
                                builder: (context, state) {
                                  if (state is ModelCubitInitial ||
                                      state is FailureImageUploaded ||
                                      state is ModelCubitError ||
                                      state is SuccessPneumoniaImage ||
                                      state is NotPneumoniaImage) {
                                    return const Center(
                                      child: Text('No Image Selected',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    );
                                  } else if (state is ModelCubitLoaded) {
                                    return Image.file(imageFile!,
                                        fit: BoxFit.cover);
                                  } else if (state is ModelCubitLoading) {
                                    return imageFile != null
                                        ? Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            fit: StackFit.expand,
                                            children: [
                                              Image.file(imageFile!,
                                                  fit: BoxFit.cover),
                                              Lottie.asset(
                                                  'assets/lottie/news_loading.json')
                                            ],
                                          )
                                        : const Text('No Image Selected');
                                  }
                                  return const Text('No Image Selected');
                                },
                                listener: (BuildContext context,
                                    ModelCubitState state) {
                                  if (state is ModelCubitInitial) {
                                    customSnackBar(context,
                                        title: 'No Image Selected',
                                        message:
                                            'Please select an image and try again',
                                        type: ContentType.help);
                                    //  isLoaded = false;
                                  } else if (state is ModelCubitLoaded) {
                                    imageFile = state.file;
                                    // isLoaded = true;
                                  } else if (state is FailureImageUploaded) {
                                    customSnackBar(context,
                                        title: 'Error',
                                        message:
                                            'Please select an image and try again',
                                        type: ContentType.failure);
                                  } else if (state is ModelCubitError) {
                                    customSnackBar(context,
                                        title: 'Error',
                                        message:
                                            'Please select an image and try again',
                                        type: ContentType.failure);
                                  } else if (state is NotPneumoniaImage) {
                                    customSnackBar(context,
                                        title: 'Wrong Image',
                                        message:
                                            'Please select an PNEUMONIA image and try again',
                                        type: ContentType.failure);
                                  } else if (state is SuccessPneumoniaImage) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsSlider(
                                                model: state.aiModel,
                                              )),
                                    );
                                    // context.read<ModelCubitCubit>().reset();
                                  }
                                },
                              )),
                        ),

                        ///*Bloc Builder for image*\\\
                        Builder(builder: (context) {
                          return Center(
                            child: TextButton.icon(
                              onPressed: () {
                                context.read<ModelCubitCubit>().pickImage();
                              },
                              icon: const Icon(Icons.add_a_photo),
                              label: const Text('Add Image to Scan',
                                  style: TextStyle(fontSize: 15)),
                            ),
                          );
                        }),

                        ///*Bloc Builder for submit button to request*\\\
                        Builder(builder: (context) {
                          return Center(
                            child: StanderBottom(
                              height: 50,
                              width: 200,
                              text: 'Submit',
                              onPressed: () async {
                                var cubit =
                                    BlocProvider.of<ModelCubitCubit>(context);
                                imageFile != null ? cubit.setLoding() : null;
                                log(imageFile!.path.toString());
                                imageFile != null
                                    ? await cubit.postImage(file: imageFile!)
                                    : null;
                              },
                              fontSize: 15,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
