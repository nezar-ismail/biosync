import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../api_packages/model/article_model.dart';
import '../../../api_packages/news_service/news_services.dart';
import '../widgets/error_message.dart';
import '../widgets/horizontal_list_view.dart';
import 'package:lottie/lottie.dart';

class CardNewsHealth extends StatelessWidget {
  const CardNewsHealth({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final NewsService newsService = NewsService(dio);
    return FutureBuilder<List<ArticleModel>>(
      future: newsService.getTopHeadLines(
          category: category), // Directly calling the future here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Lottie.asset('assets/lottie/news_loading.json'));
        } else if (snapshot.hasError) {
          return const ErrorMessage();
        } else if (snapshot.hasData) {
          return HorizontalNewsListView(articles: snapshot.data!);
        } else {
          return const Center(child: Text('No News For Today'));
        }
      },
    );
  }
}

// // ignore_for_file: depend_on_referenced_packages
