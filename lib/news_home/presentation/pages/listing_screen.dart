import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_home/data/models/news_model.dart';
import 'package:news_app/news_home/presentation/manager/news_home_bloc.dart';

import '../../../core/init_app.dart';
import '../widgets/news_card.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final _scrollController = ScrollController();
  final _newsBloc = getIt<NewsHomeBloc>();

  @override
  void initState() {
    _newsBloc.add(GetNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Listing Screen'),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsHomeBloc, NewsHomeState>(
        bloc: _newsBloc,
        builder: (context, state) {
          if (state is NewsHomeInitial || state is FetchingNewsState && _newsBloc.articles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsErrorState) {
            return Center(child: Text(state.message));
          }
          if (state is NewsLoadedState) {
            final List<NewsData> items = _newsBloc.articles;
            return NotificationListener(
              onNotification: (scrollInfo) {
                if (scrollInfo is ScrollEndNotification && _scrollController.position.extentAfter <= 170) {
                  _newsBloc.add(GetNewsEvent());
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: items.length + (state.hasMore ? 1 : 0),
                cacheExtent: 1000,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemBuilder: (context, index) {
                  if (index >= items.length) {
                    // Request for next set of newsData when less than 4.
                    // This is done as the API has limitation of 3 articles per fetch in free tier
                    if (_newsBloc.articles.length < 4) {
                      _newsBloc.add(GetNewsEvent());
                    }
                    // Show loader at the bottom during pagination
                    return const Center(child: CircularProgressIndicator());
                  }
                  return NewsCard(newsItem: items[index]);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
