import 'package:news_hw/features/news/data/models/news_model.dart';

abstract interface class NewsDataSource {
  Future<List<NewsModel>> getNews({required String query});

  Future<NewsResponseModel> getNewsPaging({
    required int pageSize,
    required int page,
  });
}
