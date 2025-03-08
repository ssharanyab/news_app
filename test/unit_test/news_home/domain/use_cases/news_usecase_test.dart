import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/core/failure.dart';
import 'package:news_app/src/news_home/data/models/news_model.dart';
import 'package:news_app/src/news_home/domain/repositories/news_home_repo.dart';
import 'package:news_app/src/news_home/domain/use_cases/news_usecase.dart';

class MockNewsHomeRepository extends Mock implements NewsHomeRepository {}

void main() {
  late MockNewsHomeRepository mockNewsHomeRepository;
  late GetNewsUsecase getNewsUsecase;

  setUp(() {
    mockNewsHomeRepository = MockNewsHomeRepository();
    getNewsUsecase = GetNewsUsecase(mockNewsHomeRepository);
  });

  group('getNews', () {
    const int testPage = 1;
    final NewsResponse mockNewsResponse = NewsResponse(
      data: [
        NewsData(
          title: 'Sample News Title',
          description: 'Sample Description',
          imageUrl: 'https://picsum.photos/200/',
          uuid: '11',
        ),
      ],
      meta: Meta(found: 1, returned: 1, limit: 1, page: 1),
    );

    test('WHEN getNews is successful THEN returns Right(NewsResponse)', () async {
      // Arrange
      when(() => mockNewsHomeRepository.getNewsResponse(page: testPage)).thenAnswer((_) async => Right(mockNewsResponse));

      // Act
      final result = await getNewsUsecase.getNews(page: testPage);

      // Assert
      expect(result, isA<Right<Failure, NewsResponse>>());
    });

    test('WHEN getNews fails THEN returns Left(Failure)', () async {
      // Arrange
      final failure = Failure(message: 'Server Error', statusCode: 500);
      when(() => mockNewsHomeRepository.getNewsResponse(page: testPage)).thenAnswer((_) async => Left(failure));

      // Act
      final result = await getNewsUsecase.getNews(page: testPage);

      // Assert
      expect(result, isA<Left<Failure, NewsResponse>>());
      result.fold(
        (failure) {
          expect(failure.message, 'Server Error');
          expect(failure.statusCode, 500);
        },
        (_) => fail('Expected a Failure but got a success response.'),
      );
    });
  });
}
