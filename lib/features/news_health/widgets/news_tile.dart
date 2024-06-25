import 'package:flutter/material.dart';
import '../../../api_packages/model/article_model.dart';
import '../views/web_view.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.articleModel});

  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NewsWebViewsState(url: articleModel.url!);
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 115),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage(
              articleModel.image ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCEMbFWnCg1Z7GxYgkvk60mlDCP_5Pni53Kg&usqp=CAU',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
