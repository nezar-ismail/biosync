import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/route.dart';
import '../../../../../core/utils/standered_bottom.dart';
import 'model_image.dart';
import 'model_info.dart';
import 'radial_bar.dart';

class WhiteCardForModelInfo extends StatelessWidget {
  const WhiteCardForModelInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.06),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Model Image Tail
                    Text(
                      'Pneumonia Scan',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: MediaQuery.sizeOf(context).height * 0.025,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    Text(
                      'X-Ray Diagnosis',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: MediaQuery.sizeOf(context).height * 0.018,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Radial Bar Row
                    const Row(
                      children: [
                        RadialBar(
                          percentage: 95,
                        ),
                        RadialBar(
                          percentage: 96,
                        ),
                        RadialBar(
                          percentage: 97,
                        ),
                      ],
                    ),
                    //About
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.sizeOf(context).width * 0.7),
                      child: Text(
                        'About',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.sizeOf(context).height * 0.035,
                        ),
                      ),
                    ),
                    const ModelInfo(),
                    const Spacer(
                      flex: 1,
                    ),
                    // Button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StanderBottom(
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        width: MediaQuery.sizeOf(context).width - 100,
                        text: 'Start Diagnostics',
                        onPressed: () {
                          GoRouter.of(context).push(AppRoutes.kPickImageRoute);
                        },
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Model image
          const ModelImage(),
        ],
      ),
    );
  }
}
