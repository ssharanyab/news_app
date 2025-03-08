part of 'news_home_bloc.dart';

@immutable
sealed class NewsHomeState {}

final class NewsHomeInitial extends NewsHomeState {}

final class FetchingNewsState extends NewsHomeState {}

final class NewsLoadedState extends NewsHomeState {
  //final List<NewsData> newsData;
  final bool hasMore;
  NewsLoadedState({required this.hasMore});
}

final class NewsErrorState extends NewsHomeState {
  final String message;

  NewsErrorState({required this.message});
}
