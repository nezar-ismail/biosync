import 'package:flutter/material.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        alignment: Alignment.center,
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
                // gradient starts from left
                begin: Alignment.centerRight,
                // gradient ends at right
                end: Alignment.centerLeft,
                colors: [
                  Colors.teal,
                  Colors.teal.shade300,
                  Colors.teal.shade400,
                  Colors.teal.shade500,
                ])),
        child: const Center(
          child: Text(
            'Make Appointment',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
