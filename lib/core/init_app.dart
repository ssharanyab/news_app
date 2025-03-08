import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/news_home/data/data_sources/news_data_source.dart';
import 'package:news_app/news_home/data/repositories/news_home_repo_impl.dart';
import 'package:news_app/news_home/domain/repositories/news_home_repo.dart';
import 'package:news_app/news_home/domain/use_cases/news_usecase.dart';

GetIt getIt = GetIt.instance;

void initApp() {
  final dio = Dio();
  // Register dependecies
  getIt
    ..registerLazySingleton(() => NewsDatasource(dio))
    ..registerLazySingleton<NewsHomeRepository>(() => NewsHomeRepoImpl(getIt()))
    ..registerLazySingleton(() => GetNewsUsecase(getIt()));
}
