import 'package:flutter/material.dart';
import 'package:news_app/src/news_home/presentation/pages/detail_screen.dart';
import 'package:news_app/src/news_home/presentation/pages/listing_screen.dart';

import 'core/init_app.dart';

Future<void> main() async {
  initApp();
  // Explicit delay of 1sec for splash screen before starting the main App
  await Future.delayed(const Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ListingScreen(),
        '/details': (context) => DetailScreen(),
      },
    );
  }
}
