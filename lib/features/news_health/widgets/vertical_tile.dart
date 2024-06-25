import 'package:flutter/material.dart';
import '../../../api_packages/model/article_model.dart';
import '../views/web_view.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsWebViewsState(
              url: articleModel.url!,
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                  // Shadow position
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(
                  articleModel.image ??
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCEMbFWnCg1Z7GxYgkvk60mlDCP_5Pni53Kg&usqp=CAU',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color: Colors.black26,
              ),
              child: Text(
                articleModel.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.89,
            child: Text(
              articleModel.subTitle ?? '',
              maxLines: 2,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
