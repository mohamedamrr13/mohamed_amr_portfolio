import 'package:flutter/material.dart';

class PortfolioScrollController {
  static final ScrollController scrollController = ScrollController();

  static final Map<String, GlobalKey> sectionKeys = {
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'skills': GlobalKey(),
    'contact': GlobalKey(),
  };

  static void scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }
}
