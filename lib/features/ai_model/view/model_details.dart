import 'package:flutter/material.dart';
import 'widgets/model_details/model_details.dart';

class ModelDetailsView extends StatelessWidget {
  const ModelDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.teal,
      body: ModelDetails(),
    );
  }
}
