import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../api_packages/model/article_model.dart';
import 'news_tile.dart';

class HorizontalNewsListView extends StatelessWidget {
  final List<ArticleModel> articles;

  const HorizontalNewsListView({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: MediaQuery.of(context).size.height * 2,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.linearToEaseOut,
        scrollDirection: Axis.horizontal,
      ),
      items:
          articles.map((article) => NewsTile(articleModel: article)).toList(),
    );
  }
}
