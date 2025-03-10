import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/core/env/env.dart';
import 'package:news_app/core/failure.dart';
import 'package:news_app/core/typedef.dart';

import '../../domain/repositories/news_home_repo.dart';
import '../data_sources/news_data_source.dart';
import '../models/news_model.dart';

class NewsHomeRepoImpl implements NewsHomeRepository {
  final NewsDatasource _newsDatasource;

  NewsHomeRepoImpl(this._newsDatasource);

  @override
  ResultFuture<NewsResponse> getNewsResponse({required int page}) async {
    try {
      final result = await _newsDatasource.getNews(apiToken: Env.NEWS_API_KEY, page: page);
      return Right(result);
    } on DioException catch (error) {
      return Left(Failure(
        message: error.response?.statusMessage ?? 'Something went wrong',
        statusCode: error.response?.statusCode ?? 404,
      ));
    }
  }
}
