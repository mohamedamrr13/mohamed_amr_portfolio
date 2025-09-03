// lib/core/seo/seo_wrapper.dart
import 'package:flutter/material.dart';
import 'package:seo/seo.dart';

class SEOWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  final String description;
  final String? keywords;
  final String? image;
  final String? url;

  const SEOWrapper({
    super.key,
    required this.child,
    required this.title,
    required this.description,
    this.keywords,
    this.image,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Seo.head(
      tags: [
        // Basic meta tags
        MetaTag(name: 'title', content: title),
        MetaTag(name: 'description', content: description),
        const MetaTag(
          name: 'viewport',
          content: 'width=device-width, initial-scale=1.0',
        ),
        const MetaTag(name: 'charset', content: 'UTF-8'),

        // Keywords (if provided)
        if (keywords != null) MetaTag(name: 'keywords', content: keywords!),

        // Author and robots
        const MetaTag(name: 'author', content: 'Mohamed Amr Ibrahim'),
        const MetaTag(
          name: 'robots',
          content:
              'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1',
        ),

        // Open Graph meta tags
        MetaTag(name: 'og:title', content: title),
        MetaTag(name: 'og:description', content: description),
        const MetaTag(name: 'og:type', content: 'website'),
        const MetaTag(name: 'og:site_name', content: 'Mohamed Amr Portfolio'),
        const MetaTag(name: 'og:locale', content: 'en_US'),

        // URL (if provided)
        if (url != null) MetaTag(name: 'og:url', content: url!),

        // Image (if provided)
        if (image != null) ...[
          MetaTag(name: 'og:image', content: image!),
          const MetaTag(
            name: 'og:image:alt',
            content: 'Mohamed Amr - Flutter Developer',
          ),
        ],

        // Twitter Card meta tags
        const MetaTag(name: 'twitter:card', content: 'summary_large_image'),
        MetaTag(name: 'twitter:title', content: title),
        MetaTag(name: 'twitter:description', content: description),

        // Twitter image (if provided)
        if (image != null) ...[
          MetaTag(name: 'twitter:image', content: image!),
          const MetaTag(
            name: 'twitter:image:alt',
            content: 'Mohamed Amr - Flutter Developer',
          ),
        ],

        // Theme color
        const MetaTag(name: 'theme-color', content: '#64FFDA'),

        // Additional SEO tags
        const MetaTag(name: 'format-detection', content: 'telephone=no'),
        const MetaTag(httpEquiv: 'X-UA-Compatible', content: 'IE=edge'),

        // Canonical URL (if provided)
        if (url != null) LinkTag(rel: 'canonical', href: url!),

        // Preconnect for performance
        const LinkTag(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
        const LinkTag(rel: 'preconnect', href: 'https://github.com'),
        const LinkTag(rel: 'preconnect', href: 'https://www.upwork.com'),
      ],
      child: child,
    );
  }
}

// Usage example:
/*
SEOWrapper(
  title: 'Mohamed Amr - Flutter Developer Portfolio',
  description: 'Professional Flutter Developer specializing in Dart, Flutter, and Firebase. Experienced in building scalable, high-performance mobile and web applications.',
  keywords: 'Flutter Developer, Dart, Firebase, Mobile Development, Web Development, Cross-platform, Mohamed Amr, Portfolio, Alexandria Egypt',
  image: 'https://mamr.vercel.app/assets/images/myImage.jpg',
  url: 'https://mamr.vercel.app',
  child: MaterialApp(
    // Your app content
  ),
)
*/
