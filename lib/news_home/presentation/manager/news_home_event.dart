part of 'news_home_bloc.dart';

@immutable
sealed class NewsHomeEvent {}

final class GetNewsEvent extends NewsHomeEvent {}
