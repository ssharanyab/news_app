import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/news_home/data/models/news_model.dart';

import '../../../core/cache_manager.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final List<NewsData> items = List.generate(
    150,
    (index) => NewsData(
      uuid: '111',
      title: "Item $index",
      description: "This is the description for item $index.",
      imageUrl: "https://picsum.photos/200/${index + 100}",
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Listing Screen'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        cacheExtent: 1000, // Adjust this value based on grid size

        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemBuilder: (context, index) {
          return InkResponse(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: items[index].imageUrl!,
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
                    tag: items[index].imageUrl!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: CachedNetworkImage(
                        imageUrl: items[index].imageUrl!,
                        cacheManager: CustomCacheManager.instance,
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        useOldImageOnUrlChange: true,
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
                      items[index].title!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      items[index].description,
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
}
