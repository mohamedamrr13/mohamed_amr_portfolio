import 'package:flutter/material.dart';
import 'package:seo/seo.dart';
import 'package:url_launcher/url_launcher.dart';

class SeoLink extends StatelessWidget {
  final String href;
  final String anchor;
  final Widget child;
  final String? rel; // nofollow, noopener, etc.

  const SeoLink({
    super.key,
    required this.href,
    required this.anchor,
    required this.child,
    this.rel,
  });

  @override
  Widget build(BuildContext context) {
    return Seo.link(
      href: href,
      anchor: anchor,
      rel: rel,
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(href);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: child,
      ),
    );
  }
}
