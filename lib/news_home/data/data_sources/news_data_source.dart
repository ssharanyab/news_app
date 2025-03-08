import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/news_model.dart';

part 'news_data_source.g.dart';

@RestApi(
  baseUrl: "https://api.thenewsapi.com/v1/news",
  parser: Parser.FlutterCompute,
)
abstract class NewsDatasource {
  factory NewsDatasource(Dio dio, {String baseUrl}) = _NewsDatasource;

  @GET('/all')
  Future<NewsResponse> getNews({
    @Query("api_token") required String apiToken,
    @Query("language") String language = "en",
    @Query("limit") int limit = 10,
    @Query("page") required int page,
  });
}

NewsResponse deserializeNewsResponse(Map<String, dynamic> json) => NewsResponse.fromJson(json);
