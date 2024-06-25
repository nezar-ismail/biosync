// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

class StanderBottom extends StatelessWidget {
  const StanderBottom({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.onPressed,
    required this.fontSize,
  });

  final double height;
  final double width;
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal.shade900,
              Colors.teal.shade500,
              Colors.teal.shade100,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          color: Colors.teal,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
