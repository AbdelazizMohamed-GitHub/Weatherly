import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCachedWeatherImage extends StatelessWidget {
  const CustomCachedWeatherImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();
    if (url == null || url.isEmpty) {
      return _imageFallback();
    }

    return CachedNetworkImage(
      imageUrl: url.startsWith('//') ? 'https:$url' : url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          Skeletonizer(enabled: true, child: _imageFallback()),
      errorWidget: (context, url, error) => _imageFallback(),
    );
  }

  Widget _imageFallback() => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(Icons.cloud_off, color: Colors.grey),
        ),
      );
}
