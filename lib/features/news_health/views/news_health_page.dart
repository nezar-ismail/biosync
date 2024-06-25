import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../api_packages/model/article_model.dart';
import '../../../api_packages/news_service/news_services.dart';
import '../widgets/error_message.dart';
import '../widgets/vertical_list.dart';
import 'package:lottie/lottie.dart';

class NewsHealth extends StatelessWidget {
  const NewsHealth({
    super.key,
    required this.category,
  });
  final String category;

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final NewsService newsService = NewsService(dio);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BioSync News'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            FutureBuilder<List<ArticleModel>>(
              future: newsService.getTopHeadLines(
                  category: category), // Directly calling the future here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child:
                              Lottie.asset('assets/lottie/news_loading.json')),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const SliverToBoxAdapter(
                    child: ErrorMessage(),
                  );
                } else if (snapshot.hasData) {
                  return VerticalList(articles: snapshot.data!);
                } else {
                  return const SliverToBoxAdapter(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


