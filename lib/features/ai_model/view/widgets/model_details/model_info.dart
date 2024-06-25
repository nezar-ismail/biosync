import 'package:flutter/material.dart';

class ModelInfo extends StatelessWidget {
  const ModelInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.22,
      child: Scrollbar(
        child: ListView(
          children: [
            Text(
              "This diagnostic examination will include uploading an X-ray image related to the medical condition. After that, this image will be sent to artificial intelligence algorithms. It will process it and know its result. Thus, the result will be shown immediately with an accuracy of more than 90 percent.",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.width * 0.045,
              ),
              maxLines: 20,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
