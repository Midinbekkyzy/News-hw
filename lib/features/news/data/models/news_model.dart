import 'package:news_hw/core/util/transformable.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';

final class NewsModel with Transformable<NewsArticleModel> {
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  NewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'].toString())
          : null,
      content: json['content'] as String?,
    );
  }

  static List<NewsModel> fromJsonList(List<dynamic>? jsonList) {
    return jsonList
            ?.map((json) => NewsModel.fromJson(json as Map<String, dynamic>))
            .toList() ??
        [];
  }

  @override
  NewsArticleModel transform() {
    return NewsArticleModel(
      author: author ?? '',
      title: title ?? '',
      description: description ?? '',
      url: url ?? '',
      urlToImage: urlToImage ?? '',
      publishedAt: publishedAt ?? DateTime.now(),
      content: content ?? '',
    );
  }
}

final class NewsResponseModel with Transformable<NewsResponseEntity> {
  final int? totalResults;
  final List<NewsModel>? articles;

  NewsResponseModel({this.totalResults, this.articles});

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(
      totalResults: json['totalResults'] as int?,
      articles: NewsModel.fromJsonList(json['articles'] as List<dynamic>?),
    );
  }

  @override
  NewsResponseEntity transform() {
    return NewsResponseEntity(
      totalResults: totalResults ?? 0,
      articles: articles?.transform() ?? [],
    );
  }
}
