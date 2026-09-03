import 'package:injectable/injectable.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/domain/repository/news_repository.dart';
import 'package:paging_view/paging_view.dart';

@injectable
final class NewsPagingAdapter extends DataSource<int, NewsArticleModel> {
  static const int pageSize = 20;
  static const int firstPage = 1;

  NewsPagingAdapter({required this.newsRepository});

  final NewsRepository newsRepository;

  @override
  Future<LoadResult<int, NewsArticleModel>> load(LoadAction<int> action) async {
    return switch (action) {
      Refresh() => _getData(firstPage),
      Append(:final key) => _getData(key),
      Prepend() => const None(),
    };
  }

  Future<LoadResult<int, NewsArticleModel>> _getData(int page) async {
    try {
      final newsResponseEntity = await newsRepository.getNewsPaging(
        pageSize: pageSize,
        page: page,
      );

      final loadedCount =
          ((page - 1) * pageSize) + newsResponseEntity.articles.length;

      final hasMoreData =
          newsResponseEntity.articles.isNotEmpty &&
          page < 5 &&
          loadedCount < newsResponseEntity.totalResults;

      int? nextPage;
      if (hasMoreData) {
        nextPage = page + 1;
      }

      return Success(
        page: PageData(
          data: newsResponseEntity.articles,
          appendKey: nextPage,
        ),
      );
    } catch (e) {
      return Failure(e: e is Exception ? e : Exception(e.toString()));
    }
  }
}
