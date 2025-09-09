import 'package:flutter/material.dart';
import 'package:seo/seo.dart';
import 'home_screen.dart';

class HomeScreenWithSEO extends StatelessWidget {
  const HomeScreenWithSEO({super.key});

  @override
  Widget build(BuildContext context) {
    return Seo.head(
      tags: const [
        // Basic meta tags
        MetaTag(
          name: 'title',
          content: 'Mohamed Amr - Flutter Developer Portfolio',
        ),
        MetaTag(
          name: 'description',
          content:
              'Professional Flutter Developer specializing in Dart, Flutter, and Firebase. Experienced in building scalable, high-performance mobile and web applications with modern development practices.',
        ),
        MetaTag(
          name: 'keywords',
          content:
              'Flutter Developer, Dart Programming, Firebase Integration, Mobile Development, Web Development, Cross-platform Apps, Mohamed Amr, Portfolio, Alexandria Egypt, Freelance Developer, UI/UX Development',
        ),
        MetaTag(name: 'author', content: 'Mohamed Amr Ibrahim'),
        MetaTag(
          name: 'robots',
          content:
              'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1',
        ),

        // Open Graph meta tags - Note: property attribute not supported, using alternative approach
        MetaTag(
          name: 'og:title',
          content: 'Mohamed Amr - Flutter Developer Portfolio',
        ),
        MetaTag(
          name: 'og:description',
          content:
              'Professional Flutter Developer specializing in Dart, Flutter, and Firebase. Building scalable mobile and web applications.',
        ),
        MetaTag(
          name: 'og:image',
          content: 'https://mamr.vercel.app/assets/images/myImage.jpg',
        ),
        MetaTag(
          name: 'og:image:alt',
          content: 'Mohamed Amr - Flutter Developer',
        ),
        MetaTag(name: 'og:url', content: 'https://mamr.vercel.app'),
        MetaTag(name: 'og:type', content: 'website'),
        MetaTag(name: 'og:site_name', content: 'Mohamed Amr Portfolio'),
        MetaTag(name: 'og:locale', content: 'en_US'),

        // Twitter Card meta tags
        MetaTag(name: 'twitter:card', content: 'summary_large_image'),
        MetaTag(
          name: 'twitter:title',
          content: 'Mohamed Amr - Flutter Developer Portfolio',
        ),
        MetaTag(
          name: 'twitter:description',
          content:
              'Professional Flutter Developer specializing in Dart, Flutter, and Firebase. Building scalable mobile and web applications.',
        ),
        MetaTag(
          name: 'twitter:image',
          content: 'https://mamr.vercel.app/assets/images/myImage.jpg',
        ),
        MetaTag(
          name: 'twitter:image:alt',
          content: 'Mohamed Amr - Flutter Developer',
        ),

        // Additional meta tags
        MetaTag(name: 'theme-color', content: '#64FFDA'),
        MetaTag(name: 'msapplication-TileColor', content: '#0A0E27'),
        MetaTag(name: 'format-detection', content: 'telephone=no'),
        MetaTag(httpEquiv: 'X-UA-Compatible', content: 'IE=edge'),

        // Canonical and preconnect links
        LinkTag(rel: 'canonical', href: 'https://mamr.vercel.app'),
        LinkTag(rel: 'preconnect', href: 'https://fonts.googleapis.com'),
        LinkTag(rel: 'preconnect', href: 'https://github.com'),
        LinkTag(rel: 'preconnect', href: 'https://www.upwork.com'),
      ],
      child: const HomeScreen(),
    );
  }
}
