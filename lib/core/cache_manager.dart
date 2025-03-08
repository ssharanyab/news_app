import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static final instance = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 7), // Cache for 7 days
      maxNrOfCacheObjects: 10000, // Store up to 1000 images
    ),
  );
}
