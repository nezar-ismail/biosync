import 'package:flutter/material.dart';
import '../../../api_packages/model/article_model.dart';
import 'vertical_tile.dart';

class VerticalList extends StatelessWidget {
  final List<ArticleModel> articles;

  const VerticalList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: articles.length,
          (context, index) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return VerticalTile(articleModel: articles[index]);
              }),
        );
      }),
    );
  }
}
