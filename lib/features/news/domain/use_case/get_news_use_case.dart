import 'package:injectable/injectable.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/domain/repository/news_repository.dart';

@LazySingleton()
final class GetNewsUseCase {
  GetNewsUseCase({required this.repository});

  final NewsRepository repository;

  Future<List<NewsArticleModel>> call() async {
    return repository.getNews();
  }
}
