import 'package:flutter/material.dart';

class TitleWithViewAll extends StatelessWidget {
  const TitleWithViewAll({
    super.key,
    required this.txt,
    required this.onPressed,
    required this.text,
  });
  final String txt;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          txt,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const Spacer(
          flex: 1,
        ),
        TextButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.chevron_right, size: 18),
          label: Text(text, style: const TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}
