
import 'package:flutter/material.dart';

class MapImage extends StatelessWidget {
  final String mapUrl;

  const MapImage({Key? key, required this.mapUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      mapUrl,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Icon(Icons.error, color: Colors.red, size: 50);
      },
    );
  }
}