import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: InteractiveViewer(
            scaleFactor: 1000,
            boundaryMargin: EdgeInsets.all(0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              fit: BoxFit.fitHeight,
              fadeInDuration: Duration.zero, // ✅ Instant load if cached
              fadeOutDuration: Duration.zero,
            ),
          ),
        ),
      ),
    );
  }
}
