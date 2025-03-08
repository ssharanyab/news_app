import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/news_model.dart';
import '../../domain/use_cases/news_usecase.dart';

part 'news_home_event.dart';
part 'news_home_state.dart';

class NewsHomeBloc extends Bloc<NewsHomeEvent, NewsHomeState> {
  final GetNewsUsecase _getNewsUsecase;

  int page = 1;
  bool hasMore = true;
  List<NewsData> articles = [];

  NewsHomeBloc(this._getNewsUsecase) : super(NewsHomeInitial()) {
    on<GetNewsEvent>(_handleGetNewsEvent);
  }
  _handleGetNewsEvent(event, emit) async {
    final currentState = state;

    if (currentState is NewsLoadedState && !currentState.hasMore) return;

    final result = await _getNewsUsecase.getNews(page: page);
    result.fold(
      (l) {
        emit(NewsErrorState(message: l.message));
      },
      (r) {
        hasMore = r.meta.found > (r.meta.page * r.meta.limit);
        if (hasMore) page++;
        articles.addAll(r.data);
        emit(NewsLoadedState(hasMore: hasMore));
      },
    );
  }
}
