import 'package:news_app/core/typedef.dart';

import '../../data/models/news_model.dart';
import '../repositories/news_home_repo.dart';

class GetNewsUsecase {
  final NewsHomeRepository _newsHomeRepository;

  GetNewsUsecase(this._newsHomeRepository);
  ResultFuture<NewsResponse> getNews({required int page}) {
    return _newsHomeRepository.getNewsResponse(page: page);
  }
}
