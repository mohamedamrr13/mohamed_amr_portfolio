// lib/core/shared/background_widget.dart
import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:newton_particles/newton_particles.dart' hide Velocity;

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
  LinearGradient _getBackgroundGradient(BuildContext context) {
    try {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
      return themeProvider.isDarkMode
          ? const LinearGradient(
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
          )
          : const LinearGradient(
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
    } catch (e) {
      return _modernBackgroundGradient;
    }
  }

  int _getResponsiveParticleCount() {
    return WidgetsBinding
                .instance
                .platformDispatcher
                .views
                .first
                .physicalSize
                .width >
            1000
        ? 25
        : 15;
  }

  List<RelativisticEffectConfiguration> _createParticleEffects(
    bool isDarkMode,
  ) {
    final particleCount = widget.particleCount ?? _getResponsiveParticleCount();
    final baseColor =
        isDarkMode ? AppColors.primaryColor : const Color(0xFF6B7FD7);

    // Create multiple effect configurations for variety
    return [
      // Main floating particles
      RelativisticEffectConfiguration(
        gravity: Gravity.zero,
        maxAngle: 360,
        minAngle: 0,
        maxEndScale: 1.2,
        minEndScale: 0.8,
        maxFadeOutThreshold: 0.9,
        minFadeOutThreshold: 0.7,
        maxOriginOffset: Offset(MediaQuery.of(context).size.width, 0),
        minOriginOffset: const Offset(0, 0),
        maxParticleLifespan: Duration(
          seconds: (15 / widget.animationSpeed).round(),
        ),
        minParticleLifespan: Duration(
          seconds: (10 / widget.animationSpeed).round(),
        ),
        origin: const Offset(-50, -50),
        particleConfiguration: const ParticleConfiguration(
          shape: CircleShape(),
          size: Size(2, 2),
        ),
      ),

      // Slower drifting particles
      RelativisticEffectConfiguration(
        particleCount: (particleCount * 0.3).round(),
        trail: const StraightTrail(trailProgress: 2, trailWidth: 3),
        gravity: Gravity.zero,
        maxAngle: 360,
        minAngle: 0,
        maxEndScale: 1.5,
        minEndScale: 0.5,
        maxFadeOutThreshold: 0.8,
        minFadeOutThreshold: 0.6,
        maxOriginOffset: Offset(MediaQuery.of(context).size.width, 0),
        minOriginOffset: const Offset(0, 0),
        maxParticleLifespan: Duration(
          seconds: (25 / widget.animationSpeed).round(),
        ),
        minParticleLifespan: Duration(
          seconds: (20 / widget.animationSpeed).round(),
        ),

        origin: const Offset(-50, -50),
        particleConfiguration: const ParticleConfiguration(
          shape: CircleShape(),
          size: Size(3, 3),
        ),
      ),

      // Subtle accent particles
      RelativisticEffectConfiguration(
        gravity: Gravity.zero,
        maxAngle: 360,
        minAngle: 0,
        maxEndScale: 2.0,
        minEndScale: 1.0,
        maxFadeOutThreshold: 0.7,
        minFadeOutThreshold: 0.5,
        maxOriginOffset: Offset(MediaQuery.of(context).size.width, 0),
        minOriginOffset: const Offset(0, 0),
        maxParticleLifespan: Duration(
          seconds: (30 / widget.animationSpeed).round(),
        ),
        minParticleLifespan: Duration(
          seconds: (25 / widget.animationSpeed).round(),
        ),

        origin: const Offset(-50, -50),
        particleConfiguration: ParticleConfiguration(
          shape: const CircleShape(),
          size: const Size(1, 1),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(gradient: _getBackgroundGradient(context)),
      child: Stack(
        children: [
          if (widget.enableParticles)
            RepaintBoundary(
              child: Newton(
                effectConfigurations: _createParticleEffects(isDarkMode),
              ),
            ),

          // Keep all the existing gradient layers
          Container(
            decoration: BoxDecoration(
              gradient:
                  isDarkMode
                      ? _depthGradientLayer1Dark
                      : _depthGradientLayer1Light,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient:
                  isDarkMode
                      ? _depthGradientLayer2Dark
                      : _depthGradientLayer2Light,
            ),
          ),
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

  // Keep all the existing gradient definitions
  static const LinearGradient _modernBackgroundGradient = LinearGradient(
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
