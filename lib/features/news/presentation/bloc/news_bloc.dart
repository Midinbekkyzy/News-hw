import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/domain/use_case/get_news_use_case.dart';

part 'news_event.dart';
part 'news_state.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNews;

  NewsBloc({required this.getNews}) : super(NewsInitial()) {
    on<GetNewsEvent>(_onGetNews);
    on<SearchNewsEvent>(_onSearchNews);
  }

  Future<void> _onGetNews(
    GetNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    await _load(query: event.query, emit: emit);
  }

  Future<void> _onSearchNews(
    SearchNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    final query = event.query.trim().isEmpty ? 'sport' : event.query.trim();
    await _load(query: query, emit: emit);
  }

  Future<void> _load({
    required String query,
    required Emitter<NewsState> emit,
  }) async {
    try {
      emit(LoadingNewsState());
      final List<NewsArticleModel> list = await getNews.call(query: query);
      emit(LoadedNewsState(news: list, query: query));
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(ErrorNewsState(message: e.toString()));
    }
  }
}
