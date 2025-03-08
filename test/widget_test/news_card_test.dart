// Widget test for news card
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/src/news_home/data/models/news_model.dart';
import 'package:news_app/src/news_home/presentation/widgets/news_card.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late NewsData testNews;
  late MockNavigatorObserver mockObserver;

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });
  setUp(() {
    testNews = NewsData(
      title: 'Test News Title',
      description: 'This is a test description.',
      imageUrl: 'https://picsum.photos/200/',
      uuid: '122',
    );
    mockObserver = MockNavigatorObserver();
  });

  testWidgets('renders NewsCard with correct title, description, and image', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: NewsCard(newsItem: testNews)),
    ));

    expect(find.text('Test News Title'), findsOneWidget);
    expect(find.text('This is a test description.'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('tapping NewsCard navigates to details screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      navigatorObservers: [mockObserver],
      routes: {
        '/details': (context) => const Scaffold(body: Text('Details Page')),
      },
      home: Scaffold(body: NewsCard(newsItem: testNews)),
    ));

    await tester.tap(find.byType(InkResponse));
    await tester.pumpAndSettle();

    expect(find.text('Details Page'), findsOneWidget);
  });
}
