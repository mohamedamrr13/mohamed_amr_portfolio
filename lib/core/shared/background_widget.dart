import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

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

class _BackgroundWidgetState extends State<BackgroundWidget>
    with SingleTickerProviderStateMixin {
  // Cache the gradient to avoid recreating it on every build
  LinearGradient? _cachedGradient;
  bool? _lastThemeMode;
  AnimationController? _particleController;

  @override
  void initState() {
    super.initState();
    if (widget.enableParticles) {
      _particleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: (10 / widget.animationSpeed).round()),
      )..repeat();
    }
  }

  @override
  void dispose() {
    _particleController?.dispose();
    super.dispose();
  }

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
    return widget.particleCount ?? (size.width > 1000 ? 25 : 15);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(gradient: getBackgroundGradient(context)),
      child: Stack(
        children: [
          // First depth layer (radial gradient like HTML ::before)
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, 0.0),
                radius: 1.0,
                colors: [
                  isDarkMode
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : const Color(0xFF4A69BD).withOpacity(0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5],
              ),
            ),
          ),
          // Second depth layer (horizontal gradient)
          Container(
            decoration: BoxDecoration(
              gradient:
                  isDarkMode
                      ? _depthGradientLayerDark
                      : _depthGradientLayerLight,
            ),
          ),
          // Particle layer (simulating HTML ::after particles)
          if (widget.enableParticles)
            AnimatedBuilder(
              animation: _particleController!,
              builder: (context, _) {
                return CustomPaint(
                  painter: ParticlePainter(
                    animationValue: _particleController!.value,
                    particleCount: getResponsiveParticleCount(context),
                    isDarkMode: isDarkMode,
                  ),
                  size: MediaQuery.of(context).size,
                );
              },
            ),
          // Light mode overlay
          if (!isDarkMode)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFF5F7FA).withOpacity(0.4),
                    Colors.transparent,
                    const Color(0xFFF8FAFF).withOpacity(0.2),
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

  // Space-themed gradients matching index.html
  static const LinearGradient _darkModeGradient = LinearGradient(
    begin: Alignment(-0.8, -1.0),
    end: Alignment(1.2, 1.0),
    colors: [
      Color(0xFF0A0E27),
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
      Color(0xFFE6E9F0),
      Color(0xFFDCE3F2),
      Color(0xFFD1DAEB),
      Color(0xFFC7D2E8),
      Color(0xFFE6E9F0),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static  final LinearGradient _depthGradientLayerDark = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF0A0E27).withOpacity(0.05),
      Colors.transparent,
      Color(0xFF16213E).withOpacity(0.05),
    ],
    stops: const [0.0, 0.5, 1.0],
  );

  static  final LinearGradient _depthGradientLayerLight = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF4A69BD).withOpacity(0.05),
      Colors.transparent,
      Color(0xFF6B7280).withOpacity(0.05),
    ],
    stops: const [0.0, 0.5, 1.0],
  );
}

class ParticlePainter extends CustomPainter {
  final double animationValue;
  final int particleCount;
  final bool isDarkMode;

  ParticlePainter({
    required this.animationValue,
    required this.particleCount,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(
      42,
    ); // Consistent seed for stable particle positions
    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..color =
              isDarkMode
                  ? AppColors.primaryColor.withOpacity(0.3)
                  : const Color(0xFF4A69BD).withOpacity(0.2);

    for (int i = 0; i < particleCount; i++) {
      // Generate consistent positions
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1; // 1 to 3 pixels

      // Animate particles with slight movement
      final offsetX = math.sin(animationValue * 2 * math.pi + i) * 50;
      final offsetY = math.cos(animationValue * 2 * math.pi + i) * 50;

      canvas.drawCircle(
        Offset(x + offsetX, y + offsetY),
        radius,
        paint
          ..color =
              isDarkMode
                  ? AppColors.primaryColor.withOpacity(
                    0.2 + random.nextDouble() * 0.1,
                  )
                  : const Color(
                    0xFF4A69BD,
                  ).withOpacity(0.1 + random.nextDouble() * 0.1),
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        particleCount != oldDelegate.particleCount ||
        isDarkMode != oldDelegate.isDarkMode;
  }
}
