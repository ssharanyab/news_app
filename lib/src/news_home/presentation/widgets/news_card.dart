import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/cache_manager.dart';
import '../../data/models/news_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.newsItem,
  });

  final NewsData newsItem;

  @override
  Widget build(BuildContext context) {
    // Fallback image if API response does not give imageURL
    final imageUrl = newsItem.imageUrl ?? 'https://picsum.photos/200/${math.Random().nextInt(20) + 100}';
    return InkResponse(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: imageUrl);
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
                  errorWidget: (context, url, error) {
                    log("Error while loading image: $error");
                    return const Icon(Icons.error);
                  },
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    log("Loading from network: $url - ${downloadProgress.progress}");
                    return Center(child: CircularProgressIndicator(value: downloadProgress.progress));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                newsItem.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                newsItem.description,
                overflow: TextOverflow.fade,
                softWrap: true,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
