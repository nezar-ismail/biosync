import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class CustomCheckBox extends StatelessWidget {
  final String day;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckBox({
    super.key,
    required this.day,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(day),
      trailing: RoundCheckBox(
        isChecked: value,
        uncheckedColor: Colors.grey.shade300,
        size: 30,
        checkedColor: Colors.green,
        checkedWidget: const Icon(Icons.check),
        onTap: onChanged,
      ),
    );
  }
}
