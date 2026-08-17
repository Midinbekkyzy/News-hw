part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

final class GetNewsEvent extends NewsEvent {
  GetNewsEvent({this.query = 'sport'});

  final String query;
}

final class SearchNewsEvent extends NewsEvent {
  SearchNewsEvent({required this.query});

  final String query;
}
