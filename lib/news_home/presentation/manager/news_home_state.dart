part of 'news_home_bloc.dart';

@immutable
sealed class NewsHomeState {}

final class NewsHomeInitial extends NewsHomeState {}

final class FetchingNewsState extends NewsHomeState {}

final class NewsLoadedState extends NewsHomeState {
  final NewsResponse _newsResponse;

  NewsLoadedState({required NewsResponse newsResponse}) : _newsResponse = newsResponse;
}

final class NewsErrorState extends NewsHomeState {}
