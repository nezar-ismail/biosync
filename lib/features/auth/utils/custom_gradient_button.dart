import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Gradient gradient;
  final VoidCallback onPressed;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final double height;
  final double width;

  const GradientButton({
    super.key,
    required this.gradient,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: gradient,
        ),
        child: child,
      ),
    );
  }
}
