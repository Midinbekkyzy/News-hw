import 'package:news_hw/features/news/data/models/news_model.dart';

abstract interface class NewsDataSource {
  Future<List<NewsModel>> getNews({required String query});
}
