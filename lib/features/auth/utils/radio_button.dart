// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';

enum SingingCharacter { male, female }

String gender = '';

// String gender = '';
class RadioButton extends StatefulWidget {
  const RadioButton({
    super.key,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  SingingCharacter? _character = SingingCharacter.male;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Gender',
            style: TextStyle(fontSize: 18, color: Colors.black45),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 145,
              child: ListTile(
                title: const Text('Male'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.male,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value!;
                      gender = _character.toString();
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 160,
              child: ListTile(
                title: const Text('Female'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.female,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value!;
                      gender = _character.toString();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String genderType() {
  log(gender);
  if (gender == "SingingCharacter.female") {
    return "Female";
  } else {
    return "Male";
  }
}
