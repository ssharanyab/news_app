import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/news_home/data/models/news_model.dart';

import '../../domain/use_cases/news_usecase.dart';

part 'news_home_event.dart';
part 'news_home_state.dart';

class NewsHomeBloc extends Bloc<NewsHomeEvent, NewsHomeState> {
  final GetNewsUsecase _getNewsUsecase;
  NewsHomeBloc(this._getNewsUsecase) : super(NewsHomeInitial()) {
    on<GetNewsEvent>(_handleGetNewsEvent);
  }
  _handleGetNewsEvent(event, emit) async {
    emit(FetchingNewsState());
    final result = await _getNewsUsecase.getNews();

    result.fold(
      (l) => emit(NewsErrorState()),
      (r) {
        emit(NewsLoadedState(newsResponse: r));
      },
    );
  }
}
