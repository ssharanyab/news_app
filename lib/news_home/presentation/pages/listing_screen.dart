import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_home/data/models/news_model.dart';
import 'package:news_app/news_home/presentation/manager/news_home_bloc.dart';

import '../../../core/cache_manager.dart';
import '../../../core/init_app.dart';

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
    _scrollController.addListener(_onScroll);
    _newsBloc.add(GetNewsEvent());
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      if (_newsBloc.state is NewsLoadedState && (_newsBloc.state as NewsLoadedState).hasMore) {
        _newsBloc.add(GetNewsEvent());
      }
    }
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
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemCount: items.length + (state.hasMore ? 1 : 0),
                cacheExtent: 1000,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemBuilder: (context, index) {
                  if (index >= items.length) {
                    // Request for next set of artucles.
                    if (_newsBloc.articles.length < 9) {
                      _newsBloc.add(GetNewsEvent());
                    }
                    // Show loader at the bottom during pagination
                    return const Center(child: CircularProgressIndicator());
                  }
                  final imageUrl = items[index].imageUrl ?? 'https://picsum.photos/200/${index + 100}';
                  return InkResponse(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: imageUrl,
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: imageUrl,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                cacheManager: CustomCacheManager.instance,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                fadeInDuration: Duration.zero,
                                fadeOutDuration: Duration.zero,
                                useOldImageOnUrlChange: true,
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                progressIndicatorBuilder: (context, url, downloadProgress) {
                                  print("Loading from network: $url - ${downloadProgress.progress}");
                                  return Center(child: CircularProgressIndicator(value: downloadProgress.progress));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              items[index].title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              items[index].description,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
