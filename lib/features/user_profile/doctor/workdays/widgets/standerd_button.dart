import 'package:flutter/material.dart';

class StanderButton extends StatelessWidget {
  const StanderButton({
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
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 5),
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
            )
          ],
          gradient: LinearGradient(
            colors: [
              Colors.green.shade900,
              Colors.green.shade500,
              Colors.green.shade400,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          color: const Color.fromARGB(255, 207, 184, 8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
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
