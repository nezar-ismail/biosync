import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/database/local_database.dart';

Container NegativeImageContainer(
    String imageUrl, String result, String reliability, context) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ClipRRect(
            child: InteractiveViewer(
              minScale: 0.1,
              maxScale: 10.0,
              scaleEnabled: true,
              onInteractionStart: (details) {
                log(details.toString());
              },
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl: LocalDataBase.getIPAddress() + imageUrl,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Divider(
            color: Colors.black,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Colors.white,
            color: Colors.white,

            boxShadow: [
              BoxShadow(
                color: Colors.teal.shade100,
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Result       : \nReliability :',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  " $result\n ${reliability[0] + reliability[1] + reliability[2]}%",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    color: const Color.fromARGB(255, 1, 191, 7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Divider(
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.01),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.shade100,
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                children: const [
                  TextSpan(text: 'You are fine,\nkeep taking care of yourself'),
                  TextSpan(
                    text: '\nBioSync',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
