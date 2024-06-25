// ignore_for_file: public_member_api_docs, sort_constructors_first
class ArticleModel {
  final String? image;
  final String? title;
  final String? subTitle;
  final String? url;

  ArticleModel({
    required this.url,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  factory ArticleModel.fromJson(json) {
    return ArticleModel(
        url: json['url'],
        image: json['urlToImage'],
        title: json['title'],
        subTitle: json['description']);
  }
}
