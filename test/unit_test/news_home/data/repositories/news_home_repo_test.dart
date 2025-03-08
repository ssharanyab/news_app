import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/failure.dart';
import 'package:news_app/src/news_home/data/data_sources/news_data_source.dart';
import 'package:news_app/src/news_home/data/models/news_model.dart';
import 'package:news_app/src/news_home/data/repositories/news_home_repo_impl.dart';

class MockNewsDatasource extends Mock implements NewsDatasource {}

void main() {
  late MockNewsDatasource mockNewsDatasource;
  late NewsHomeRepoImpl newsHomeRepoImpl;

  setUp(() {
    mockNewsDatasource = MockNewsDatasource();
    newsHomeRepoImpl = NewsHomeRepoImpl(mockNewsDatasource);
  });

  group('getNewsResponse', () {
    const int testPage = 1;
    final NewsResponse mockNewsResponse = NewsResponse(
      data: [
        NewsData(
          title: 'Sample News Title',
          description: 'Sample Description',
          imageUrl: 'https://picsum.photos/200/',
          uuid: '11',
        )
      ],
      meta: Meta(found: 1, returned: 1, limit: 1, page: 1),
    );

    test('WHEN getNews is successful THEN returns Right(NewsResponse)', () async {
      // Arrange
      when(() => mockNewsDatasource.getNews(apiToken: any(named: 'apiToken'), page: testPage)).thenAnswer((_) async => mockNewsResponse);

      // Act
      final result = await newsHomeRepoImpl.getNewsResponse(page: testPage);

      // Assert
      expect(result, isA<Right<Failure, NewsResponse>>());
    });

    test('WHEN getNews throws DioException THEN returns Left(Failure)', () async {
      // Arrange
      when(() => mockNewsDatasource.getNews(apiToken: any(named: 'apiToken'), page: testPage)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
          statusMessage: 'Not Found',
        ),
        type: DioExceptionType.badResponse,
      ));

      // Act
      final result = await newsHomeRepoImpl.getNewsResponse(page: testPage);

      // Assert
      expect(result, isA<Left<Failure, NewsResponse>>());
      result.fold(
        (failure) {
          expect(failure.message, 'Not Found');
          expect(failure.statusCode, 404);
        },
        (_) => fail('Expected a Failure but got a success response.'),
      );
    });
  });
}
