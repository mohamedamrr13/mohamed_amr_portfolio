// lib/core/shared/background_widget.dart
import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:provider/provider.dart';

class BackgroundWidget extends StatefulWidget {
  final Widget child;
  final bool enableParticles;
  final int? particleCount;
  final double animationSpeed;

  const BackgroundWidget({
    super.key,
    required this.child,
    this.enableParticles = true,
    this.particleCount,
    this.animationSpeed = 1.0,
  });

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  // Cache the gradient to avoid recreating it on every build
  LinearGradient? _cachedGradient;
  bool? _lastThemeMode;

  LinearGradient getBackgroundGradient(BuildContext context) {
    try {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

      // Only recreate gradient if theme changed
      if (_cachedGradient == null ||
          _lastThemeMode != themeProvider.isDarkMode) {
        _lastThemeMode = themeProvider.isDarkMode;
        _cachedGradient =
            themeProvider.isDarkMode ? _darkModeGradient : _lightModeGradient;
      }

      return _cachedGradient!;
    } catch (e) {
      return _darkModeGradient;
    }
  }

  int getResponsiveParticleCount(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > 1000 ? 25 : 15;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(gradient: getBackgroundGradient(context)),
      child: Stack(
        children: [
          // First depth layer
          Container(
            decoration: BoxDecoration(
              gradient:
                  isDarkMode
                      ? _depthGradientLayer1Dark
                      : _depthGradientLayer1Light,
            ),
          ),
          // Second depth layer
          Container(
            decoration: BoxDecoration(
              gradient:
                  isDarkMode
                      ? _depthGradientLayer2Dark
                      : _depthGradientLayer2Light,
            ),
          ),
          // Accent gradient
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.3, -0.7),
                radius: 1.2,
                colors: [
                  isDarkMode
                      ? AppColors.primaryColor.withOpacity(0.08)
                      : const Color(0xFF4A69BD).withOpacity(0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.7],
              ),
            ),
          ),
          // Light mode overlay
          if (!isDarkMode)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFDFDFE).withOpacity(0.5),
                    Colors.transparent,
                    const Color(0xFFF8FAFF).withOpacity(0.3),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          widget.child,
        ],
      ),
    );
  }

  // Static gradients for better performance
  static const LinearGradient _darkModeGradient = LinearGradient(
    begin: Alignment(-0.8, -1.0),
    end: Alignment(1.2, 1.0),
    colors: [
      Color(0xFF0A0A0F),
      Color(0xFF1A1A2E),
      Color(0xFF16213E),
      Color(0xFF0F3460),
      Color(0xFF1A1A2E),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static const LinearGradient _lightModeGradient = LinearGradient(
    begin: Alignment(-0.8, -1.0),
    end: Alignment(1.2, 1.0),
    colors: [
      Color(0xFFFDFDFE),
      Color(0xFFF8FAFF),
      Color(0xFFF0F4FC),
      Color(0xFFE8F0FF),
      Color(0xFFF5F7FA),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static const LinearGradient _depthGradientLayer1Dark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0x0D533483), Colors.transparent],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient _depthGradientLayer2Dark = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0x0A00D4FF), Colors.transparent, Color(0x0A7C4DFF)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient _depthGradientLayer1Light = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0x08DFF9FB), Colors.transparent],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient _depthGradientLayer2Light = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0x0574B1F7), Colors.transparent, Color(0x059575E3)],
    stops: [0.0, 0.5, 1.0],
  );
}
