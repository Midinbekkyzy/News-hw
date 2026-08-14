import 'package:news_hw/features/news/domain/models/news_article_model.dart';

abstract interface class NewsRepository {
  Future<List<NewsArticleModel>> getNews();
}
