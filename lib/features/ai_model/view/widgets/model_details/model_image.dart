import 'package:flutter/material.dart';

class ModelImage extends StatelessWidget {
  const ModelImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.sizeOf(context).height * 0.68,
      left: MediaQuery.sizeOf(context).width * 0.25,
      child: Container(
        height: MediaQuery.sizeOf(context).height / 6,
        width: MediaQuery.sizeOf(context).width / 2,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 13,
              spreadRadius: 1,
              offset: Offset(1, 5),
              // Shadow position
            ),
          ],
          border: Border.all(color: Colors.white, width: 5),
          shape: BoxShape.circle,
          image: const DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage(
              'assets/image/pneumonia.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
