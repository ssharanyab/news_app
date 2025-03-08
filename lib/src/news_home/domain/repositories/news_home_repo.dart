import '../../../../core/typedef.dart';
import '../../data/models/news_model.dart';

abstract interface class NewsHomeRepository {
  ResultFuture<NewsResponse> getNewsResponse({required int page});
}
