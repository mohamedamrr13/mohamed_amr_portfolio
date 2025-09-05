// lib/core/utils/responsive.dart
import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints
  static const double mobileMaxWidth = 768;
  static const double tabletMaxWidth = 1024;
  static const double desktopMaxWidth = 1440;

  // Screen type checks
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWidth;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMaxWidth;

  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopMaxWidth;

  // Screen dimensions
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Responsive values
  static T getValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    ;
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  // Font sizes
  static double getFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return getValue<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      desktop: desktop ?? mobile * 1.2,
    );
  }

  // Padding and margins
  static EdgeInsets getPadding(BuildContext context) {
    return getValue<EdgeInsets>(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      tablet: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      desktop: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
    );
  }

  static double getHorizontalPadding(BuildContext context) {
    return getValue<double>(context, mobile: 16, tablet: 32, desktop: 48);
  }

  static double getVerticalPadding(BuildContext context) {
    return getValue<double>(context, mobile: 24, tablet: 32, desktop: 40);
  }

  // Grid and layout
  static int getCrossAxisCount(BuildContext context) {
    return getValue<int>(context, mobile: 1, tablet: 2, desktop: 3);
  }

  static double getChildAspectRatio(BuildContext context) {
    return getValue<double>(context, mobile: 0.9, tablet: 0.85, desktop: 0.8);
  }

  // Spacing
  static double getSpacing(BuildContext context, {double multiplier = 1.0}) {
    final baseSpacing = getValue<double>(
      context,
      mobile: 16,
      tablet: 20,
      desktop: 24,
    );
    return baseSpacing * multiplier;
  }

  // Icon sizes
  static double getIconSize(BuildContext context, {double multiplier = 1.0}) {
    final baseSize = getValue<double>(
      context,
      mobile: 20,
      tablet: 22,
      desktop: 24,
    );
    return baseSize * multiplier;
  }

  // Button sizes
  static Size getButtonSize(BuildContext context) {
    return getValue<Size>(
      context,
      mobile: const Size(140, 45),
      tablet: const Size(150, 48),
      desktop: const Size(160, 50),
    );
  }

  // Container constraints
  static double getMaxContentWidth(BuildContext context) {
    return getValue<double>(
      context,
      mobile: double.infinity,
      tablet: 800,
      desktop: 1000,
    );
  }

  // Helper for responsive widgets
  static Widget responsive(
    BuildContext context, {
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
    Widget? largeDesktop,
  }) {
    return getValue<Widget>(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
