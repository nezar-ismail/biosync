import 'package:flutter/material.dart';
import 'white_card.dart';
import '../../../../../core/utils/header_back.dart';

class ModelDetails extends StatelessWidget {
  const ModelDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: const Column(
          children: [
            HeaderWithBack(
              txt: 'Diagnosis Details',
              txtColor: Colors.white,
              iconColor: Colors.white,
            ),
            WhiteCardForModelInfo(),
          ],
        ),
      ),
    );
  }
}
