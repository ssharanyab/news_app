import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/src/news_home/data/data_sources/news_data_source.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions get options => BaseOptions();
}

class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late MockDio mockDio;
  late NewsDatasource newsDatasource;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDio = MockDio();
    newsDatasource = NewsDatasource(mockDio);
  });

  group('getNews', () {
    const String apiToken = 'test_api_key';
    const int page = 1;
    const int limit = 10;

    // TODO: Success test cases is failing. To be checked
    test('WHEN API fails THEN throws DioException', () async {
      when(() => mockDio.fetch<Map<String, dynamic>>(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: ''),
            statusCode: 404,
            data: {'message': 'Not Found'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      expect(
        () async => await newsDatasource.getNews(apiToken: apiToken, page: page, limit: limit),
        throwsA(isA<DioException>()),
      );
    });
  });
}
