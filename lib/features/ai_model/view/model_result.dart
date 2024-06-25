import 'package:flutter/material.dart';
import '../../../api_packages/model/ai_image_model.dart';
import 'widgets/negative_image_container.dart';
import 'widgets/positive_image_container.dart';

class NewsSlider extends StatelessWidget {
  const NewsSlider({super.key, required this.model});
  final AIModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Diagnosis Result'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: model.result == 'positive'
            ? PositiveImageContainer(model.hitMap!, model.image!, model.result!,
                model.reliability!, context)
            : NegativeImageContainer(
                model.image!, model.result!, model.reliability!, context));
  }
}
