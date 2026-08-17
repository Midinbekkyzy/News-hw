import 'package:injectable/injectable.dart';
import 'package:news_hw/core/util/transformable.dart';
import 'package:news_hw/features/news/data/data_source/abstract/news_data_source.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/domain/repository/news_repository.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl({required this.dataSource});

  final NewsDataSource dataSource;

  @override
  Future<List<NewsArticleModel>> getNews({required String query}) async {
    final data = await dataSource.getNews(query: query);
    return data.transform();
  }
}
