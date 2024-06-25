// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.myController,
    this.pass = false,
  });
  TextEditingController myController = TextEditingController();
  final String hintText;
  final IconData? icon;
  bool pass;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 20, left: 20),
      child: SizedBox(
        height: 60,
        child: TextField(
          controller: myController,
          obscureText: pass,
          cursorColor: Colors.green[300],
          textAlign: TextAlign.start,
          cursorErrorColor: Colors.red,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            border: InputBorder.none,
            fillColor: Colors.grey.shade50,
            focusColor: Colors.grey.shade50,
            errorStyle: const TextStyle(color: Colors.red),
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black26,
              fontSize: 18,
            ),
            suffixIcon: IconButton(
              color: Colors.black26,
              onPressed: () {},
              icon: Icon(icon),
            ),
            contentPadding: const EdgeInsets.all(8),
          ),
          onSubmitted: (value) {
            myController.text = value;
          },
        ),
      ),
    );
  }
}
