import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_hw/features/news/data/data_source/abstract/news_data_source.dart';
import 'package:news_hw/features/news/data/models/news_model.dart';

@LazySingleton(as: NewsDataSource)
class NewsDataSourceImpl implements NewsDataSource {
  NewsDataSourceImpl({required this.dio});

  final Dio dio;

  static const String _apiKey = 'f494a8cffbd9412a8737eed79f30c1bb';

  @override
  Future<List<NewsModel>> getNews({required String query}) async {
    final Response response = await dio.get(
      'v2/everything',
      queryParameters: {
        'q': query,
        'sortBy': 'publishedAt',
        'pageSize': 20,
        'apiKey': _apiKey,
      },
    );
    final list = response.data['articles'] as List;
    return list.map((model) => NewsModel.fromJson(model)).toList();
  }

  @override
  Future<NewsResponseModel> getNewsPaging({
    required int pageSize,
    required int page,
  }) async {
    final Response response = await dio.get(
      'v2/everything',
      queryParameters: {
        'q': 'sport',
        'sortBy': 'publishedAt',
        'pageSize': pageSize,
        'page': page,
        'apiKey': _apiKey,
      },
    );
    return NewsResponseModel.fromJson(response.data);
  }
}
