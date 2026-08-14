import 'package:injectable/injectable.dart';
import 'package:news_hw/features/news/data/data_source/abstract/news_data_source.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/domain/repository/news_repository.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl({required this.dataSource});

  final NewsDataSource dataSource;

  @override
  Future<List<NewsArticleModel>> getNews() async {
    final data = await dataSource.getNews();
    return data.map((news) => news.convertToEntity()).toList();
  }
}
