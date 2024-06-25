import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/database/local_database.dart';

Container PositiveImageContainer(String imageUrl, String imageUrl2,
    String result, String reliability, context) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.5,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: MediaQuery.of(context).size.height * 0.03,
            scrollDirection: Axis.horizontal,
          ),
          items: [
            ClipRRect(
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
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: ClipRRect(
                child: InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 10.0,
                  scaleEnabled: true,
                  onInteractionStart: (details) {
                    log(details.toString());
                  },
                  child: CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: LocalDataBase.getIPAddress() + imageUrl2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Colors.white,
            color: Colors.teal.shade300,

            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
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
                  " $result\n ${reliability[0] + reliability[1]}%",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            indent: 55,
            endIndent: 55,
            color: Colors.grey,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.05),
          height: MediaQuery.of(context).size.height * 0.2,
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
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text:
                        'We recommend that you contact the doctors in our application and\nconsult them to follow up on your pathological condition.\nWe wish you a speedy recovery. '),
                TextSpan(
                  text: '\nBioSync',
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
