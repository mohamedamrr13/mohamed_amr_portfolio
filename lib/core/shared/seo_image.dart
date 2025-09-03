import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

class SeoImage extends StatelessWidget {
  final String imagePath;
  final String? src; // URL for SEO
  final String alt;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const SeoImage({
    super.key,
    required this.imagePath,
    this.src,
    required this.alt,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: const Icon(
              Icons.image_not_supported,
              color: Colors.grey,
              size: 50,
            ),
          );
        },
      ),
    );

    // If src is provided, wrap with SEO image widget
    if (src != null) {
      return Seo.image(src: src!, alt: alt, child: imageWidget);
    }

    return imageWidget;
  }
}
