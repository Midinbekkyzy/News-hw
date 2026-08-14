import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_hw/features/news/data/data_source/abstract/news_data_source.dart';
import 'package:news_hw/features/news/data/models/news_model.dart';

final class _ApiPath {
  static const String getNews =
      'v2/everything?q=sport&sortBy=publishedAt&pageSize=20&apiKey=f494a8cffbd9412a8737eed79f30c1bb';
}

@LazySingleton(as: NewsDataSource)
class NewsDataSourceImpl implements NewsDataSource {
  NewsDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List<NewsModel>> getNews() async {
    final Response response = await dio.get(_ApiPath.getNews);
    final list = response.data['articles'] as List;
    return list.map((model) => NewsModel.fromJson(model)).toList();
  }
}
